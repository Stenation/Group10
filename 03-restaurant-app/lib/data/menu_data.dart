import '../models/menu_category.dart';
import '../models/menu_item.dart';

const String loremIpsum =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
    'Praesent commodo cursus magna, vel scelerisque nisl consectetur et.';
const List<MenuItem> starterItems = [
  MenuItem(
    name: 'Flutter fries',
    description: "Fluttiest fries around. Fresh potatoes.",
    price: 5.0,
    imagePath: 'assets/images/menu/item.jpg',
    isVegan: true,
    isVegetarian: true,
    isGlutenFree: true,
    allergens: [],
  ),
  MenuItem(
    name: 'Backend bread',
    description: "Fluffy, fluttery bread, yummy.",
    price: 3.5,
    imagePath: 'assets/images/menu/item.jpg',
    isVegan: true,
    isVegetarian: true,
    isGlutenFree: false,
    allergens: ['Gluten'],
  ),
  MenuItem(
    name: 'Mozzarella sticks of ram',
    description: "Cheesy deliciousness",
    price: 4.0,
    imagePath: 'assets/images/menu/item.jpg',
    isVegan: false,
    isVegetarian: true,
    isGlutenFree: false,
    allergens: ['Dairy', 'Gluten'],
  ),
];

const List<MenuItem> mainCourseItems = [
  MenuItem(
    name: 'Pi pizza',
    description: "Beautiful, round, pizza",
    price: 10.0,
    imagePath: 'assets/images/menu/item.jpg',
    isVegan: false,
    isVegetarian: true,
    isGlutenFree: false,
    allergens: ['Dairy', 'Gluten'],
  ),
  MenuItem(
    name: 'Rubber duck wrap',
    description: "Wrapped up duck. Helps with debugging",
    price: 8.0,
    imagePath: 'assets/images/menu/item.jpg',
    isVegan: false,
    isVegetarian: false,
    isGlutenFree: false,
    allergens: ['Gluten', 'Soy'],
  ),
  MenuItem(
    name: 'Barbe-queue burger',
    description: "One at time, it's that popular",
    price: 9.0,
    imagePath: 'assets/images/menu/item.jpg',
    isVegan: false,
    isVegetarian: false,
    isGlutenFree: false,
    allergens: ['Gluten', 'Dairy', 'Mustard'],
  ),
];

const List<MenuItem> dessertItems = [
  MenuItem(
    name: 'Ice cream with bits and bites',
    description: "Smooth, velvety, delicious",
    price: 5.0,
    imagePath: 'assets/images/menu/item.jpg',
    isVegan: false,
    isVegetarian: true,
    isGlutenFree: true,
    allergens: ['Dairy', 'Nuts'],
  ),
  MenuItem(
    name: 'Raspberry pi',
    description: "Versatile, little piece of deliciousness",
    price: 6.0,
    imagePath: 'assets/images/menu/item.jpg',
    isVegan: true,
    isVegetarian: true,
    isGlutenFree: false,
    allergens: ['Gluten'],
  ),
];

const List<MenuItem> drinkItems = [
  MenuItem(
    name: 'Water',
    description: "If you're boring",
    price: 2.0,
    imagePath: 'assets/images/menu/item.jpg',
    isVegan: true,
    isVegetarian: true,
    isGlutenFree: true,
    allergens: [],
  ),
  MenuItem(
    name: 'Wine',
    description: "Cherry wine",
    price: 6.0,
    imagePath: 'assets/images/menu/item.jpg',
    isVegan: true,
    isVegetarian: true,
    isGlutenFree: true,
    allergens: ['Sulphites'],
  ),
  MenuItem(
    name: 'Beer',
    description: "Karhu",
    price: 5.0,
    imagePath: 'assets/images/menu/item.jpg',
    isVegan: true,
    isVegetarian: true,
    isGlutenFree: false,
    allergens: ['Gluten'],
  ),
];

const List<MenuCategory> menuCategories = [
  MenuCategory(name: 'Starters', items: starterItems),
  MenuCategory(name: 'Main course', items: mainCourseItems),
  MenuCategory(name: 'Desserts', items: dessertItems),
  MenuCategory(name: 'Drinks', items: drinkItems),
];
