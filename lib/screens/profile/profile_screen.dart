import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import '../../models/Recipe.dart';
import 'package:let_me_cook/screens/home/widgets/RecipeCard.dart';

class ProfileScreen extends StatefulWidget {
  List<Recipe> recipeList = [];
  List<Recipe> favoriteRecipeList = [];
  ProfileScreen({required this.recipeList, required this.favoriteRecipeList});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState(title: 'Profile');
}

class MyAppState2 extends ChangeNotifier {
  List<Recipe> recipeList = [];
  List<Recipe> favoriteRecipeList = [];
  MyAppState2({required this.recipeList, required this.favoriteRecipeList});
  List<Recipe> get displayedRecipes {
    return _displayFavorites ? favoriteRecipeList : recipeList;
  }

  bool _displayFavorites = false;

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
    final List<Recipe> sourceList =
        context.read<MyAppState2>().displayedRecipes;
    setState(() {
      filteredRecipes = sourceList
          .where((recipe) => recipe.title
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var name = appState.name;
    return ChangeNotifierProvider(
      create: (context) => MyAppState2(
          recipeList: widget.recipeList,
          favoriteRecipeList: widget.favoriteRecipeList),
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
                      primary: appState2._displayFavorites
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
                      primary: appState2._displayFavorites
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
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  return RecipeCard(recipe: filteredRecipes[index]);
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
