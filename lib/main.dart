import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Page1(),
    );
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
