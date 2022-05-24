import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class Recipe {
  final int id;
  final String title;

  const Recipe({
    required this.id,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title};
  }

  @override
  String toString() {
    return 'Spell{id: $id, title: $title}';
  }
}

class RecipeDatabaseHandler {
  Future<Database> initializeDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      join(await getDatabasesPath(), 'spellbook.db'),
      onCreate: (db, version) {
        db.execute('CREATE TABLE recipe(id int, title Text)');
        //TODO:DS: Create other tables here too!
      },
      version: 1,
    );
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
  Future<List<Recipe>> readRecipes(int id) async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('recipe');
    return List.generate(maps.length, (i) {
      return Recipe(id: maps[i]['id'], title: maps[i]['title']);
    });
  }

  //TODO:DS: will we need this?
  Future<Recipe> readRecipe(int id) async {
    final db = await initializeDB();
    List<Map<String, dynamic>> recipeMap = await db
        .query('recipe', columns: null, where: 'id = ?', whereArgs: [id]);
    return Recipe(id: recipeMap[0]['id'], title: recipeMap[0]['title']);
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
