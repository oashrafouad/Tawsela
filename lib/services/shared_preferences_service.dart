import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Define keys
const _firstNameKey = 'firstName';
const _lastNameKey = 'lastName';
const _phoneNumberKey = 'phoneNumber';
const _profileImageURLKey = 'profileImageURL';
const _isLoggedInKey = 'isLoggedIn';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static late SharedPreferences _preferences;

  SharedPreferencesService._();

  // Using a singleton pattern
  static Future<SharedPreferencesService> getInstance() async {
    _instance ??= SharedPreferencesService._();

    _preferences = await SharedPreferences.getInstance();

    return _instance!;
  }

  // Persist and retrieve first name
  String get firstName => _getData(_firstNameKey) ?? '';
  set firstName(String value) => _saveData(_firstNameKey, value);

  // Persist and retrieve last name
  String get lastName => _getData(_lastNameKey) ?? '';
  set lastName(String value) => _saveData(_lastNameKey, value);

  // Persist and retrieve phone number
  String get phoneNumber => _getData(_phoneNumberKey) ?? '';
  set phoneNumber(String value) => _saveData(_phoneNumberKey, value);

  // Persist and retrieve profile image URL
  String get profileImageURL => _getData(_profileImageURLKey) ?? '';
  set profileImageURL(String value) => _saveData(_profileImageURLKey, value);

  // Persist and retrieve logged in status
  bool get isLoggedIn => _getData(_isLoggedInKey) ?? false;
  set isLoggedIn(bool value) => _saveData(_isLoggedInKey, value);

  dynamic _getData(String key) {
    // Retrieve data from shared preferences
    var value = _preferences.get(key);

    // Easily log the data that we retrieve from shared preferences
    debugPrint('Retrieved $key: $value');

    // Return the data that we retrieve from shared preferences
    return value;
  }

  void _saveData(String key, dynamic value) {
    // Easily log the data that we save to shared preferences
    debugPrint('Saving $key: $value');

    // Save data to shared preferences
    if (value is String) {
      _preferences.setString(key, value);
    } else if (value is int) {
      _preferences.setInt(key, value);
    } else if (value is double) {
      _preferences.setDouble(key, value);
    } else if (value is bool) {
      _preferences.setBool(key, value);
    } else if (value is List<String>) {
      _preferences.setStringList(key, value);
    }
  }
}
