import 'package:flutter/material.dart';
import 'package:spellbook/models/recipe_model.dart';

class SelectedRecipe extends ChangeNotifier {
  Recipe selectedRecipe = const Recipe(
      id: 0, title: '', category: '', ingredients: [], processes: []);

  void update(Recipe recipe) {
    selectedRecipe = recipe;
    notifyListeners();
  }

  Recipe getRecipe() {
    return selectedRecipe;
  }
}
