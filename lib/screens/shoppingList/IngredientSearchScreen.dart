import 'package:flutter/material.dart';
import '../../allIngredients.dart';

class IngredientSearchScreen extends StatefulWidget {
  final List<String> shoppingList;
  final List<bool> boughtStatus;

  IngredientSearchScreen(
      {required this.shoppingList, required this.boughtStatus});

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
          .where((ingredient) => ingredient
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Ingrediente'),
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black87,
            size: 40,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Procurar ingredientes...',
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xFFBF7979),
                  size: 40,
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBF7979)),
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
              itemCount: filteredIngredients.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredIngredients[index]),
                  onTap: () {
                    setState(() {
                      if (!widget.shoppingList
                          .contains(filteredIngredients[index])) {
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
