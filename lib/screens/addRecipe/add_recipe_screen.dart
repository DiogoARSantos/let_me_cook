import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:let_me_cook/models/Recipe.dart';
import 'package:let_me_cook/models/Ingredient.dart';
import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';

import '../../allIngredients.dart';

class AddRecipeScreen extends StatefulWidget {
  final Function(Recipe) addRecipe;
  final Function() backToHomeScreen;

  AddRecipeScreen({required this.addRecipe, required this.backToHomeScreen});

  @override
  AddRecipeScreenState createState() => AddRecipeScreenState();
}

class AddRecipeScreenState extends State<AddRecipeScreen> {
  File? _selectedImage;
  String _title = '';
  int _portions = 0;
  int _duration = 0;
  List<Ingredient> _ingredients = [];
  List<String> _steps = [];
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _ingredientsItems = [];
  final List<TextEditingController> _ingredientsQts = [];
  final List<TextEditingController> _ingredientsUnits = [];
  final List<TextEditingController> _stepsItems = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Text(
                    "Criar Nova Receita",
                    style: TextStyle(
                      height: 2,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                //PICTURE
                _selectedImage == null
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200.0,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 186, 186, 186),
                          image: DecorationImage(
                            scale: 5,
                            image: AssetImage("assets/images/camera.png"),
                          ),
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            alignment: Alignment.bottomCenter,
                            image: FileImage(_selectedImage!),
                          ),
                        ),
                      ),
                MaterialButton(
                  color: Color(0xFFBF7979),
                  child: const Text("Escolher ficheiro",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )),
                  onPressed: () {
                    _pickImageFromGallery();
                  },
                ),
                SizedBox(height: 20),

                //TITLE
                _buildTitleField(),
                SizedBox(height: 20),

                // PORTIONS and DURATION in the same row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Nº de porções",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(2),
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Introduzir porções";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _portions = int.parse(value!);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Tempo de Preparação (minutos)",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Introduzir duração";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _duration = int.parse(value!);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                //INGREDIENTS
                Divider(
                  color: Colors.black,
                  thickness: 1,
                  height: 20,
                ),
                Align(
                  alignment: Alignment(-0.9, 0),
                  child: Row(
                    children: [
                      Text("Ingredientes",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(width: 5),
                      Tooltip(
                        richMessage: WidgetSpan(
                            alignment: PlaceholderAlignment.top,
                            baseline: TextBaseline.alphabetic,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              constraints: const BoxConstraints(maxWidth: 280),
                              child: Text(
                                  "Qnt: Quantidade a adicionar\nUnid: Unidades de medida",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                            )),
                        triggerMode: TooltipTriggerMode.tap,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Icon(
                          Icons.info_outline,
                          size: 22,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                for (int i = 0; i < _ingredientsItems.length; i++)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            child: const Icon(Icons.delete_outline),
                            onTap: () {
                              _removeIngredientField(i);
                            },
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: _buildIngredientField(i),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(3),
                                ],
                                controller: _ingredientsQts[i],
                                decoration: InputDecoration(
                                    labelText: 'Qnt',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: EdgeInsets.all(2),
                                  child: TextFormField(
                                    controller: _ingredientsUnits[i],
                                    decoration: InputDecoration(
                                        labelText: 'Unid',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        )),
                                    validator: (value) {
                                      if (value == "" || value == "0") {
                                        return "Introduzir";
                                      }
                                      return null;
                                    },
                                  ))),
                        ],
                      ),
                    ],
                  ),

                //INGREDIENT BUTTONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add_box_outlined),
                      label: const Text('Adicionar Ingrediente'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF6BB05A),
                      ),
                      onPressed: () {
                        _addIngredientField();
                      },
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.disabled_by_default_outlined),
                      label: const Text('Limpar Tudo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFDC2A2A),
                      ),
                      onPressed: () {
                        _removeAllIngredientFields();
                      },
                    )
                  ],
                ),

                //STEPS
                Divider(
                  color: Colors.black,
                  thickness: 1,
                  height: 20,
                ),
                Align(
                  alignment: Alignment(-1, 0),
                  child: Text("Passos",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ),

                for (int i = 0; i < _stepsItems.length; i++)
                  Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          child: const Icon(Icons.delete_outline),
                          onTap: () {
                            _removeStepField(i);
                          },
                        )
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Expanded(
                          flex: 3,
                          child: Padding(
                              padding: EdgeInsets.all(2),
                              child: TextFormField(
                                maxLines: 10,
                                controller: _stepsItems[i],
                                decoration: InputDecoration(
                                    labelText: 'Passo ${i + 1}',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                                validator: (value) {
                                  if (value == "") {
                                    return "Introduzir passo";
                                  }
                                  return null;
                                },
                              ))),
                    ]),
                  ]),

                //STEP BUTTONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add_box_outlined),
                      label: const Text('Adicionar Passo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF6BB05A),
                      ),
                      onPressed: () {
                        _addStepField();
                      },
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.disabled_by_default_outlined),
                      label: const Text('Limpar Tudo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFDC2A2A),
                      ),
                      onPressed: () {
                        _removeAllStepFields();
                      },
                    )
                  ],
                ),
                SizedBox(height: 10),
                //CREATE BUTTON
                ElevatedButton(
                  onPressed: _createRecipe,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(
                        0xFF6BB05A), // Set your desired background color here
                  ),
                  child: Text('Criar Receita'),
                ),
              ])
        ]),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        _selectedImage = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget _buildTitleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Título da Receita",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
              border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Introduzir o título';
            }
            return null;
          },
          onSaved: (value) {
            _title = value!;
          },
        ),
      ],
    );
  }

  Widget _buildIngredientField(int index) {
    var number = index + 1;
    return DropdownSearch<String>(
      popupProps: PopupProps.menu(
        showSearchBox: true,
        showSelectedItems: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: "Pesquisar ingrediente...",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        emptyBuilder: (context, searchEntry) {
          return Center(
            child: Text(
              'Nenhum ingrediente encontrado',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          );
        },
      ),
      items: allIngredients,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: 'Ingrediente $number',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      onChanged: (String? selectedIngredient) {
        _ingredientsItems[index].text = selectedIngredient ?? '';
      },
      selectedItem: _ingredientsItems[index].text,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Introduzir ingrediente';
        }
        return null;
      },
    );
  }

  _removeAllIngredientFields() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFBF7979),
          title: Text('Limpar todos os ingredientes',
              style: TextStyle(color: Colors.white)),
          content: Text(
              'Tem a certeza que deseja limpar todos os ingredientes?',
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirmar',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              onPressed: () {
                setState(() {
                  _ingredientsItems.clear();
                  _ingredientsQts.clear();
                  _ingredientsUnits.clear();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _removeAllStepFields() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFBF7979),
          title: Text('Limpar todos os passos',
              style: TextStyle(color: Colors.white)),
          content: Text('Tem a certeza que deseja limpar todos os passos?',
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirmar',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              onPressed: () {
                setState(() {
                  _stepsItems.clear();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _addIngredientField() {
    setState(() {
      _ingredientsItems.add(TextEditingController());
      _ingredientsQts.add(TextEditingController());
      _ingredientsUnits.add(TextEditingController());
    });
  }

  _removeIngredientField(i) {
    setState(() {
      _ingredientsItems.removeAt(i);
      _ingredientsQts.removeAt(i);
      _ingredientsUnits.removeAt(i);
    });
  }

  _addStepField() {
    setState(() {
      _stepsItems.add(TextEditingController());
    });
  }

  _removeStepField(i) {
    setState(() {
      _stepsItems.removeAt(i);
    });
  }

  void _createRecipe() {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      print("NULL");
    } else if (_ingredientsItems.isEmpty || _stepsItems.isEmpty) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              backgroundColor: Colors.red,
              title: Text(
                'Ingredientes e passos necessários',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            );
          });
    } else {
      _formKey.currentState!.save();
      for (int i = 0; i < _ingredientsItems.length; i++) {
        if (_ingredientsQts[i].text == "") {
          _ingredientsQts[i].text = "0";
        }
        Ingredient igt = Ingredient(
            name: capitalizeFirst(_ingredientsItems[i].text.toLowerCase()),
            quantity: int.parse(_ingredientsQts[i].text),
            units: _ingredientsUnits[i].text);
        _ingredients.add(igt);
      }
      for (int i = 0; i < _stepsItems.length; i++) {
        _steps.add(_stepsItems[i].text);
      }
      Recipe recipe = Recipe(
          picture: _selectedImage,
          title: _title,
          portions: _portions,
          duration: _duration,
          ingredients: _ingredients,
          steps: _steps);
      widget.addRecipe(recipe);
      widget.backToHomeScreen();
      _showSuccessPopup();
    }
  }

  String capitalizeFirst(String text) {
    if (text.isEmpty) {
      return '';
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  void _showSuccessPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop(true);
        });
        return AlertDialog(
          title: Text(
            'Sucesso!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Receita criada com sucesso.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF6BB05A),
        );
      },
    );
  }
}
