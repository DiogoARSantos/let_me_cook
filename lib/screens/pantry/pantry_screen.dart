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

  @override
  void initState() {
    super.initState();
    pantryList = widget.pantryList;
  }

  void updatePantryList(String ingredient) {
    setState(() {
      if (pantryList.contains(ingredient)) {
        pantryList.remove(ingredient);
      } else {
        pantryList.add(ingredient);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text("Despensa",
                style: TextStyle(
                  height: 2,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
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
              itemCount: allIngredients.length,
              itemBuilder: (context, index) {
                final ingredient = allIngredients[index];
                final isOwned = pantryList.contains(ingredient);

                return GestureDetector(
                  onTap: () {
                    updatePantryList(ingredient);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isOwned ? Colors.green : Colors.grey,
                      borderRadius: BorderRadius.circular(
                          20.0), // Adjust the value as needed
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
