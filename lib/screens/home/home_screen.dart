import 'package:flutter/material.dart';
import 'package:let_me_cook/screens/home/widgets/RecipeCard.dart';

import '../../models/Recipe.dart';

class HomeScreen extends StatefulWidget {
  final List<Recipe> recipeList;

  HomeScreen({required this.recipeList});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class DataSearch extends SearchDelegate<String> {
  final List<Recipe> allData; // Substitua com seus próprios dados

  DataSearch({required this.allData});

  List<Recipe> get _currentRecipes {
    return query.isEmpty
        ? allData
        : allData
        .where((recipe) =>
        recipe.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: _currentRecipes.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_currentRecipes[index].title),
          onTap: () {
            close(context, _currentRecipes[index].title);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: _currentRecipes.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_currentRecipes[index].title),
          onTap: () {
            query = _currentRecipes[index].title;
            showResults(context);
          },
        );
      },
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
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
          showSearch(
              context: context,
              delegate: DataSearch(allData: widget.recipeList));
        },
        decoration: InputDecoration(
          hintText: 'Pesquisar receita...',
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFFBF7979),
            size: 40,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color(0xFFBF7979)
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color(0xFFBF7979)), // Set transparent color
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        ),
      ),
    );
  }

  Widget buildRecipesList() {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.recipeList.length,
        itemBuilder: (context, index) {
          return RecipeCard(recipe: widget.recipeList[index]);
        },
      ),
    );
  }
}
