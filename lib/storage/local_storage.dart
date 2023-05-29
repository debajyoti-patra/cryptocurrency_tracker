import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<bool> setTheme(String theme) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool result = await sharedPreferences.setString('theme', theme);
    return result;
  }

  static Future<String?> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? currTheme = sharedPreferences.getString('theme');
    return currTheme;
  }

  static Future<bool> saveFavourites(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> favourites =
        sharedPreferences.getStringList('favourites') ?? [];
    favourites.add(id);
    return await sharedPreferences.setStringList('favourites', favourites);
  }

  static Future<bool> unSaveFavourites(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> favourites =
        sharedPreferences.getStringList('favourites') ?? [];
    favourites.remove(id);
    return await sharedPreferences.setStringList('favourites', favourites);
  }

  static Future<List<String>> getFavourites() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList('favourites') ?? [];
  }
}
