import 'package:flutter/material.dart';

class RecipeCreatorPage extends StatelessWidget {
  const RecipeCreatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe Creator Page')),
      body: const Center(child: Text('Hello!')),
    );
  }
}
