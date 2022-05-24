import 'package:flutter/material.dart';

class SelectedCategory extends ChangeNotifier {
  String _selectedCategory = '';

  String getCategory() => _selectedCategory;
  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
