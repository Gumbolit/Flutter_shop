import 'package:shared_preferences/shared_preferences.dart';

class UserInf {

  List<String> _registration = [];
  static const registration_key = 'registration_key';

  List<String> _favorites = [];
  static const favorites_key = 'favorites_key';

  Future<void> initialize() async {

    print("вызов метода initialize, состояние List_favorites: ");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favorites = prefs.getStringList(favorites_key) ?? [];
    print(_favorites);



    print("вызов метода initialize, состояние List_registration: ");
    SharedPreferences reg_prefs = await SharedPreferences.getInstance();
    _registration = reg_prefs.getStringList(registration_key) ?? [];
    print(_registration);
  }

  List<String> get favorites => _favorites;
  List<String> get registration => _registration;

  Future<void> leaveRegistration() async {
    print("вызов метода leaveRegistration, начальное состояние Registration: ");
    SharedPreferences reg_prefs = await SharedPreferences.getInstance();
    List<String>? existingRegistration = reg_prefs.getStringList(registration_key);
    print(existingRegistration);
    await reg_prefs.remove(registration_key);
    _registration.clear();
    print("метода leaveRegistration выполнен, новое состояние Registration: ");
    List<String>? existingRegistration2 = reg_prefs.getStringList(registration_key);
    print(existingRegistration2);
  }

  Future<void> addRegistration(String textLogin, String textPassword) async {
    print("вызов метода addRegistration, начальное состояние Registration: ");
    SharedPreferences reg_prefs = await SharedPreferences.getInstance();
    List<String>? existingRegistration = reg_prefs.getStringList(registration_key);
    print(existingRegistration);

    if (existingRegistration != null) {
      print("кто-то уже зарегестрирован");
      return; // Do not add if the value already exists
    }

    _registration.add(textLogin);
    _registration.add(textPassword);
    reg_prefs.setStringList(registration_key, _registration);
    print("метода addRegistration выполнен, новое состояние Registration: ");
    List<String>? existingRegistration2 = reg_prefs.getStringList(registration_key);
    print(existingRegistration2);
  }

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