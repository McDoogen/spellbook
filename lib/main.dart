import 'package:flutter/material.dart';
import 'package:spellbook/recipe_db.dart';
import 'package:provider/provider.dart';
import 'package:spellbook/models/selected_category.dart';

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
        home: ChangeNotifierProvider(
          create: (context) => SelectedCategory(),
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
      return FutureBuilder<List<String>>(
        future: dbHandler.getRecipeList(value.getCategory()),
        builder: ((context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              return ListTile(title: Text(snapshot.data![index]));
            },
          );
        }),
      );
    }));
  }
}

class RecipeDetailView extends StatefulWidget {
  const RecipeDetailView({Key? key}) : super(key: key);

  @override
  State<RecipeDetailView> createState() => _RecipeDetailViewState();
}

class _RecipeDetailViewState extends State<RecipeDetailView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('TEMPORARY BUTTON')),
    );
  }
}
