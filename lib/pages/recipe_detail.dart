import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spellbook/models/selected_recipe.dart';
import 'package:spellbook/pages/recipe_editor.dart';
import 'package:spellbook/models/recipe_model.dart';

/**
 * ~~~ Page Objectives ~~~
 * > Show Details of a Recipe Object
 * > Have a button to navigate to the Recipe Editor Page
 * > Have a button to return to the Recipe Navigator Page
 * 
 * 
 * ~~~ State Variables ~~~
 * > Recipe Object
 */

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({Key? key, required this.recipe}) : super(key: key);

  final Recipe recipe;

  void _navigateToEditor(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const RecipeEditorPage()));
  }

  @override
  Widget build(BuildContext context) {
    String recipeTitle = recipe.title;
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe Detail Page')),
      body: Center(child: Text('Name: $recipeTitle')),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateToEditor(context),
          child: const Icon(Icons.edit)),
    );
  }
}
