import '../models/menu_category.dart';
import '../models/menu_item.dart';

const String loremIpsum =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
    'Praesent commodo cursus magna, vel scelerisque nisl consectetur et.';

const List<MenuItem> starterItems = [
  MenuItem(name: 'name1', description: loremIpsum, price: 5.0),
  MenuItem(name: 'name1', description: loremIpsum, price: 5.0),
  MenuItem(name: 'name1', description: loremIpsum, price: 5.0),
];

const List<MenuItem> mainCourseItems = [
  MenuItem(name: 'name1', description: loremIpsum, price: 5.0),
  MenuItem(name: 'name1', description: loremIpsum, price: 5.0),
  MenuItem(name: 'name1', description: loremIpsum, price: 5.0),
];

const List<MenuItem> dessertItems = [
  MenuItem(name: 'name1', description: loremIpsum, price: 5.0),
  MenuItem(name: 'name1', description: loremIpsum, price: 5.0),
];

const List<MenuItem> drinkItems = [
  MenuItem(name: 'name1', description: loremIpsum, price: 5.0),
  MenuItem(name: 'name1', description: loremIpsum, price: 5.0),
  MenuItem(name: 'name1', description: loremIpsum, price: 5.0),
];

const List<MenuCategory> menuCategories = [
  MenuCategory(name: 'Starters', items: starterItems),
  MenuCategory(name: 'Main course', items: mainCourseItems),
  MenuCategory(name: 'Desserts', items: dessertItems),
  MenuCategory(name: 'Drinks', items: drinkItems),
];
