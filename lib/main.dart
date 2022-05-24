import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:spellbook/recipe_db.dart';
import 'package:provider/provider.dart';

import 'package:spellbook/spell_db.dart';

void main() => runApp(const RecipeBook());

/**
 * Widget Structure
 * Recipebook - MaterialApp>Scaffold, stateless; root widget for entire project
 * RecipeCategoryList - Drawer, stateful?; contains selectable list of categories
 * RecipeListView - ListView, stateful; contains list of recipes to choose from
 * RecipeDetailView - Contains contents of a recipe
 * 
 * 
 * Editing?
 * Adding new?
 * 
 * 
 * Procedure:
 * Select a category and POP
 * Update List View based on category
 * Select Recipe from List View to navigate to Recipe
 */

class RecipeInfo extends ChangeNotifier {
  String selectedCategory = '';

  String get categoryName => selectedCategory;

  void selectCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }
}

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
          create: (context) => RecipeInfo(),
          child: Scaffold(
            appBar: AppBar(title: const Text('TEMPORARY APPBAR TITLE')),
            body: const RecipeListView(),
            drawer: const RecipeCategoryList(),
          ),
        ));
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
              Provider.of<RecipeInfo>(context, listen: false)
                  .selectCategory('Category 1');
              Navigator.pop(context);
            }),
        ListTile(
            leading: const Icon(Icons.star),
            title: const Text('TEMPORARY TITLE 2'),
            onTap: () {
              Provider.of<RecipeInfo>(context, listen: false)
                  .selectCategory('Category 2');
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
          title: Consumer<RecipeInfo>(builder: (context, info, child) {
            return Text(info.categoryName);
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

// Everything below is testing :D

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spellbook Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Page3(),
    );
  }
}

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  int _listState = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Hello!')),
        body: ListView(
          children: [
            for (int i = 0; i < _listState; i++)
              const ListTile(
                leading: Icon(Icons.abc),
                title: TestWidget(),
              ),
          ],
        ),
        drawer: Drawer(
            child: ListView(children: [
          const DrawerHeader(child: Center(child: Text('Hello!'))),
          ListTile(
            leading: const Icon(Icons.arrow_right),
            title: const Text('Cakes!'),
            onTap: () {
              _changeListState(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.arrow_right),
            title: const Text('Breads!'),
            onTap: () {
              _changeListState(2);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.arrow_right),
            title: const Text('Brazilian!'),
            onTap: () {
              _changeListState(3);
              Navigator.pop(context);
            },
          )
        ])));
  }

  void _changeListState(int number) {
    setState(() {
      _listState = number;
    });
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hello!')),
      body: const Center(child: Text('Hello!')),
      drawer: Drawer(
        child: ListView(children: [
          const DrawerHeader(child: Center(child: Text('Hello!'))),
          ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Star!'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Page2()));
              }),
          const ListTile(),
          const ListTile(),
        ]),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Return!")));
  }
}
