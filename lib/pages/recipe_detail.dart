import 'package:flutter/material.dart';
import 'package:spellbook/pages/recipe_editor.dart';

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({Key? key}) : super(key: key);

  void _navigateToEditor(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const RecipeEditorPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe Detail Page')),
      body: const Center(child: Icon(Icons.pages)),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateToEditor(context),
          child: const Icon(Icons.edit)),
    );
  }
}
