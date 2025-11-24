import 'package:flutter/material.dart';
import '../services/api_service.dart';

class MealDetailsScreen extends StatefulWidget {
  final String mealId;

  const MealDetailsScreen({super.key, required this.mealId});

  @override
  _MealDetailsScreenState createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  Map<String, dynamic>? meal;

  @override
  void initState() {
    super.initState();
    loadMeal();
  }

  void loadMeal() async {
    final data = await ApiService().getMealDetails(widget.mealId);
    setState(() {
      meal = data['meals'][0];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (meal == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Meal Details")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(meal!['strMeal'])),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(meal!['strMealThumb']),
            const SizedBox(height: 16),
            Text(
              meal!['strMeal'],
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Text("Category: ${meal!['strCategory']}"),
            Text("Area: ${meal!['strArea']}"),
            const SizedBox(height: 16),
            const Text("Instructions:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(meal!['strInstructions']),
            const SizedBox(height: 16),
            const Text("Ingredients:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ..._buildIngredients(meal!),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildIngredients(Map<String, dynamic> meal) {
    List<Widget> ingList = [];
    for (int i = 1; i <= 20; i++) {
      final ing = meal["strIngredient$i"];
      final measure = meal["strMeasure$i"];
      if (ing != null && ing.toString().isNotEmpty) {
        ingList.add(Text("• $ing - $measure"));
      }
    }
    return ingList;
  }
}
