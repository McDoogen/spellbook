import 'package:flutter/material.dart';

class RecipeEditorPage extends StatelessWidget {
  const RecipeEditorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Recipe Editor Page')),
        body: const Center(child: Icon(Icons.edit)));
  }
}
