import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class Recipe {
  final int id;
  final String title;
  final String category;

  const Recipe({
    required this.id,
    required this.title,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'category': category};
  }

  @override
  String toString() {
    return 'Spell{id: $id, title: $title, category: $category}';
  }
}

class RecipeDatabaseHandler {
  Future<Database> initializeDB() async {
    //TODO:DS: DEBUGGING: Delete Database every time it is initialized
    // deleteDatabase(join(await getDatabasesPath(), 'spellbook.db'));
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      join(await getDatabasesPath(), 'spellbook.db'),
      onCreate: (db, version) {
        db.execute('CREATE TABLE recipe(id int, title Text, category Text)');
        //TODO:DS: Create other tables here too!
      },
      version: 1,
    );
  }

  Future<void> tests() async {
    createRecipe(
        const Recipe(id: 6, title: 'Strawberry Cake', category: 'Cake'));
    createRecipe(const Recipe(id: 1, title: 'Lemon Cake', category: 'Cake'));
    createRecipe(
        const Recipe(id: 2, title: 'Chocolate Cake', category: 'Cake'));

    createRecipe(const Recipe(id: 3, title: 'Lemon Pie', category: 'Pie'));
    createRecipe(const Recipe(id: 4, title: 'Blueberry Pie', category: 'Pie'));
    createRecipe(const Recipe(id: 5, title: 'Egg Pie', category: 'Pie'));
  }

  Future<List<String>> getCategoryList() async {
    final db = await initializeDB();
    List<Map<String, dynamic>> query = await db.query(
      'recipe',
      distinct: true,
      columns: ['category'],
    );
    return List.generate(query.length, (i) {
      return query[i]['category'];
    });
  }

  Future<List<String>> getRecipeList(String category) async {
    final db = await initializeDB();
    List<Map<String, dynamic>> query = await db.query('recipe',
        columns: ['title'], where: 'category = ?', whereArgs: [category]);
    return List.generate(query.length, (i) {
      return query[i]['title'];
    });
  }

  Future<void> createRecipe(Recipe recipe) async {
    final db = await initializeDB();
    await db.insert(
      'recipe',
      recipe.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //TODO:DS: will we need this?
  Future<List<Recipe>> readRecipes(String category) async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> maps =
        await db.query('recipe', where: 'category = ?', whereArgs: [category]);
    return List.generate(maps.length, (i) {
      return Recipe(
          id: maps[i]['id'],
          title: maps[i]['title'],
          category: maps[i]['category']);
    });
  }

  //TODO:DS: will we need this?
  Future<Recipe> readRecipe(int id) async {
    final db = await initializeDB();
    List<Map<String, dynamic>> recipeMap = await db
        .query('recipe', columns: null, where: 'id = ?', whereArgs: [id]);
    return Recipe(
        id: recipeMap[0]['id'],
        title: recipeMap[0]['title'],
        category: recipeMap[0]['category']);
  }

  Future<void> updateRecipe(Recipe recipe) async {
    final db = await initializeDB();
    await db.update(
      'recipe',
      recipe.toMap(),
      where: 'id = ?',
      whereArgs: [recipe.id],
    );
  }

  Future<void> deleteRecipe(int id) async {
    final db = await initializeDB();
    await db.delete(
      'recipe',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
