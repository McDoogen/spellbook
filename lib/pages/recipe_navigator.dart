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
      title: 'Drop Biscuits',
      category: 'Breakfast',
      processes: [
        'Preheat oven to 425 F',
        'Mix dry',
        'Cut butter into flour mix using pastry blender',
        'Add milk',
        'Quickly and briefly mix together',
        'Scoop out biscuits by hand and plop them onto baking sheet',
        'For added Pazzaz, add kosher salt to pan before plopping biscuits',
        'Bake until tips start to brown, then turn off the oven and make coffee!'
      ],
      ingredients: [
        '120g AP Flour',
        '1/2 tsp Salt',
        '1 tsp Baking Powder',
        '1.5 tsp Sugar',
        '30g Butter',
        '90g Milk'
      ]);

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
