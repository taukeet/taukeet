import 'package:shared_preferences/shared_preferences.dart';
import 'package:taukeet/contracts/storage_service.dart';

class PrefsStorageService extends StorageService {
  final SharedPreferences prefs;

  PrefsStorageService({required this.prefs});

  @override
  bool? getBool(String key) {
    return prefs.getBool(key);
  }

  @override
  double? getDouble(String key) {
    return prefs.getDouble(key);
  }

  @override
  int? getInt(String key) {
    return prefs.getInt(key);
  }

  @override
  String? getString(String key) {
    return prefs.getString(key);
  }

  @override
  Future<bool> remove(String key) {
    return prefs.remove(key);
  }

  @override
  Future<void> setBool(String key, bool value) {
    return prefs.setBool(key, value);
  }

  @override
  Future<void> setDouble(String key, double value) {
    return prefs.setDouble(key, value);
  }

  @override
  Future<void> setInt(String key, int value) {
    return prefs.setInt(key, value);
  }

  @override
  Future<void> setString(String key, String value) {
    return prefs.setString(key, value);
  }
}
