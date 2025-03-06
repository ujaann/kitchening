import 'package:flutter/material.dart';
import 'package:kitchening/app/common/gap.dart';
import 'package:kitchening/app/common/styles.dart';
import 'package:kitchening/core/constants/api_endpoints.dart';
import 'package:kitchening/features/recipe/domain/entity/recipe_entity.dart';

class RecipeCard extends StatelessWidget {
  final RecipeEntity recipeEntity;
  final VoidCallback onTap;
  const RecipeCard({
    super.key,
    required this.recipeEntity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: SizedBox(
        height: 160,
        width: MediaQuery.sizeOf(context).width * 0.9,
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0, left: 16, right: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onTap,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: SizedBox(
                    child: recipeEntity.imageName != null
                        ? Image.network(
                            "${ApiEndpoints.baseUrl}${ApiEndpoints.recipeImage}${recipeEntity.imageName}",
                            height: 120,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/logo.png',
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipeEntity.recipeName),
                  Row(
                    children: [
                      Text("Steps: ${recipeEntity.steps.length}"),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Likes: ${recipeEntity.likeCount}"),
                    ],
                  ),
                  const Text("Ujan Sthapit"),
                ],
              ),
              gap8X,
            ],
          ),
        ),
      ),
    );
  }
}

class SmallRecipeCard extends StatelessWidget {
  final RecipeEntity recipeEntity;
  final VoidCallback onIconPressed;

  const SmallRecipeCard({
    super.key,
    required this.recipeEntity,
    required this.onIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Container(
        height: 160,
        width: 160,
        padding: const EdgeInsets.all(2.0),
        child: Stack(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: recipeEntity.imageName != null
                      ? Image.network(
                          "${ApiEndpoints.baseUrl}${ApiEndpoints.recipeImage}${recipeEntity.imageName}",
                          height: 120,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/logo.png',
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                child: ColoredBox(
                  color: caribeanCurrent,
                  child: SizedBox(
                    width: 150,
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            " ${recipeEntity.recipeName}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_forward,
                            size: 20,
                            color: Colors.white,
                          ),
                          onPressed: onIconPressed,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
