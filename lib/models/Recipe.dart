import 'dart:io';

class Recipe{
  File? picture;
  String title;
  int portions;
  int duration;
  List ingredients;
  List steps;

  Recipe({this.picture, required this.title, required this.portions, required this.duration, required this.ingredients, required this.steps});
}