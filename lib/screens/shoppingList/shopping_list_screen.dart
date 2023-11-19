import 'package:flutter/material.dart';

import '../../data.dart';

class ShoppingListScreen extends StatefulWidget {
  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  TextEditingController _searchController = TextEditingController();

  List<String> selectedIngredients = [];
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Adicionar ingredientes...',
                    prefixIcon: Icon(Icons.search, color: Color(0xFFBF7979), size: 40,),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Color(0xFFBF7979)), // Set transparent color
                    ),
                  ),
                  onChanged: (value) {
                    _onSearchChanged();
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: selectedIngredients.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(selectedIngredients[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            selectedIngredients.removeAt(index);
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
          if (_searchController.text.isNotEmpty && filteredIngredients.isNotEmpty)
            Positioned(
              top: 66.5,
              left: 9.0,
              right: 9.0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0)
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: filteredIngredients.map((ingredient) {
                      return ListTile(
                        title: Text(ingredient),
                        onTap: () {
                          setState(() {
                            if (!selectedIngredients.contains(ingredient)) {
                              selectedIngredients.add(ingredient);
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
