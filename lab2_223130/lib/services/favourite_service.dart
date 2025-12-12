import '../models/meal_model.dart';

class FavoriteService {
  static final FavoriteService _instance = FavoriteService._internal();
  factory FavoriteService() => _instance;
  FavoriteService._internal();

  final List<Meal> _favorites = [];

  List<Meal> get favorites => _favorites;

  void toggleFavorite(Meal meal) {
    meal.isFavorite = !meal.isFavorite;

    if (meal.isFavorite) {
      _favorites.add(meal);
    } else {
      _favorites.removeWhere((m) => m.id == meal.id);
    }
  }

  bool isFavorite(String id) {
    return _favorites.any((m) => m.id == id);
  }
}
