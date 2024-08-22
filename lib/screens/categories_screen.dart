import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/model/category_model.dart';
import 'package:meal_app/screens/meals_screen.dart';
import 'package:meal_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _selectCategory(BuildContext context, CategoryModel categoryModel) {
    final filterMeal = dummyMeals
        .where((meal) => meal.categories.contains(categoryModel.id))
        .toList();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            MealsScreen(title: categoryModel.title, meals: filterMeal)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Your Category'),
      ),
      body: GridView(
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

      // Alternet Way
      // for(final e in availableCategories)
      //CategoryGridItem(categoryItem:e)
    );
  }
}
