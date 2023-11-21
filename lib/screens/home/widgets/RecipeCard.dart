import 'package:flutter/material.dart';

import '../../../models/Recipe.dart';
import '../../seeRecipe/see_recipe_screen.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final String placeholderUrl =
      "https://worldfoodtour.co.uk/wp-content/uploads/2013/06/neptune-placeholder-48.jpg";
  final Function(String) addToShoppingList;
  final Function(Recipe) isInFavorites;
  final Function(String) isInPantry;
  final Function(Recipe) addToFavoriteList;
  final Function(Recipe) removeFromFavorite;

  RecipeCard(
      {required this.recipe,
        required this.addToShoppingList,
        required this.isInPantry,
        required this.addToFavoriteList,
        required this.isInFavorites,
        required this.removeFromFavorite});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SeeRecipeScreen(
              recipe: recipe,
              addToShoppingList: addToShoppingList,
              isInPantry: isInPantry,
              addToFavoriteList: addToFavoriteList,
              isInFavorites: isInFavorites,
              removeFromFavorite: removeFromFavorite,
            ),
          ),
        );
      },
      child: Card(
          margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 5),
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.7),
                  offset: Offset(
                    0.0,
                    10.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: -6.0,
                ),
              ],
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.55),
                  BlendMode.multiply,
                ),
                image: recipe.picture != null
                    ? FileImage(recipe.picture!)
                    : Image.network(placeholderUrl).image,
                fit: BoxFit.fill,
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      recipe.title,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.yellow,
                              size: 18,
                            ),
                            SizedBox(width: 7),
                            Text(
                              recipe.portions.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              color: Colors.yellow,
                              size: 18,
                            ),
                            SizedBox(width: 7),
                            Text(
                              "${recipe.duration} min",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
