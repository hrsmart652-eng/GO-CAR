import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  //! Here The Initialize of cache .
  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  String? getDataString({required String key}) {
    return sharedPreferences.getString(key);
  }

  //! this method to put data in local database using key

  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }

    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }

    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else {
      return await sharedPreferences.setDouble(key, value);
    }
  }

  //! this method to get data already saved in local database

  dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  //! remove data using specific key

  Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  //! this method to check if local database contains {key}
  Future<bool> containsKey({required String key}) async {
    return sharedPreferences.containsKey(key);
  }

  Future<bool> clearData({required String key}) async {
    return sharedPreferences.clear();
  }

  //! this fun to put data in local data base using key
  Future<dynamic> put({required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else {
      return await sharedPreferences.setInt(key, value);
    }
  }
}

// import 'package:shared_preferences/shared_preferences.dart';
//
// class CacheHelper {
//   static late SharedPreferences _sharedPreferences;
//
//   /// Initialize SharedPreferences (must be called before any other method).
//   static Future<void> init() async {
//     _sharedPreferences = await SharedPreferences.getInstance();
//   }
//
//   /// Checks if preferences is initialized.
//   static bool _isInitialized() {
//     assert(
//       _sharedPreferences != null,
//       'CacheHelper not initialized. Call CacheHelper.init() first.',
//     );
//     return true;
//   }
//
//   /// Saves data to local storage with dynamic type handling.
//   /// Supported types: String, bool, int, double.
//   static Future<bool> saveData({
//     required String key,
//     required dynamic value,
//   }) async {
//     _isInitialized();
//
//     if (value is bool) {
//       return await _sharedPreferences.setBool(key, value);
//     } else if (value is String) {
//       return await _sharedPreferences.setString(key, value);
//     } else if (value is int) {
//       return await _sharedPreferences.setInt(key, value);
//     } else if (value is double) {
//       return await _sharedPreferences.setDouble(key, value);
//     } else {
//       throw ArgumentError('Invalid type: ${value.runtimeType}');
//     }
//   }
//
//   /// Retrieves data from local storage (returns `null` if not found).
//   static dynamic getData({required String key}) {
//     _isInitialized();
//     return _sharedPreferences.get(key);
//   }
//
//   /// Removes data for a specific key.
//   static Future<bool> removeData({required String key}) async {
//     _isInitialized();
//     return await _sharedPreferences.remove(key);
//   }
//
//   /// Clears all data in local storage.
//   static Future<bool> clearAllData() async {
//     _isInitialized();
//     return await _sharedPreferences.clear();
//   }
//
//   /// Checks if a key exists.
//   static bool containsKey({required String key}) {
//     _isInitialized();
//     return _sharedPreferences.containsKey(key);
//   }
// }
