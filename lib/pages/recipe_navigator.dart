import 'package:flutter/material.dart';
import 'package:spellbook/pages/recipe_creator.dart';
import 'package:spellbook/pages/recipe_detail.dart';

class RecipeNavigatorPage extends StatelessWidget {
  const RecipeNavigatorPage({Key? key}) : super(key: key);

  void _navigateToCreator(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const RecipeCreatorPage()));
  }

  void _navigateToDetail(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const RecipeDetailPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe Navigator Page!')),
      body: Center(
          child: ElevatedButton(
        child: const Text('Go to Recipe Detail'),
        onPressed: () => _navigateToDetail(context),
      )),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateToCreator(context),
          child: const Icon(Icons.add)),
    );
  }
}
