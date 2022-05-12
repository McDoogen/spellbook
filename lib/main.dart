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
        body: Center(child: Text('State: $_listState!')),
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
