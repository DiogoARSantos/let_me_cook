import 'package:flutter/material.dart';

import 'IngredientSearchScreen.dart';

class ShoppingListScreen extends StatefulWidget {
  final List<String> shoppingList;
  final List<bool> boughtStatus;
  final Function(String) addToPantry;

  ShoppingListScreen(
      {required this.shoppingList,
        required this.boughtStatus,
        required this.addToPantry});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  TextEditingController _searchController = TextEditingController();

  List<String> shoppingList = [];
  List<String> filteredIngredients = [];
  List<bool> boughtStatus = [];
  List<String> displayedShoppingList = [];
  late Function(String) addToPantry;

  @override
  void initState() {
    super.initState();
    shoppingList = widget.shoppingList;
    boughtStatus = widget.boughtStatus;
    displayedShoppingList = shoppingList;
    addToPantry = widget.addToPantry;
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
                      borderSide: BorderSide(
                          color: Color(0xFFBF7979)),
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
                            addToPantry(displayedShoppingList[index]);
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFBF7979),
        tooltip: "Adicionar novo ingrediente",
        onPressed: () {
          _navigateToIngredientSearch();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
