import 'package:shared_preferences/shared_preferences.dart';

class FavoriteList {
  List<String> _favorites = [];
  static const favorites_key="favorites_key";

  Future<void> initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favorites = prefs.getStringList(favorites_key) ?? [];
  }

  List<String> get favorites => _favorites;


  Future<void> addFavorite(String newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingFavorites = prefs.getStringList(favorites_key);
    print(" до изменения");
    print(existingFavorites);

    if (existingFavorites != null && existingFavorites.contains(newValue)) {
      return; // Do not add if the value already exists
    }

    _favorites.add(newValue);
    prefs.setStringList(favorites_key, _favorites);
  }
}



/*
FavoriteList favoriteList = FavoriteList();
await favoriteList.initialize();
print(favoriteList.favorites);

 */
