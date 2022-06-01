import 'package:flutter/material.dart';
import 'package:spellbook/recipe_db.dart';
import 'package:provider/provider.dart';
import 'package:spellbook/models/selected_category.dart';

//TODO:DS:
// 1. Can I switch theses widgets to stateless?
// 2. How do I use the widget test thing?

void main() => runApp(const RecipeBook());

class RecipeBook extends StatelessWidget {
  const RecipeBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Recipe Book',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: ((context) => SelectedCategory())),
          ],
          child: Scaffold(
              appBar: AppBar(title: const Text('TEMPORARY APPBAR TITLE')),
              body: const RecipeListView(),
              drawer: const RecipeCategoryList(),
              floatingActionButton: const TestRecipeAdder()),
        ));
  }
}

class TestRecipeAdder extends StatefulWidget {
  const TestRecipeAdder({Key? key}) : super(key: key);

  @override
  State<TestRecipeAdder> createState() => _TestRecipeAdderState();
}

class _TestRecipeAdderState extends State<TestRecipeAdder> {
  late RecipeDatabaseHandler dbHandler;

  @override
  void initState() {
    super.initState();
    dbHandler = RecipeDatabaseHandler();
    dbHandler.initializeDB().whenComplete(() async {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: dbHandler.tests, child: const Icon(Icons.add));
  }
}

class RecipeCategoryList extends StatefulWidget {
  const RecipeCategoryList({Key? key}) : super(key: key);

  @override
  State<RecipeCategoryList> createState() => _RecipeCategoryListState();
}

class _RecipeCategoryListState extends State<RecipeCategoryList> {
  late RecipeDatabaseHandler dbHandler;

  @override
  void initState() {
    super.initState();
    dbHandler = RecipeDatabaseHandler();
    dbHandler.initializeDB().whenComplete(() async {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: FutureBuilder<List<String>>(
      future: dbHandler.getCategoryList(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator(); //TODO:DS: Is this correct?
        } else if (snapshot.hasError) {
          return const Text("There was an Error!"); //TODO:DS: Is this correct?
        } else {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: ((context, index) {
                return ListTile(
                    title: Text(snapshot.data![index]),
                    onTap: () {
                      Provider.of<SelectedCategory>(context, listen: false)
                          .setCategory(snapshot.data![index]);
                      Navigator.pop(context);
                    });
              }));
        }
      },
    ));
  }
}

class RecipeListView extends StatefulWidget {
  const RecipeListView({Key? key}) : super(key: key);

  @override
  State<RecipeListView> createState() => _RecipeListViewState();
}

class _RecipeListViewState extends State<RecipeListView> {
  late RecipeDatabaseHandler dbHandler;

  @override
  void initState() {
    //TODO:DS: do we really need to do all this twice? Or is there a better way?
    super.initState();
    dbHandler = RecipeDatabaseHandler();
    dbHandler.initializeDB().whenComplete(() async {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedCategory>(builder: ((context, value, child) {
      return FutureBuilder<List<Recipe>>(
        future: dbHandler.readRecipes(value.getCategory()),
        builder: ((context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(snapshot.data![index].title),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecipeDetailView(
                                recipeId: snapshot.data![index].id)));
                  });
            },
          );
        }),
      );
    }));
  }
}

class RecipeDetailView extends StatefulWidget {
  const RecipeDetailView({Key? key, this.recipeId = 1}) : super(key: key);

  final int recipeId;

  @override
  State<RecipeDetailView> createState() => _RecipeDetailViewState();
}

class _RecipeDetailViewState extends State<RecipeDetailView> {
  late RecipeDatabaseHandler dbHandler;

  @override
  void initState() {
    //TODO:DS: do we really need to do all this twice? Or is there a better way?
    super.initState();
    dbHandler = RecipeDatabaseHandler();
    dbHandler.initializeDB().whenComplete(() async {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Recipe>(
        future: dbHandler.readRecipe(
            widget.recipeId), //TODO:DS: how to handle recipeId not found?
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(title: Text(snapshot.data!.title)),
                body: const Center(child: Icon(Icons.cake, size: 200)));
          } else {
            return const Center(child: Icon(Icons.question_mark, size: 200));
          }
        }));
  }
}
