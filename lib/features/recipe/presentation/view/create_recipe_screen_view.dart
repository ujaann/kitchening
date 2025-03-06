import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kitchening/app/common/gap.dart';
import 'package:kitchening/app/common/my_snackbar.dart';
import 'package:kitchening/app/common/styles.dart';
import 'package:kitchening/features/recipe/presentation/view/common/recipe_ingredients.dart';
import 'package:kitchening/features/recipe/presentation/view/common/recipe_steps.dart';
import 'package:kitchening/features/recipe/presentation/view_model/all_recipe_bloc/recipe_bloc.dart';
import 'package:kitchening/features/recipe/presentation/view_model/single_recipe_cubit/cubit/single_recipe_cubit.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateRecipeScreenView extends StatefulWidget {
  const CreateRecipeScreenView({super.key});

  @override
  State<CreateRecipeScreenView> createState() => _CreateRecipeScreenViewState();
}

typedef CuisineEntry = DropdownMenuEntry<String>;

// DropdownMenuEntry labels and values for the first dropdown menu.

final List<CuisineEntry> entries = UnmodifiableListView<CuisineEntry>([
  const CuisineEntry(label: "Nepali", value: "nepali"),
  const CuisineEntry(label: "Indian", value: "indian"),
  const CuisineEntry(label: "Chinese", value: "chinese"),
  const CuisineEntry(label: "Italian", value: "italian"),
  const CuisineEntry(label: "Japanese", value: "japanese"),
  const CuisineEntry(label: "Korean", value: "korean"),
  const CuisineEntry(label: "Thai", value: "thai"),
]);

class _CreateRecipeScreenViewState extends State<CreateRecipeScreenView> {
  File? _img;
  bool _isPublic = false;
  String _cuisine = "nepali";
  final TextEditingController _recipeName = TextEditingController();

  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          context.read<RecipeBloc>().add(UploadImageEvent(image: _img!));
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  checkCameraPermission() async {
    if (await Permission.camera.isRestricted ||
        await Permission.camera.isDenied) {
      await Permission.camera.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    const tabBar = TabBar(
      labelPadding: EdgeInsets.symmetric(vertical: 6),
      labelStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 1),
      tabs: [
        Text("Picture"),
        Text("Ingredients"),
        Text("Steps"),
      ],
      indicatorColor: Colors.white,
      labelColor: Colors.white,
      unselectedLabelColor: Color(0xffC0D2C2),
    );
    return BlocProvider(
      create: (_) => SingleRecipeCubit(),
      child: DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Column(
          children: [
            const ColoredBox(
              color: caribeanCurrent,
              child: tabBar,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration:
                        const InputDecoration(label: Text("Recipe Name")),
                    controller: _recipeName,
                  ),
                  gap8Y,
                  Row(
                    children: [
                      DropdownMenu<String>(
                        initialSelection: entries.first.value,
                        label: const Text("Cuisine"),
                        dropdownMenuEntries: entries,
                        onSelected: (value) => setState(() {
                          _cuisine = value!;
                        }),
                      ),
                      const Spacer(),
                      const Tooltip(
                          message: "Recipe will be hidden",
                          child: Text("Private?")),
                      Checkbox(
                          value: !_isPublic,
                          onChanged: (value) {
                            context.read<RecipeBloc>().add(GetAllRecipeEvent());
                            setState(() {
                              _isPublic = !_isPublic;
                            });
                          }),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              child: TabBarView(
                children: [
                  Container(
                    margin: const EdgeInsets.all(24.0),
                    child: InkWell(
                      onTap: () async {
                        showModalBottomSheet(
                          useSafeArea: true,
                          context: context,
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    checkCameraPermission();
                                    _browseImage(ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.camera),
                                  label: const Text('Camera'),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    checkCameraPermission();
                                    _browseImage(ImageSource.gallery);
                                  },
                                  icon: const Icon(Icons.image),
                                  label: const Text('Gallery'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Image(
                        image: _img != null
                            ? FileImage(_img!)
                            : const AssetImage('assets/images/profile.png')
                                as ImageProvider,
                      ),
                    ),
                  ),
                  BlocProvider<SingleRecipeCubit>.value(
                    value: context.read<SingleRecipeCubit>(),
                    child: const RecipeIngredients(
                      isEditable: true,
                    ),
                  ),
                  BlocProvider<SingleRecipeCubit>.value(
                    value: context.read<SingleRecipeCubit>(),
                    child: const RecipeSteps(
                      isEditable: true,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  final state = context.read<SingleRecipeCubit>().state;
                  print("Create recipe");

                  if (state.steps.isEmpty || state.ingredients.isEmpty) {
                    showErrorSnackBar(context,
                        message: "Recipe must have steps and ingredients");
                    return;
                  }
                  if (_recipeName.text.trim().isEmpty) {
                    showErrorSnackBar(context,
                        message: "Recipe must have a name");
                    return;
                  }
                  context.read<RecipeBloc>().add(CreateRecipeEvent(
                        recipeTitle: _recipeName.text.trim(),
                        ingredients: state.ingredients,
                        steps: state.steps,
                        cuisine: _cuisine,
                      ));
                },
                child: const Text("Create"),
              ),
            ),
            gap8Y,
          ],
        ),
      ),
    );
  }
}
