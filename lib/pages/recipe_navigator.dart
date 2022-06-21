import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spellbook/models/selected_recipe.dart';
import 'package:spellbook/pages/recipe_creator.dart';
import 'package:spellbook/pages/recipe_detail.dart';
import 'package:spellbook/models/recipe_model.dart';

class RecipeNavigatorPage extends StatelessWidget {
  const RecipeNavigatorPage({Key? key}) : super(key: key);

  final Recipe testRecipeA = const Recipe(
      id: 1,
      title: 'Carrot Cake',
      category: 'Cake',
      processes: ['Mix Everything', 'Preheat the Oven', 'Bake it', 'Eat it!'],
      ingredients: ['1 egg', '24g Carrots', '1 tsp Flour']);

  final Recipe testRecipeB = const Recipe(
      id: 1,
      title: 'Orange Cake',
      category: 'Cake',
      processes: ['Mix Wet', 'Mix Dry', 'Freeze it', 'Make a wish', 'Enjoy!'],
      ingredients: ['2 kg Orange, peeled', 'A Cake', 'Super Glue']);

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
          body: ListView(
            children: [
              ListTile(
                  title: const Text('A'),
                  onTap: () => _navigateToDetail(context, testRecipeA)),
              ListTile(
                  title: const Text('B'),
                  onTap: () => _navigateToDetail(context, testRecipeB))
            ],
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () => _navigateToCreator(context),
              child: const Icon(Icons.add)),
        ));
  }
}
