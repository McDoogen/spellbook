import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spellbook/models/selected_recipe.dart';
import 'package:spellbook/pages/recipe_creator.dart';
import 'package:spellbook/pages/recipe_detail.dart';
import 'package:spellbook/models/recipe_model.dart';

class RecipeNavigatorPage extends StatelessWidget {
  const RecipeNavigatorPage({Key? key}) : super(key: key);

  final Recipe testRecipe = const Recipe(
      id: 1,
      title: 'TEST',
      category: 'test',
      processes: ['test'],
      ingredients: ['test']);

  void _navigateToCreator(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const RecipeCreatorPage()));
  }

  void _navigateToDetail(context, recipe) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RecipeDetailPage(recipe: recipe)));
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SelectedRecipe())
        ],
        child: Scaffold(
          appBar: AppBar(title: const Text('Recipe Navigator Page!')),
          body: Center(
              child: ElevatedButton(
            child: const Text('Go to Recipe Detail'),
            //TODO:DS: place the consumer here and put a Recipe in the Detail view Constructor!
            //TODO:DS: Or instead, make a fake list and pass the list value. Maybe we don't need provider here
            onPressed: () => _navigateToDetail(context, testRecipe),
          )),
          floatingActionButton: FloatingActionButton(
              onPressed: () => _navigateToCreator(context),
              child: const Icon(Icons.add)),
        ));
  }
}
