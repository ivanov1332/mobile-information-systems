import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/category.dart';
import 'meals_by_category.dart';
import 'meal_details.dart'; // обавезно го имаш екранот за детали

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();

  List<Category> allCategories = [];
  List<Category> filteredCategories = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  void loadCategories() async {
    try {
      final data = await apiService.getCategories();
      setState(() {
        allCategories = data;
        filteredCategories = data;
        isLoading = false;
      });
    } catch (e) {
      print("Error loading categories: $e");
    }
  }

  void filterCategories(String query) {
    final results = allCategories.where((cat) {
      return cat.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredCategories = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal Categories"),
        actions: [
          IconButton(
            icon: const Icon(Icons.casino),
            tooltip: "Random Meal",
            onPressed: () async {
              try {
                final randomMeal = await apiService.getRandomMeal();
                if (randomMeal != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MealDetailsScreen(mealId: randomMeal.id),
                    ),
                  );
                }
              } catch (e) {
                print("Error fetching random meal: $e");
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search categories...",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: filterCategories,
            ),
          ),

          // CONTENT
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: filteredCategories.length,
                    itemBuilder: (context, index) {
                      final cat = filteredCategories[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: Image.network(cat.thumbnailUrl, width: 50),
                          title: Text(cat.name),
                          subtitle: Text(
                            cat.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    MealsByCategoryScreen(category: cat.name),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
