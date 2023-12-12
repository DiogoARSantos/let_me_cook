import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import '../../models/Recipe.dart';
import 'package:let_me_cook/screens/home/widgets/RecipeCard.dart';

class ProfileScreen extends StatefulWidget {
  final List<Recipe> recipeList;
  final List<Recipe> favoriteRecipeList;
  final List<String> pantryList;
  final List<String> shoppingList;
  final List<bool> boughtStatus;

  ProfileScreen({
    required this.recipeList,
    required this.favoriteRecipeList,
    required this.pantryList,
    required this.shoppingList,
    required this.boughtStatus,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

bool _displayFavorites = false;

class MyAppState2 extends ChangeNotifier {
  ProfileScreen profileScreen;

  MyAppState2(this.profileScreen);

  List<Recipe> get displayedRecipes {
    if (_displayFavorites) {
      return profileScreen.favoriteRecipeList;
    } else {
      return profileScreen.recipeList;
    }
  }

  void toggleDisplayFavorites() {
    _displayFavorites = !_displayFavorites;
    notifyListeners();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _searchController = TextEditingController();

  List<Recipe> filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    filteredRecipes = widget.recipeList;
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
      create: (context) => MyAppState2(widget),
      child: Consumer<MyAppState2>(
        builder: (context, appState2, child) {
          Widget buildHeader() {
            return Column(
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/images/FinalLogo.png"),
                ),
                SizedBox(height: 10),
                Text(
                  name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
              ],
            );
          }

          Widget buildButtons() {
            return Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      appState2.toggleDisplayFavorites();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _displayFavorites
                          ? Colors.grey.shade300
                          : Color(0xFFBF7979),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: _displayFavorites ? 0 : 8,
                    ),
                    child: Text('As minhas receitas',
                        style: TextStyle(
                          color:
                              _displayFavorites ? Colors.black : Colors.white,
                        )),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      print('button pressed!');
                      appState2.toggleDisplayFavorites();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _displayFavorites
                          ? Color(0xFFBF7979)
                          : Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: _displayFavorites ? 8 : 0,
                    ),
                    child: Text(
                      'Favoritas',
                      style: TextStyle(
                        color: _displayFavorites ? Colors.white : Colors.black,
                      ),
                    ),
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
                  hintText: 'Procurar receita...',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xFFBF7979),
                    size: 40,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFBF7979)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFBF7979)),
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
                  return RecipeCard(
                      recipe: appState2.displayedRecipes[index],
                      shoppingList: widget.shoppingList,
                      pantryList: widget.pantryList,
                      favoriteList: widget.favoriteRecipeList,
                      boughtStatus: widget.boughtStatus);
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
