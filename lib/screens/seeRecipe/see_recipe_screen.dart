import 'package:flutter/material.dart';
import 'package:let_me_cook/models/Recipe.dart';
// ignore: unused_import
import 'package:let_me_cook/models/Ingredient.dart';

class SeeRecipeScreen extends StatefulWidget {
  final Recipe recipe;
  final Function(String) addToShoppingList;
  final Function(String) isInPantry;
  final Function(Recipe) addToFavoriteList;

  SeeRecipeScreen({required this.recipe, required this.addToShoppingList, required this.isInPantry, required this.addToFavoriteList});


  @override
  State<SeeRecipeScreen> createState() => SeeRecipeScreenState();
}

class SeeRecipeScreenState extends State<SeeRecipeScreen>{
  late Recipe _recipe;

  @override
  void initState() {
    super.initState();
    _recipe = widget.recipe;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [Column(
        children: <Widget>[
          SizedBox(height: 10),

          //Favorite
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [InkWell(
              child: const Icon(Icons.favorite_border, size: 50),
              onTap: () {
                widget.addToFavoriteList(_recipe);
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    Future.delayed(Duration(seconds: 1), () {
                      Navigator.of(context).pop(true);
                    });
                    return AlertDialog(
                      backgroundColor: Color(0xFFBF7979),
                      title: Text('Adicionada aos Favoritos', textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
                    );
                  });
              },
            ),
          ]),

          //Picture
          _recipe.picture == null
          ? Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 174, 174, 174),
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  scale: 5,
                  image: AssetImage("assets/images/camera.png"),
              ),
            ),
            child: Text(" - SEM IMAGEM - ", style: TextStyle(fontSize: 20), textAlign: TextAlign.center ,),
          )
          : Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(_recipe.picture!),
              ),
            ),
          ),

          //Title
          Text(_recipe.title, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,)),
          SizedBox(height: 10),

          //PORTIONS AND DURATION
          Divider(
            color: Colors.black,
            thickness: 2,
            height: 20,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("${_recipe.portions}\n(Porções)", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                Text("${_recipe.duration} mins\n(Duração)", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
                //Tex
              ]
          ),
          SizedBox(height: 10),
          Divider(
            color: Colors.black,
            thickness: 2,
            height: 20,
          ),
          SizedBox(height: 20),

          //INGREDIENTS
          Text("Ingredientes", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          for(int i=0; i < _recipe.ingredients.length; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                widget.isInPantry(_recipe.ingredients[i].name)
                ? InkWell(child: const Icon(Icons.check_circle, color: Colors.green),)
                :InkWell(
                  child: const Icon(Icons.shopping_cart, color: Colors.red),
                  onTap: () {
                    widget.addToShoppingList(_recipe.ingredients[i].name);
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        Future.delayed(Duration(seconds: 1), () {
                          Navigator.of(context).pop(true);
                        });
                        return AlertDialog(
                          backgroundColor: Color(0xFFBF7979),
                          title: Text('Adicionado à Lista de Compras', textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
                        );
                      });
                  },
                ),
                Text("${_recipe.ingredients[i].quantity} ${_recipe.ingredients[i].units} ${_recipe.ingredients[i].name}", 
                style: TextStyle(fontSize: 18)),
              ],
            ),
          SizedBox(height: 20),

          //STEPS
          Text("Passos", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          for(int i=0; i < _recipe.steps.length; i++)
            Row(
              children: [
                Text("${_recipe.steps[i]}\n", style: TextStyle(fontSize: 18)),
              ]
            ),
        ],
      ),
    ]);
  }
}