import 'package:flutter/material.dart';
import 'package:let_me_cook/screens/home/widgets/RecipeCard.dart';

import '../../models/Recipe.dart';

class HomeScreen extends StatefulWidget {
  final List<Recipe> recipeList;
  final List<String> shoppingList;
  final List<String> pantryList;
  final List<Recipe> favoriteList;
  final List<bool> boughtStatus;

  HomeScreen({
    required this.recipeList,
    required this.shoppingList,
    required this.pantryList,
    required this.favoriteList,
    required this.boughtStatus,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    setState(() {
      filteredRecipes = widget.recipeList
          .where((recipe) => recipe.title
          .toLowerCase()
          .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Receitas',
            style: TextStyle(
              height: 2,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          buildSearchTextField(context),
          buildRecipesList(),
        ],
      ),
    );
  }

  Widget buildSearchTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) {
          _onSearchChanged();
        },
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Pesquisar receita...',
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
          contentPadding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        ),
      ),
    );
  }

  Widget buildRecipesList() {
    return Expanded(
      child: ListView.builder(
        itemCount: filteredRecipes.length,
        itemBuilder: (context, index) {
          return RecipeCard(
              recipe: filteredRecipes[index],
              shoppingList: widget.shoppingList,
              pantryList: widget.pantryList,
              favoriteList: widget.favoriteList,
              boughtStatus: widget.boughtStatus);
        },
      ),
    );
  }
}
