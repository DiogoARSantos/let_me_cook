import 'package:flutter/material.dart';
import '../../allIngredients.dart';

class IngredientSearchScreen extends StatefulWidget {
  final List<String> shoppingList;
  final List<bool> boughtStatus;

  IngredientSearchScreen({required this.shoppingList, required this.boughtStatus});

  @override
  State<IngredientSearchScreen> createState() => _IngredientSearchScreenState();
}

class _IngredientSearchScreenState extends State<IngredientSearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> filteredIngredients = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    filteredIngredients = allIngredients; // Initialize with all ingredients
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
          .where((ingredient) =>
          ingredient.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Ingrediente'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Procurar ingredientes...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _onSearchChanged();
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredIngredients.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredIngredients[index]),
                  onTap: () {
                    setState(() {
                      print("Ingrediente a adicionar: ${filteredIngredients[index]}");
                      if (!widget.shoppingList.contains(filteredIngredients[index])) {
                        widget.shoppingList.add(filteredIngredients[index]);
                        widget.boughtStatus.add(false);
                      }
                      Navigator.pop(context, widget.shoppingList);
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}