import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class Spell {
  final String name;

  const Spell({
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {'name': name};
  }

  @override
  String toString() {
    return 'Spell{name: $name}';
  }
}

class SpellDatabaseHandler {
  Future<Database> initializeDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      join(await getDatabasesPath(), 'test.db'),
      onCreate: (db, version) {
        createSpell(db); //TODO:DS: return ?
      },
      version: 1,
    );
  }

  Future<void> createSpell(Database db) async {
    db.execute('CREATE TABLE spell(name Text)');
  }

  Future<List<Spell>> readSpells() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('spell');
    return List.generate(maps.length, (i) {
      return Spell(
        name: maps[i]['name'],
      );
    });
  }

  Future<Spell> readFirstSpell() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('spell');
    return maps.first['Cake'];
  }

  Future<void> updateSpell(Spell spell) async {
    final db = await initializeDB();
    await db.update(
      'spell',
      spell.toMap(),
      where: 'name = ?',
      whereArgs: [spell.name],
    );
  }

  Future<void> deleteSpell(String name) async {
    final db = await initializeDB();
    await db.delete(
      'spell',
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  Future<void> insertSpell(Spell spell) async {
    final db = await initializeDB();
    await db.insert(
      'spell',
      spell.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> test() async {
    var spell1 = const Spell(name: 'Fireball');
    await insertSpell(spell1);
    var spell2 = const Spell(name: 'Cake');
    await insertSpell(spell2);
    var spell3 = const Spell(name: 'Coxinha');
    await insertSpell(spell3);
  }
}

class TestWidget extends StatefulWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  late SpellDatabaseHandler handler;

  @override
  void initState() {
    super.initState();
    handler = SpellDatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      await handler.test();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Spell>>(
        future: handler.readSpells(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int randInt = Random().nextInt(snapshot.data!.length);
            String dataName = snapshot.data![randInt].name;
            return Text('Name: $dataName');
          } else if (snapshot.hasError) {
            return const Icon(Icons.error);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
