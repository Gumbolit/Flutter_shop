import 'package:shared_preferences/shared_preferences.dart';

class FavoriteList {
  List<String> _favorites = [];
  static const favorites_key = 'favorites_key';

  Future<void> initialize() async {
    print("вызов метода initialize, состояние List_favorites: ");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favorites = prefs.getStringList(favorites_key) ?? [];
    print(_favorites);
  }

  List<String> get favorites => _favorites;

  Future<void> addFavorite(String newValue) async {
    print("вызов метода addFavorite, начальное состояние List_favorites: ");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingFavorites = prefs.getStringList(favorites_key);
    print(existingFavorites);

    if (existingFavorites != null && existingFavorites.contains(newValue)) {
      print("значение "+ newValue +" не добавлено такое значение уже есть в List_favorites");
      return; // Do not add if the value already exists
    }

    _favorites.add(newValue);
    prefs.setStringList(favorites_key, _favorites);
    print("метода addFavorite выполнен, новое состояние List_favorites: ");
    List<String>? existingFavorites2 = prefs.getStringList(favorites_key);
    print(existingFavorites2);
  }

  Future<void> deleteFavorite(String delValue) async {
    print("вызов метода deleteFavorite, начальное состояние List_favorites: ");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingFavorites = prefs.getStringList(favorites_key);
    print(existingFavorites);

    if (existingFavorites != null && existingFavorites.contains(delValue)) {
      existingFavorites.remove(delValue);
      await prefs.setStringList(favorites_key, existingFavorites);
      _favorites = existingFavorites;
    }
    print("метода addFavorite выполнен, новое состояние List_favorites: ");
    List<String>? existingFavorites2 = prefs.getStringList(favorites_key);
    print(existingFavorites2);
  }

  Future<void> deleteAllFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(favorites_key);
    _favorites.clear();
  }
}