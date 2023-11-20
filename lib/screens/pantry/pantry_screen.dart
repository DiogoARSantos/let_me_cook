import 'package:flutter/material.dart';
import '../../allIngredients.dart';

class PantryScreen extends StatefulWidget {
  final List<String> pantryList;

  PantryScreen({
    required this.pantryList,
  });

  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {
  List<String> pantryList = [];
  List<String> displayedIngredients = [];
  TextEditingController searchController = TextEditingController();
  bool showAll = true;
  bool showInPantry = false;
  bool showNotInPantry = false;

  @override
  void initState() {
    super.initState();
    pantryList = widget.pantryList;
    displayedIngredients = allIngredients;
  }

  void updatePantryList(String ingredient) {
    setState(() {
      if (pantryList.contains(ingredient)) {
        pantryList.remove(ingredient);
      } else {
        pantryList.add(ingredient);
      }
      displayedIngredients = filterByPantry();
    });
  }

  void filterIngredients(String query) {
    setState(() {
      if (query.isEmpty) {
        displayedIngredients = filterByPantry();
      } else {
        displayedIngredients = allIngredients
            .where((ingredient) =>
                ingredient.toLowerCase().contains(query.toLowerCase()))
            .toList();
        displayedIngredients =
            filterByPantry(ingredients: displayedIngredients);
      }
    });
  }

  // Widget to create a custom ElevatedButton with active state
  Widget customElevatedButton(bool isActive, String text, Function()? onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.blue : Colors.grey.shade300,
        elevation: isActive ? 8 : 0,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  List<String> filterByPantry({List<String>? ingredients}) {
    ingredients ??= allIngredients;

    if (showInPantry) {
      return ingredients
          .where((ingredient) => pantryList.contains(ingredient))
          .toList();
    } else if (showNotInPantry) {
      return ingredients
          .where((ingredient) => !pantryList.contains(ingredient))
          .toList();
    } else {
      return ingredients;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              "Despensa",
              style: TextStyle(
                height: 2,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: filterIngredients,
              decoration: InputDecoration(
                hintText: "Procurar ingrediente...",
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xFFBF7979),
                  size: 40,
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFBF7979),
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                customElevatedButton(
                  showAll,
                  'Todos',
                      () {
                    setState(() {
                      showAll = true;
                      showInPantry = false;
                      showNotInPantry = false;
                      displayedIngredients = filterByPantry();
                    });
                  },
                ),
                customElevatedButton(
                  showInPantry,
                  'Na despensa',
                      () {
                    setState(() {
                      showAll = false;
                      showInPantry = true;
                      showNotInPantry = false;
                      displayedIngredients = filterByPantry();
                    });
                  },
                ),
                customElevatedButton(
                  showNotInPantry,
                  'Fora da despensa',
                      () {
                    setState(() {
                      showAll = false;
                      showInPantry = false;
                      showNotInPantry = true;
                      displayedIngredients = filterByPantry();
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(15),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisExtent: 50,
                maxCrossAxisExtent: 100,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: displayedIngredients.length,
              itemBuilder: (context, index) {
                final ingredient = displayedIngredients[index];
                final isOwned = pantryList.contains(ingredient);

                return GestureDetector(
                  onTap: () {
                    updatePantryList(ingredient);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isOwned ? Colors.green : Colors.grey,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    width: 100,
                    height: 100,
                    child: Center(
                      child: Text(
                        ingredient,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
