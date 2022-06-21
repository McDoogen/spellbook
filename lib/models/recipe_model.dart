class Recipe {
  final int id;
  final String title;
  final String category;
  final List<String> ingredients;
  final List<String> processes;

  const Recipe({
    required this.id,
    required this.title,
    required this.category,
    required this.ingredients,
    required this.processes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'ingredients': ingredients,
      'processes': processes,
    };
  }

  @override
  String toString() {
    return 'Recipe{id: $id, title: $title, category: $category, ingredients: $ingredients, processes: $processes}';
  }
}
