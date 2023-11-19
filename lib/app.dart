import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:let_me_cook/screens/addRecipe/add_recipe_screen.dart';
import 'package:let_me_cook/screens/home/home_screen.dart';
import 'package:let_me_cook/screens/pantry/pantry_screen.dart';
import 'package:let_me_cook/screens/profile/profile_screen.dart';
import 'package:let_me_cook/screens/shoppingList/shopping_list_screen.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget page;
    switch (_selectedIndex) {
      case 0:
        page = HomeScreen();
        break;
      case 1:
        page = ShoppingListScreen();
        break;
      case 2:
        page = AddRecipeScreen();
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
        unselectedIconTheme: IconThemeData(color: Colors.black54, size: 40),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        unselectedItemColor: Colors.black87,
        selectedIconTheme: IconThemeData(color: Colors.black, size: 50),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Shopping List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'New Recipe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.kitchen),
            label: 'Pantry',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  var deviceData = MediaQuery.of(context);
  var defaultSize = deviceData.orientation == Orientation.landscape
      ? deviceData.size.height * 0.024
      : deviceData.size.width * 0.024;

  return AppBar(
    leading: IconButton(
      icon: SvgPicture.asset("assets/icons/menu.svg"),
      onPressed: () {},
    ),
    centerTitle: true,
    title: Image.asset("assets/images/App_Title.png"),
    actions: <Widget>[
      IconButton(
        icon: SvgPicture.asset("assets/icons/search.svg"),
        onPressed: () {},
      ),
      SizedBox(width: defaultSize * 0.5)
    ],
  );
}