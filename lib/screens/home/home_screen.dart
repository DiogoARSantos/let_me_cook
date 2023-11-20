

import 'package:flutter/material.dart';
import 'package:let_me_cook/exampleRecipes.dart';

import '../../models/Recipe.dart';

class HomeScreen extends StatefulWidget {
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

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  RecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              image: recipe.picture != null
                  ? DecorationImage(
                image: FileImage(recipe.picture!),
                fit: BoxFit.cover,
              )
                  : null,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              recipe.title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 10), // Adiciona um espaçamento de 20 pixels
          Text(
            'Receitas',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          buildSearchTextField(context), // Adiciona um espaçamento de 8 pixels
          buildReceitasList(),
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
              context: context, delegate: DataSearch(allData: exampleRecipes));
        },
        decoration: InputDecoration(
          hintText: 'Pesquisar...',
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        ),
      ),
    );
  }

  Widget buildReceitasList() {
    return Expanded(
      child: ListView.builder(
        itemCount: exampleRecipes.length,
        itemBuilder: (context, index) {
          return RecipeCard(recipe: exampleRecipes[index]);
        },
      ),
    );
  }
}
