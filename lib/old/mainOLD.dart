import 'package:flutter/material.dart';
import 'package:spellbook/old/recipe_db.dart';
import 'package:provider/provider.dart';
import 'package:spellbook/old/selected_category.dart';

//TODO:DS:
// 1. Can I switch theses widgets to stateless?
// 2. How do I use the widget test thing?

/*
    ~~~ Project Architecture ~~~
    - Folder-by-layer for simplicity
    - Provider design pattern (and package) for state management
    - Flutter Navigation 2.0 for routing
    - Minimalist, MVVM, BloC... ?

    ~~~ Project Features ~~~
    - Add new Recipe
    - Edit existing Recipe
    - Recipe Detail View
    - Recipe Navigation

    ~~~ Reading ~~~
    - Minimalist: https://suragch.medium.com/flutter-state-management-for-minimalists-4c71a2f2f0c1
    - BLoC: https://www.raywenderlich.com/4074597-getting-started-with-the-bloc-pattern
*/

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
      initialRoute: '/',
      routes: {
        '/': (context) => const RecipeBookHome(),
        '/creator': (context) => const RecipeCreator(),
        '/creator/Page1': (context) => const Page1(),
        '/creator/Page2': (context) => const Page2()
      },
    );
  }
}

class RecipeBookHome extends StatelessWidget {
  const RecipeBookHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: ((context) => SelectedCategory())),
        ],
        child: Scaffold(
            appBar: AppBar(title: const Text('TEMPORARY APPBAR TITLE')),
            body: const RecipeListView(),
            drawer: const RecipeCategoryList(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/creator');
              },
              child: const Icon(Icons.numbers),
            )));
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

class RecipeCreator extends StatelessWidget {
  const RecipeCreator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('TEMP RECIPE CREATE'),
        ),
        body: Center(
            child: ElevatedButton(
          child: const Icon(Icons.hail),
          onPressed: () {
            Navigator.pushNamed(context, '/creator/Page1');
          },
        )));
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Page 1')),
        body: Center(
            child: ElevatedButton(
          child: const Icon(Icons.fire_extinguisher),
          onPressed: () {
            Navigator.pushNamed(context, '/creator/Page2');
          },
        )));
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Page 2')),
        body: Center(
            child: ElevatedButton(
          child: const Icon(Icons.waterfall_chart),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        )));
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
                //TODO:DS: So what does the Recipe Contain?
                // Title
                // Category
                // List of Ingredients (Table of Ingredients, match by Recipe ID)
                //  //  Ingredient Text, Ingredient Order, Recipe ID
                //  //  Future: separate Ingredient Name, Quantity, and Unit
                // List of Steps to Make it (Table of Process, match by Recipe ID)
                //  //  Step Text, Step Order, Recipe ID
                // Edit Button (Make sure the button doesn't block any view)
                appBar: AppBar(title: Text(snapshot.data!.title)),
                body: const Center(child: Icon(Icons.cake, size: 200)));
          } else {
            return const Center(child: Icon(Icons.question_mark, size: 200));
          }
        }));
  }
}
