/*
    ~~~ Project Description ~~~
    A collection of recipes that can be viewed, added, removed, and edited by the user

    ~~~ Project Platforms ~~~
    - Android
    - iOS

    ~~~ Order of Design ~~~
    - Project Purpose
    - Models
    - Pages
    - Logic
    - Services

    ~~~ Project Architecture ~~~
    - Reference -> Minimalist, https://suragch.medium.com/flutter-state-management-for-minimalists-4c71a2f2f0c1
    - Folder-by-feature
    - Provider for state management
    - Flutter Navigation 1.0, push/pop for simple routing
    - Layers: Page, State Management, Services

    ~~~ Project Pages ~~~
    - Recipe Detail Page
    - Recipe Creator Page
    - Recipe Editor Page
    - Recipe Navigator Page

    ~~~ Project Models ~~~
    - Recipe: Title, Category, Ingredient List, Process List

    ~~~ Reading ~~~
    - Minimalist: https://suragch.medium.com/flutter-state-management-for-minimalists-4c71a2f2f0c1
    - BLoC: https://www.raywenderlich.com/4074597-getting-started-with-the-bloc-pattern
*/

import 'package:flutter/material.dart';
import 'package:spellbook/pages/recipe_navigator.dart';

void main() => runApp(const HelloWidget());

class HelloWidget extends StatelessWidget {
  const HelloWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Hello!',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const RecipeNavigatorPage());
  }
}
