import 'dart:io';

import 'models/Ingredient.dart';
import 'models/Recipe.dart';

final List<Recipe> exampleRecipes = [
  Recipe(
    picture: File("assets/images/chocolate-cake.jpg"),
    title: 'Chocolate Cake',
    portions: 8,
    duration: 60,
    ingredients: [
      Ingredient(name: 'Flour', quantity: 2, units: 'cups'),
      Ingredient(name: 'Sugar', quantity: 1, units: 'cup'),
      Ingredient(name: 'Cocoa powder', quantity: 1, units: 'cup'),
      // ... other ingredients
    ],
    steps: [
      'Preheat the oven to 350°F (175°C).',
      'Mix dry ingredients together.',
      'Add wet ingredients and mix well.',
      'Pour the batter into a greased cake pan.',
      'Bake for 30-35 minutes or until a toothpick inserted in the center comes out clean.',
      // ... other steps
    ],
  ),
  Recipe(
    picture: File("assets/images/spaghetti-bolognese.jpeg"),
    title: 'Spaghetti Bolognese',
    portions: 4,
    duration: 45,
    ingredients: [
      Ingredient(name: 'Spaghetti', quantity: 200, units: 'grams'),
      Ingredient(name: 'Ground beef', quantity: 400, units: 'grams'),
      Ingredient(name: 'Tomato sauce', quantity: 1, units: 'can'),
      // ... other ingredients
    ],
    steps: [
      'Boil water and cook spaghetti according to package instructions.',
      'Brown ground beef in a pan.',
      'Add tomato sauce and simmer for 15-20 minutes.',
      'Serve sauce over cooked spaghetti.',
      // ... other steps
    ],
  ),
  // Add more recipes as needed
];
