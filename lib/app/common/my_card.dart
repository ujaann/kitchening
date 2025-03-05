import 'package:flutter/material.dart';
import 'package:kitchening/app/common/gap.dart';
import 'package:kitchening/app/common/styles.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key});

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
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  child: SizedBox(
                    child: Image.asset(
                      "assets/images/momo.png",
                      width: 120,
                    ),
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Momo"),
                    Row(
                      children: [
                        Text("Steps: 12"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Likes: 12"),
                      ],
                    ),
                    Text("Ujan Sthapit"),
                  ],
                ),
                gap8X,
              ],
            ),
          )),
    );
  }
}

class SmallRecipeCard extends StatelessWidget {
  const SmallRecipeCard({super.key});

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
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.asset(
                      "assets/images/fry_rice.png",
                      height: 120,

                      fit: BoxFit.cover,
                      // color: Colors.black,
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
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
                          SizedBox(
                            width: 116,
                            child: Text(
                              " Chicken Fried Rice",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 30,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
