import 'package:flutter/material.dart';
import 'package:spellbook/services/recipe_storage_service.dart';
import 'package:spellbook/models/recipe_model.dart';

class RecipeCreatorPage extends StatelessWidget {
  const RecipeCreatorPage({Key? key}) : super(key: key);
  static final Map<String, Recipe> sampleRecipeMap = {
    'A': const Recipe(
      id: 0,
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
      ],
    ),
    'B': const Recipe(
        id: 0,
        title: 'Orange Cake',
        category: 'Cake',
        processes: ['Mix Wet', 'Mix Dry', 'Freeze it', 'Make a wish', 'Enjoy!'],
        ingredients: ['2 kg Orange, peeled', 'A Cake', 'Super Glue']),
    // 'C' : const Recipe(),
  };
  static final RecipeStorageService recipeStorageService =
      RecipeStorageService();

  void addRecipe(String mapId) async {
    if (sampleRecipeMap[mapId] == null) {
      return;
    }
    Recipe someRecipe = sampleRecipeMap[mapId]!;
    await recipeStorageService.addRecipe(someRecipe.title, someRecipe.category,
        someRecipe.ingredients, someRecipe.processes);
  }

  void removeRecipes() async {
    recipeStorageService.deleteEverything();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe Creator Page')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => addRecipe('A'),
              child: const Text('A'),
            ),
            ElevatedButton(
              onPressed: () => addRecipe('B'),
              child: const Text('B'),
            ),
            ElevatedButton(
              onPressed: () => addRecipe('C'),
              child: const Text('C'),
            ),
            ElevatedButton(
              onPressed: () => addRecipe('D'),
              child: const Text('D'),
            ),
            ElevatedButton(
              onPressed: () => addRecipe('E'),
              child: const Text('E'),
            ),
            ElevatedButton(
              onPressed: () => addRecipe('F'),
              child: const Text('F'),
            ),
            ElevatedButton(
              onPressed: () => addRecipe('G'),
              child: const Text('G'),
            ),
            ElevatedButton(
              onPressed: () => addRecipe('H'),
              child: const Text('H'),
            ),
            ElevatedButton(
              onPressed: () => addRecipe('I'),
              child: const Text('I'),
            ),
            ElevatedButton(
              onPressed: () => addRecipe('J'),
              child: const Text('J'),
            ),
            ElevatedButton(
              onPressed: () => removeRecipes(),
              child: const Text('X'),
            ),
          ],
        ),
      ),
    );
  }
}
