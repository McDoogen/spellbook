import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:spellbook/models/recipe_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

/// This Service will help with Storing and Retrieving Recipes from the DB
///
/// ~ DB Tables ~
/// > Recipe
/// ID
/// Title
/// Category
///
/// > IngredientList
/// Recipe ID
/// Order ID
/// Text
///
/// > Process List
/// Recipe ID
/// Order ID
/// Text

class RecipeStorageService {
  Future<Recipe> getRecipe(int recipeId) async {
    Database db = await DatabaseHelper().database;
    List<Map<dynamic, dynamic>> recipeDetail = await db.query(
        DatabaseHelper.recipeDetailTable,
        columns: ['recipeId', 'title', 'category'],
        where: 'recipeId = ?',
        whereArgs: [recipeId]);
    //TODO:DS: Response when recipeId not found?
    final recipeTitle = recipeDetail.first['title'];
    final recipeCategory = recipeDetail.first['category'];

    //TODO:DS: Make sure the query is sorted by OrderId
    List<Map<dynamic, dynamic>> ingredientList = await db.query(
        DatabaseHelper.ingredientListTable,
        columns: ['recipeId', 'orderId', 'ingredient'],
        where: 'recipeId = ?',
        whereArgs: [recipeId],
        orderBy: 'orderId');
    final List<String> recipeIngredients = [];
    for (Map<dynamic, dynamic> ingredient in ingredientList) {
      recipeIngredients.add(ingredient['ingredient']);
    }

    //TODO:DS: Make sure the query is sorted by OrderId
    List<Map<dynamic, dynamic>> processList = await db.query(
        DatabaseHelper.processListTable,
        columns: ['recipeId', 'orderId', 'process'],
        where: 'recipeId = ?',
        whereArgs: [recipeId],
        orderBy: 'orderId');
    final List<String> recipeProcesses = [];
    for (Map<dynamic, dynamic> process in processList) {
      recipeProcesses.add(process['process']);
    }

    return Recipe(
        id: recipeId,
        title: recipeTitle,
        category: recipeCategory,
        ingredients: recipeIngredients,
        processes: recipeProcesses);
  }

  Future<List<Recipe>> getRecipes() async {
    Database db = await DatabaseHelper().database;

    List<Map<String, dynamic>> recipeDatabaseList =
        await db.query(DatabaseHelper.recipeDetailTable, orderBy: 'recipeId');
    // List<Map<String,dynamic>> recipeIngredientList = await db.query(DatabaseHelper.ingredientListTable, orderBy: 'orderId');
    // List<Map<String,dynamic>> recipeProcessList = await db.query(DatabaseHelper.processListTable, orderBy: 'orderId');

    List<Recipe> recipeList = [];
    //TODO:DS: Add ingredients & Processes?
    for (Map<String, dynamic> databaseRecipe in recipeDatabaseList) {
      recipeList.add(Recipe(
          id: databaseRecipe['recipeId'],
          title: databaseRecipe['title'],
          category: databaseRecipe['category'],
          ingredients: [],
          processes: []));
    }
    return recipeList;
  }

  Future addRecipe(String title, String category, List<String> ingredients,
      List<String> processes) async {
    Database db = await DatabaseHelper().database;

    // Generate Recipe ID
    List<Map<dynamic, dynamic>> recipeList = await db.query(
        DatabaseHelper.recipeDetailTable,
        columns: ['recipeId'],
        orderBy: 'recipeId');
    int recipeId = 0;
    if (recipeList.isEmpty) {
      recipeId = 1;
    } else {
      for (int i = 0; i < recipeList.length; i++) {
        if (recipeList[i]['recipeId'] != i + 1) {
          recipeId = i + 1;
          break;
        }
      }
      if (recipeId == 0) {
        recipeId = recipeList.length + 1;
      }
    }

    // Detail Table
    await db.insert(
        DatabaseHelper.recipeDetailTable,
        {
          'recipeId': recipeId,
          'title': title,
          'category': category,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);

    // Ingredient Table
    for (int i = 0; i < ingredients.length; i++) {
      await db.insert(
          DatabaseHelper.ingredientListTable,
          {
            'recipeId': recipeId,
            'orderId': i + 1,
            'ingredient': ingredients[i]
          },
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    // Process Table
    for (int i = 0; i < processes.length; i++) {
      await db.insert(DatabaseHelper.processListTable,
          {'recipeId': recipeId, 'orderId': i + 1, 'process': processes[i]},
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future updateRecipe(Recipe recipe) async {}

  Future deleteRecipe(int recipeId) async {
    Database db = await DatabaseHelper().database;
    db.delete(DatabaseHelper.recipeDetailTable,
        where: 'recipeId = ?', whereArgs: [recipeId]);
    db.delete(DatabaseHelper.ingredientListTable,
        where: 'recipeId = ?', whereArgs: [recipeId]);
    db.delete(DatabaseHelper.processListTable,
        where: 'recipeId = ?', whereArgs: [recipeId]);
  }

  Future deleteEverything() async {
    Database db = await DatabaseHelper().database;
    db.delete(DatabaseHelper.recipeDetailTable);
    db.delete(DatabaseHelper.ingredientListTable);
    db.delete(DatabaseHelper.processListTable);
  }
}

class DatabaseHelper {
  static const _databaseName = "RecipeBook.db";
  static const _databaseVersion = 1;
  static const recipeDetailTable = 'recipe_detail';
  static const ingredientListTable = 'ingredient_list';
  static const processListTable = 'process_list';

  Future<Database> get database async {
    return await _initDatabase();
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE $recipeDetailTable (
      recipeId INTEGER,
      title TEXT,
      category TEXT)''');

    await db.execute('''CREATE TABLE $ingredientListTable (
      recipeId INTEGER,
      orderId INTEGER,
      ingredient TEXT)''');

    await db.execute('''CREATE TABLE $processListTable (
      recipeId INTEGER,
      orderId INTEGER,
      process TEXT)''');
  }
}
