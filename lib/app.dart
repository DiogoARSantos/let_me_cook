import 'package:flutter/material.dart';
import 'package:let_me_cook/screens/addRecipe/add_recipe_screen.dart';
import 'package:let_me_cook/screens/home/home_screen.dart';
import 'package:let_me_cook/screens/pantry/pantry_screen.dart';
import 'package:let_me_cook/screens/profile/profile_screen.dart';
import 'package:let_me_cook/screens/shoppingList/shopping_list_screen.dart';

import 'models/Recipe.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  List<String> shoppingList = [];
  List<Recipe> recipeList = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void addToShoppingList(String ingredient) {
    if (!shoppingList.contains(ingredient)) {
      setState(() {
        shoppingList.add(ingredient);
      });
    }
  }

  void addRecipe(Recipe recipe) {
      setState(() {
        recipeList.add(recipe);
      });
  }




  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (_selectedIndex) {
      case 0:
        page = HomeScreen(recipeList: recipeList);
        break;
      case 1:
        page = ShoppingListScreen(shoppingList: shoppingList);
        break;
      case 2:
        page = AddRecipeScreen(addRecipe: addRecipe);
        break;
      case 3:
        page = PantryScreen();
        break;
      case 4:
        page = ProfileScreen();
        break;
      default:
        throw UnimplementedError('no widget for $_selectedIndex');
    }

    return Scaffold(
      appBar: buildAppBar(context),
      body: Center(
        child: page,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        unselectedIconTheme: IconThemeData(color: Color(0xFFBF7979), size: 40),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        unselectedItemColor: Color(0xFFBF7979),
        selectedIconTheme: IconThemeData(color: Color(0xFF522828), size: 50),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: Color(0xFF522828),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Lista de Compras',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Nova Receita',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.kitchen),
            label: 'Despensa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context) {

  return AppBar(
    centerTitle: true,
    title: Image.asset(
      "assets/images/App_Title.png",
      width: 200,
      fit: BoxFit.contain,
    ),
  );
}