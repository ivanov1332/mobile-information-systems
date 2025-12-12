import 'package:flutter/material.dart';
import '../services/favourite_service.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favorites = FavoriteService().favorites;

    return Scaffold(
      appBar: AppBar(title: Text("Favorite Meals")),
      body: favorites.isEmpty
          ? Center(child: Text("Немате омилени рецепти"))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final meal = favorites[index];

          return ListTile(
            leading: Image.network(meal.thumbnail),
            title: Text(meal.name),
          );
        },
      ),
    );
  }
}
