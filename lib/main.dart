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
      child: ListView(children: [
        const DrawerHeader(child: Text('TEMPORARY HEADER')),
        ListTile(
            leading: const Icon(Icons.star),
            title: const Text('TEMPORARY TITLE 1'),
            onTap: () {
              Provider.of<SelectedCategory>(context, listen: false)
                  .setCategory('Category 1');
              Navigator.pop(context);
            }),
        ListTile(
            leading: const Icon(Icons.star),
            title: const Text('TEMPORARY TITLE 2'),
            onTap: () {
              Provider.of<SelectedCategory>(context, listen: false)
                  .setCategory('Category 2');
              Navigator.pop(context);
            }),
      ]),
    );
  }
}

class RecipeListView extends StatefulWidget {
  const RecipeListView({Key? key}) : super(key: key);

  @override
  State<RecipeListView> createState() => _RecipeListViewState();
}

class _RecipeListViewState extends State<RecipeListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      ListTile(
          leading: const Icon(Icons.star),
          title: Consumer<SelectedCategory>(builder: (context, info, child) {
            return Text(info.getCategory());
          }),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RecipeDetailView()));
          }),
      ListTile(
          leading: const Icon(Icons.star),
          title: const Text('TEMPORARY TITLE 2'),
          onTap: () {}),
    ]);
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
