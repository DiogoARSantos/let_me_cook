import 'package:flutter/material.dart';

import 'IngredientSearchScreen.dart';

class ShoppingListScreen extends StatefulWidget {
  final List<String> shoppingList;
  final List<bool> boughtStatus;
  final List<String> pantryList;

  ShoppingListScreen(
      {required this.shoppingList,
        required this.boughtStatus,
        required this.pantryList});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  TextEditingController _searchController = TextEditingController();

  List<String> shoppingList = [];
  List<String> filteredIngredients = [];
  List<bool> boughtStatus = [];
  List<String> displayedShoppingList = [];
  List<String> pantryList = [];

  @override
  void initState() {
    super.initState();
    shoppingList = widget.shoppingList;
    boughtStatus = widget.boughtStatus;
    displayedShoppingList = shoppingList;
    pantryList = widget.pantryList;
  }

  void _onSearchChanged(String query) {
    setState(() {
      displayedShoppingList = widget.shoppingList
          .where((ingredient) =>
          ingredient.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _navigateToIngredientSearch() async {
    final updatedShoppingList = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IngredientSearchScreen(
          shoppingList: shoppingList,
          boughtStatus: boughtStatus,
        ),
      ),
    );

    if (updatedShoppingList != null) {
      setState(() {
        shoppingList = updatedShoppingList;
        _onSearchChanged(_searchController.text);
      });
    }
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
                    hintText: "Pesquisar na lista de compras...",
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xFFBF7979),
                      size: 40,
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFBF7979)),
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                  ),
                  onChanged: (value) {
                    _onSearchChanged(value);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: displayedShoppingList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        displayedShoppingList[index],
                        style: TextStyle(
                          decoration:
                          boughtStatus.isNotEmpty && boughtStatus[index]
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
                          if (value == true) {
                            if (!pantryList
                                .contains(displayedShoppingList[index])) {
                              setState(() {
                                pantryList.add(displayedShoppingList[index]);
                              });
                            }
                          }
                        },
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            boughtStatus.removeAt(index);
                            shoppingList.removeAt(index);
                            displayedShoppingList = shoppingList;
                          });
                        },
                      ),
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
                              boughtStatus.add(false);
                              shoppingList.add(ingredient);
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            backgroundColor: Color(0xFF6BB05A),
            tooltip: "Adicionar novo ingrediente",
            onPressed: () {
              _navigateToIngredientSearch();
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            backgroundColor: Colors.red, // Button color
            tooltip: "Limpar Lista de Compras", // Tooltip
            onPressed: () {
              // Show the alert dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Color(0xFFBF7979),
                    title: Text("Limpar Lista de Compras",
                        style: TextStyle(color: Colors.white)),
                    content: Text(
                        "Tem a certeza que deseja limpar a lista de compras?",
                        style: TextStyle(color: Colors.white)),
                    actions: <Widget>[
                      TextButton(
                        child: Text("Cancelar",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                      TextButton(
                        child: Text("Limpar",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          setState(() {
                            shoppingList.clear(); // Clear the shopping list
                            boughtStatus.clear(); // Clear the bought status
                            displayedShoppingList =
                            []; // Clear displayedShoppingList
                          });
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Icon(Icons.delete), // Icon within the button
          ),
        ],
      ),
    );
  }
}
