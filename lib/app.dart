import 'package:flutter/material.dart';
import 'package:let_me_cook/screens/addRecipe/add_recipe_screen.dart';
import 'package:let_me_cook/screens/home/home_screen.dart';
import 'package:let_me_cook/screens/pantry/pantry_screen.dart';
import 'package:let_me_cook/screens/profile/profile_screen.dart';
import 'package:let_me_cook/screens/shoppingList/shopping_list_screen.dart';
import 'startRecipes.dart';
import 'models/Recipe.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  List<String> pantryList = ["massa de lasanha",
    "espinafres",
    "queijo ricotta",
    "queijo parmesão ralado",
    "mozzarella ralada",
    "alho picado",
    "azeite de oliva",
    "molho de tomate","sal","pimenta preta", "noz-moscada"];
  List<String> shoppingList = [];
  List<bool> boughtStatus = [];
  List<Recipe> favoriteRecipeList = [startRecipeList[6]];
  List<Recipe> recipeList = startRecipeList;
  List<Recipe> myRecipes = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool isInPantry(String ingredient) {
    return pantryList.contains(ingredient);
  }

  bool isInFavorites(Recipe recipe) {
    return favoriteRecipeList.contains(recipe);
  }

  void backToHomeScreen() {
    setState(() {
      _selectedIndex = 0;
    });
  }

  void addToShoppingList(String ingredient) {
    if (!shoppingList.contains(ingredient)) {
      setState(() {
        shoppingList.add(ingredient);
        boughtStatus.add(false);
      });
    }
  }

  void addToFavoriteList(Recipe recipe) {
    if (!favoriteRecipeList.contains(recipe)) {
      setState(() {
        favoriteRecipeList.add(recipe);
      });
    }
  }

  void removeFromFavorite(Recipe recipe) {
    if (favoriteRecipeList.contains(recipe)) {
      setState(() {
        favoriteRecipeList.remove(recipe);
      });
    }
  }

  void addRecipe(Recipe recipe) {
    setState(() {
      recipeList.add(recipe);
      myRecipes.add(recipe);
    });
  }

  void addToPantry(String ingredient) {
    if (!pantryList.contains(ingredient)) {
      setState(() {
        pantryList.add(ingredient);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (_selectedIndex) {
      case 0:
        /*Ingredient i1 = Ingredient(name: "mel", quantity: 10, units: "g");
        Ingredient i2 = Ingredient(name: "Ing2", quantity: 5, units: "L");
        Recipe r = Recipe(title: "Bolo de chocolate", portions: 3, duration: 30, ingredients: [i1,i2], steps: ["Passo1: dnkjdbvjv", "Passo2: sfdbdn\nifdndnj", "Passo3: inaind"]);
        page = SeeRecipeScreen(recipe: r, addToShoppingList: addToShoppingList, isInPantry: isInPantry,
        addToFavoriteList: addToFavoriteList, isInFavorties: isInFavorties, removeFromFavorie: removeFromFavorie);*/
        page = HomeScreen(
            recipeList: recipeList,
            addToShoppingList: addToShoppingList,
            isInPantry: isInPantry,
            addToFavoriteList: addToFavoriteList,
            isInFavorites: isInFavorites,
            removeFromFavorite: removeFromFavorite);
        break;
      case 1:
        page = ShoppingListScreen(
            shoppingList: shoppingList,
            boughtStatus: boughtStatus,
            addToPantry: addToPantry);
        break;
      case 2:
        page = AddRecipeScreen(
            addRecipe: addRecipe, backToHomeScreen: backToHomeScreen);
        break;
      case 3:
        page = PantryScreen(pantryList: pantryList);
        break;
      case 4:
        page = ProfileScreen(
            recipeList: myRecipes,
            favoriteRecipeList: favoriteRecipeList,
            addToShoppingList: addToShoppingList,
            isInPantry: isInPantry,
            addToFavoriteList: addToFavoriteList,
            isInFavorites: isInFavorites,
            removeFromFavorite: removeFromFavorite);
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
