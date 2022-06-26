import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spellbook/models/selected_recipe.dart';
import 'package:spellbook/pages/recipe_creator.dart';
import 'package:spellbook/pages/recipe_detail.dart';
import 'package:spellbook/models/recipe_model.dart';
import 'package:spellbook/services/recipe_storage_service.dart';

class RecipeNavigatorPage extends StatelessWidget {
  const RecipeNavigatorPage({Key? key}) : super(key: key);

  static final RecipeStorageService recipeStorageService =
      RecipeStorageService();

  void _navigateToCreator(context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const RecipeCreatorPage()));
  }

  void _navigateToDetail(context, recipe) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RecipeDetailPage(recipe: recipe)));
  }

  Future<List<Recipe>> recipeListBuilder() async {
    return recipeStorageService.getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SelectedRecipe())
        ],
        child: Scaffold(
          appBar: AppBar(title: const Text('Recipe Navigator Page!')),
          body: FutureBuilder<List<Recipe>>(
            future: recipeListBuilder(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Recipe thisRecipe = snapshot.data![index];
                    return ListTile(
                        title: Text(thisRecipe.title),
                        onTap: () => _navigateToDetail(context, thisRecipe));
                  },
                );
              } else if (snapshot.hasError) {
                return const Text('There was an Error!');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () => _navigateToCreator(context),
              child: const Icon(Icons.add)),
        ));
  }
}
