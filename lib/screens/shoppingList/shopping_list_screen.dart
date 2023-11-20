import 'package:flutter/material.dart';

import '../../allIngredients.dart';

class ShoppingListScreen extends StatefulWidget {
  final List<String> shoppingList;
  final List<bool> boughtStatus;

  ShoppingListScreen({
    required this.shoppingList,required this.boughtStatus
  });

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  TextEditingController _searchController = TextEditingController();

  List<String> shoppingList = [];
  List<String> filteredIngredients = [];
  List<bool> boughtStatus = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    shoppingList = widget.shoppingList;
    boughtStatus = widget.boughtStatus;
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      filteredIngredients = allIngredients
          .where((ingredient) => ingredient
          .toLowerCase()
          .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text("Lista de compras",
                    style: TextStyle(
                      height: 2,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Adicionar ingredientes...",
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xFFBF7979),
                      size: 40,
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFFBF7979)), // Set transparent color
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                  ),
                  onChanged: (value) {
                    _onSearchChanged();
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: shoppingList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        shoppingList[index],
                        // Apply strike-through if the ingredient is bought
                        style: TextStyle(
                          decoration: boughtStatus.isNotEmpty && boughtStatus[index]
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      leading: Checkbox(
                        value: boughtStatus.isNotEmpty && boughtStatus[index],
                        onChanged: (bool? value) {
                          setState(() {
                            boughtStatus[index] = value ?? false;
                          });
                        },
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            shoppingList.removeAt(index);
                            boughtStatus.removeAt(index);
                          });
                        },
                      ),
                      // Add checkbox or other UI for marking as bought
                    );
                  },
                ),
              ),
            ],
          ),
          if (_searchController.text.isNotEmpty &&
              filteredIngredients.isNotEmpty)
            Positioned(
              top: 145,
              left: 8.0,
              right: 8.0,
              child: ClipRRect(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xFFBF7979)),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: filteredIngredients.map((ingredient) {
                      return ListTile(
                        title: Text(ingredient),
                        onTap: () {
                          setState(() {
                            if (!shoppingList.contains(ingredient)) {
                              shoppingList.add(ingredient);
                              boughtStatus.add(false);
                            }
                            _searchController.clear();
                            filteredIngredients.clear();
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
