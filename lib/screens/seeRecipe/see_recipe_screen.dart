import 'package:flutter/material.dart';
import 'package:let_me_cook/models/Recipe.dart';

// ignore: unused_import
import 'package:let_me_cook/models/Ingredient.dart';

class SeeRecipeScreen extends StatefulWidget {
  final Recipe recipe;
  final List<String> shoppingList;
  final List<String> pantryList;
  final List<Recipe> favoriteList;
  final List<bool> boughtStatus;

  SeeRecipeScreen(
      {required this.recipe,
        required this.shoppingList,
        required this.pantryList,
        required this.favoriteList,
        required this.boughtStatus});

  @override
  State<SeeRecipeScreen> createState() => SeeRecipeScreenState();
}

class SeeRecipeScreenState extends State<SeeRecipeScreen> {
  late Recipe _recipe;
  late Icon heart;

  @override
  void initState() {
    super.initState();
    _recipe = widget.recipe;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
            size: 40,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              widget.favoriteList.contains(_recipe)
                  ? Icons.favorite
                  : Icons.favorite_border_outlined,
              size: 50,
              color: Colors.black,
            ),
            onPressed: () {
              if (widget.favoriteList.contains(_recipe)) {
                setState(() {
                  widget.favoriteList.remove(_recipe);
                });
              } else {
                setState(() {
                  widget.favoriteList.add(_recipe);
                });
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      Future.delayed(Duration(seconds: 1, milliseconds: 500),
                              () {
                            Navigator.of(context).pop(true);
                          });
                      return AlertDialog(
                        backgroundColor: Color(0xFF6BB05A),
                        title: Text(
                          'Adicionada aos Favoritos',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    });
              }
            },
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          Column(
            children: <Widget>[
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
                child: Text(
                  " - SEM IMAGEM - ",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
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
              Text(_recipe.title,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 10),

              //PORTIONS AND DURATION
              Divider(
                color: Colors.black,
                thickness: 2,
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Text("${_recipe.portions}\n(Porções)",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                Text("${_recipe.duration} mins\n(Duração)",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center)
              ]),
              SizedBox(height: 10),
              Divider(
                color: Colors.black,
                thickness: 2,
                height: 20,
              ),
              SizedBox(height: 20),

              //INGREDIENTS
              Row(
                children: [
                  Text("Ingredientes",
                      style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 10),
              for (int i = 0; i < _recipe.ingredients.length; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    widget.pantryList
                        .contains(_recipe.ingredients[i].name.toLowerCase())
                        ? InkWell(
                      child: const Icon(Icons.check_circle,
                          color: Color(0xFF6BB05A)),
                    )
                        : InkWell(
                      child: !widget.shoppingList.contains(
                          _recipe.ingredients[i].name.toLowerCase())
                          ? const Icon(Icons.shopping_cart,
                          color: Color(0xFFDC2A2A), size: 35)
                          : const Icon(Icons.shopping_cart,
                          color: Color(0xFF6BB05A), size: 35),
                      onTap: () {
                        String ingredient =
                        _recipe.ingredients[i].name.toLowerCase();
                        if (!widget.shoppingList.contains(ingredient)) {
                          setState(() {
                            widget.shoppingList.add(ingredient);
                            widget.boughtStatus.add(false);
                          });
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                Future.delayed(Duration(seconds: 1), () {
                                  Navigator.of(context).pop(true);
                                });
                                return AlertDialog(
                                  backgroundColor: Color(0xFF6BB05A),
                                  title: Text(
                                    'Adicionado à Lista de Compras',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              });
                        }
                      },
                    ),
                    _recipe.ingredients[i].quantity == 0
                        ? Text(
                        "${_recipe.ingredients[i].units} ${_recipe.ingredients[i].name}",
                        style: TextStyle(fontSize: 20))
                        : Text(
                        "${_recipe.ingredients[i].quantity} ${_recipe.ingredients[i].units} ${_recipe.ingredients[i].name}",
                        style: TextStyle(fontSize: 20)),
                  ],
                ),
              SizedBox(height: 20),

              //STEPS
              Row(
                children: [
                  Text("Passos",
                      style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _recipe.steps.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      "${index + 1}. ${_recipe.steps[index]}",
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                },
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
