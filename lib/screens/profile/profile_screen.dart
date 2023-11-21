import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import '../../models/Recipe.dart';
import 'package:let_me_cook/screens/home/widgets/RecipeCard.dart';

class ProfileScreen extends StatefulWidget {
  List<Recipe> recipeList = [];
  List<Recipe> favoriteRecipeList = [];
  final Function(String) addToShoppingList;
  final Function(Recipe) isInFavorites;
  final Function(String) isInPantry;
  final Function(Recipe) addToFavoriteList;
  final Function(Recipe) removeFromFavorite;
  ProfileScreen({required this.recipeList, required this.favoriteRecipeList,
    required this.addToShoppingList,
    required this.isInPantry,
    required this.addToFavoriteList,
    required this.isInFavorites,
    required this.removeFromFavorite});


  @override
  State<ProfileScreen> createState() => _ProfileScreenState(title: 'Profile');
}

bool _displayFavorites = false;

class MyAppState2 extends ChangeNotifier {
  ProfileScreen profileScreen;
  MyAppState2(this.profileScreen);

  List<Recipe> get displayedRecipes {
    if (_displayFavorites == false) {
      return profileScreen.recipeList;
    } else {
      return profileScreen.favoriteRecipeList;
    }
  }

  void toggleDisplayFavorites() {
    _displayFavorites = !_displayFavorites;
    notifyListeners();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String title;

  _ProfileScreenState({Key? key, required this.title});
  TextEditingController _searchController = TextEditingController();

  List<Recipe> filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    filteredRecipes = List.from(widget.recipeList);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_displayFavorites == false) {
      setState(() {
        filteredRecipes = widget.recipeList
            .where((recipe) => recipe.title
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        filteredRecipes = widget.favoriteRecipeList
            .where((recipe) => recipe.title
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var name = appState.name;
    return ChangeNotifierProvider(
      create: (context) => MyAppState2(this.widget),
      child: Consumer<MyAppState2>(
        builder: (context, appState2, child) {
          Widget buildHeader() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 70),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('caminho_para_a_sua_imagem'),
                ),
                SizedBox(height: 10),
                Text(
                  '$name',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
              ],
            );
          }

          Widget buildButtons() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      print('button pressed!');
                      appState2.toggleDisplayFavorites();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: _displayFavorites
                          ? Colors.transparent
                          : const Color.fromARGB(255, 175, 76, 76),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('As minhas receitas'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      print('button pressed!');
                      appState2.toggleDisplayFavorites();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: _displayFavorites
                          ? const Color.fromARGB(255, 175, 76, 76)
                          : Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('Favoritos'),
                  ),
                ),
              ],
            );
          }

          Widget buildSearchTextField() {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  _onSearchChanged();
                },
                decoration: InputDecoration(
                  hintText: 'Pesquisar...',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                ),
              ),
            );
          }

          Widget buildReceitasList() {
            return Expanded(
              child: ListView.builder(
                itemCount: appState2.displayedRecipes.length,
                itemBuilder: (context, index) {
                  return RecipeCard(recipe: appState2.displayedRecipes[index], addToShoppingList: widget.addToShoppingList,
                      isInPantry: widget.isInPantry,
                      addToFavoriteList: widget.addToFavoriteList,
                      isInFavorites: widget.isInFavorites,
                      removeFromFavorite: widget.removeFromFavorite);
                },
              ),
            );
          }

          return Scaffold(
            body: Column(
              children: [
                buildHeader(),
                buildButtons(),
                buildSearchTextField(),
                buildReceitasList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
