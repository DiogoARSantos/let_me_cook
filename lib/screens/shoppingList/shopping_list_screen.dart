import 'package:flutter/material.dart';

import '../../allIngredients.dart';

class ShoppingListScreen extends StatefulWidget {
  final List<String> shoppingList;

  ShoppingListScreen({
    required this.shoppingList,
  });

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  TextEditingController _searchController = TextEditingController();

  List<String> filteredIngredients = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
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
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    )),
              ),
              SizedBox(height: 20),
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
                  ),
                  onChanged: (value) {
                    _onSearchChanged();
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.shoppingList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(widget.shoppingList[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            widget.shoppingList.removeAt(index);
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
                            if (!widget.shoppingList.contains(ingredient)) {
                              widget.shoppingList.add(ingredient);
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
