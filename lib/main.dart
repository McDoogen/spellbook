/*
    ~~~ Project Description ~~~
    A collection of recipes that can be viewed, added, removed, and edited by the user

    ~~~ Proejct Platforms ~~~
    - Android
    - iOS

    ~~~ Project Architecture ~~~
    - Folder-by-layer for simplicity
    - Provider for state management
    - Flutter Navigation 1.0, push/pop for simple routing
    - Layers: View, Model View, Services

    ~~~ Project Views ~~~
    - Recipe Detail View
    - Recipe Creator View
    - Recipe Editor View

    ~~~ Project Models ~~~
    - Recipe: Title, Category, Ingredient List, Process List

    ~~~ Reading ~~~
    - Minimalist: https://suragch.medium.com/flutter-state-management-for-minimalists-4c71a2f2f0c1
    - BLoC: https://www.raywenderlich.com/4074597-getting-started-with-the-bloc-pattern
*/

import 'package:flutter/material.dart';

void main() => runApp(const HelloWidget());

class HelloWidget extends StatelessWidget {
  const HelloWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Hello!',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Scaffold(
            appBar: AppBar(), body: const Center(child: Text('Hello! :)'))));
  }
}
