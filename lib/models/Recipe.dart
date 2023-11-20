import 'dart:io';

import 'package:let_me_cook/models/Ingredient.dart';

class Recipe{
  File? picture;
  String title;
  int portions;
  int duration;
  List<Ingredient> ingredients;
  List steps;

  Recipe({this.picture, required this.title, required this.portions, required this.duration, required this.ingredients, required this.steps});
}