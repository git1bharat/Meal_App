import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/model/category_model.dart';
import 'package:meal_app/model/meals.dart';
import 'package:meal_app/screens/meals_screen.dart';
import 'package:meal_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _anitmationController;
  @override
  void initState() {
    super.initState();
    _anitmationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _anitmationController.forward();
  }

  @override
  void dispose() {
    _anitmationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, CategoryModel categoryModel) {
    final filterMeal = dummyMeals
        .where((meal) => meal.categories.contains(categoryModel.id))
        .toList();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MealsScreen(
              title: categoryModel.title,
              meals: filterMeal,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anitmationController,
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(1, 0.3),
          end: const Offset(0, 0),
        ).animate(CurvedAnimation(
            parent: _anitmationController, curve: Curves.easeOut)),
        child: child,
      ),
      child: GridView(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: availableCategories
              .map((e) => CategoryGridItem(
                    categoryItem: e,
                    onSelectCategory: () {
                      _selectCategory(context, e);
                    },
                  ))
              .toList()),
    );

    // Alternet Way
    // for(final e in availableCategories)
    //CategoryGridItem(categoryItem:e)
  }
}
