abstract class StorageService {
  int? getInt(String key);
  Future<void> setInt(String key, int value);

  String? getString(String key);
  Future<void> setString(String key, String value);

  bool? getBool(String key);
  Future<void> setBool(String key, bool value);

  double? getDouble(String key);
  Future<void> setDouble(String key, double value);

  Future<bool> remove(String key);
}
