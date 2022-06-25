import 'package:flutter/material.dart';
import 'package:spellbook/pages/recipe_editor.dart';
import 'package:spellbook/models/recipe_model.dart';

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
    String recipeCategory = recipe.category;
    List<String> recipeIngredients = recipe.ingredients;
    List<String> recipeProcess = recipe.processes;
    final listItemCount = recipeIngredients.length + recipeProcess.length + 2;

    return Scaffold(
      appBar: AppBar(title: Text('$recipeTitle : $recipeCategory')),
      body: ListView.builder(
        itemCount: listItemCount,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const ListTile(
              title: Center(
                child: Text('Ingredients'),
              ),
              tileColor: Colors.red,
            );
          } else if (index <= recipeIngredients.length) {
            final ingredientText = recipeIngredients[index - 1];
            return ListTile(
              title: Text(ingredientText),
            );
          } else if (index == recipeIngredients.length + 1) {
            return const ListTile(
              title: Center(child: Text('Process')),
              tileColor: Colors.red,
            );
          } else {
            final relativeIndex = index - 2 - recipeIngredients.length;
            final processText = recipeProcess[relativeIndex];
            return ListTile(title: Text('${relativeIndex + 1}. $processText'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateToEditor(context),
          child: const Icon(Icons.edit)),
    );
  }
}
