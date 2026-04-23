class MenuItem {
  final String name;
  final String description;
  final double price;
  final bool isVegan;
  final bool isVegetarian;
  final bool isGlutenFree;
  final List<String> allergens;
  final String imagePath;

  const MenuItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    this.isVegan = false,
    this.isVegetarian = false,
    this.isGlutenFree = false,
    this.allergens = const [],
  });
}
