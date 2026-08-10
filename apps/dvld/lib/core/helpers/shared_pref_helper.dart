import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  SharedPrefHelper(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  /// Saves a [value] with a [key] in the SharedPreferences.
  Future<bool> setData(String key, dynamic value) async {
    debugPrint("SharedPrefHelper : setData with key : $key and value : $value");

    if (value is String) return await _sharedPreferences.setString(key, value);
    if (value is int) return await _sharedPreferences.setInt(key, value);
    if (value is bool) return await _sharedPreferences.setBool(key, value);
    if (value is double) return await _sharedPreferences.setDouble(key, value);
    if (value is List<String>) {
      return await _sharedPreferences.setStringList(key, value);
    }
    if (value is Map<String, dynamic>) {
      final jsonString = jsonEncode(value);
      return await _sharedPreferences.setString(key, jsonString);
    }

    return false;
  }

  /// Gets a bool value from SharedPreferences with given [key].
  bool getBool(String key, {bool defaultValue = false}) {
    debugPrint('SharedPrefHelper : getBool with key : $key');
    return _sharedPreferences.getBool(key) ?? defaultValue;
  }

/// Gets an object from SharedPreferences with given [key].
  Map<String, dynamic>? getObject(String key) {
    debugPrint('SharedPrefHelper : getObject with key : $key');
    final jsonString = _sharedPreferences.getString(key);
    
    if (jsonString != null && jsonString.isNotEmpty) {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    }
    return null;
  }

  /// Gets a double value from SharedPreferences with given [key].
  double getDouble(String key, {double defaultValue = 0.0}) {
    debugPrint('SharedPrefHelper : getDouble with key : $key');
    return _sharedPreferences.getDouble(key) ?? defaultValue;
  }

  /// Gets an int value from SharedPreferences with given [key].
  int getInt(String key, {int defaultValue = 0}) {
    debugPrint('SharedPrefHelper : getInt with key : $key');
    return _sharedPreferences.getInt(key) ?? defaultValue;
  }

  /// Gets an String value from SharedPreferences with given [key].
  String getString(String key, {String defaultValue = ''}) {
    debugPrint('SharedPrefHelper : getString with key : $key');
    return _sharedPreferences.getString(key) ?? defaultValue;
  }

  /// Removes a value from SharedPreferences with given [key].
  Future<bool> removeData(String key) async {
    debugPrint('SharedPrefHelper : data with key : $key has been removed');
    return await _sharedPreferences.remove(key);
  }

  /// Removes all keys and values in the SharedPreferences
  Future<bool> clearAllData() async {
    debugPrint('SharedPrefHelper : all data has been cleared');
    return await _sharedPreferences.clear();
  }
}
