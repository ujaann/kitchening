import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kitchening/app/common/gap.dart';
import 'package:kitchening/app/common/my_snackbar.dart';
import 'package:kitchening/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class RegisterScreenView extends StatefulWidget {
  const RegisterScreenView({super.key});

  @override
  State<RegisterScreenView> createState() => _RegisterScreenViewState();
}

class _RegisterScreenViewState extends State<RegisterScreenView> {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  File? _img;

  String? validateFields() {
    final pass = password.text;
    final conPass = confirmPassword.text;

    if (username.text.length < 4 || pass.length < 4 || conPass.length < 4) {
      return "Username and password must be longer than 4 characters";
    }

    if (pass != conPass) {
      return "Error... Password does not match";
    }
    return null;
  }

  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          context
              .read<RegisterBloc>()
              .add(UploadImageEvent(context: context, image: _img!));
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
  void dispose() {
    username.dispose();
    password.dispose();
    email.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Let's Get Started",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w300),
                ),
                gap24Y,
                InkWell(
                  onTap: () {
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
                                // Upload image it is not null
                              },
                              icon: const Icon(Icons.camera),
                              label: const Text('Camera'),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.image),
                              label: const Text('Gallery'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: _img != null
                        ? FileImage(_img!)
                        : const AssetImage('assets/images/profile.png')
                            as ImageProvider,
                  ),
                ),
                gap16Y,
                TextField(
                  controller: username,
                  decoration: InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
                gap16Y,
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  keyboardType: TextInputType.emailAddress,
                ),
                gap16Y,
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
                gap16Y,
                TextField(
                  controller: confirmPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Confirm Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
                gap16Y,
                SizedBox(
                  width: 290,
                  child: ElevatedButton(
                    onPressed: () async {
                      final error = validateFields();
                      if (error != null) {
                        showErrorSnackBar(context, message: error);
                        return;
                      }

                      context.read<RegisterBloc>().add(RegisterUserEvent(
                            username: username.text,
                            password: password.text,
                            email: email.text,
                            context: context,
                          ));
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Register",
                          style: TextStyle(fontSize: 20, letterSpacing: 1)),
                    ),
                  ),
                ),
                gap16Y,
                const Text("Already Have an Account?"),
                gap8Y,
                TextButton(
                    onPressed: () => context
                        .read<RegisterBloc>()
                        .add(NavigateLoginScreenEvent(context: context)),
                    child: const Text(
                      "Login now",
                      style: TextStyle(decoration: TextDecoration.underline),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
