import 'package:bache_finder_app/features/shared/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageServiceImpl extends StorageService {
  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  @override
  Future<bool> deleteValueByKey(String key) {
    return _prefs.then((preferences) => preferences.remove(key));
  }

  @override
  Future<T?> getValueByKey<T>(String key) async {
    final preferences = await _prefs;

    if (T == String) {
      return preferences.getString(key) as T?;
    } else if (T == int) {
      return preferences.getInt(key) as T?;
    } else if (T == double) {
      return preferences.getDouble(key) as T?;
    } else if (T == bool) {
      return preferences.getBool(key) as T?;
    } else if (T == List<String>) {
      return preferences.getStringList(key) as T?;
    } else {
      throw UnimplementedError('Type $T is not supported');
    }
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) {
    return _prefs.then((preferences) {
      if (T == String) {
        preferences.setString(key, value as String);
      } else if (T == int) {
        preferences.setInt(key, value as int);
      } else if (T == double) {
        preferences.setDouble(key, value as double);
      } else if (T == bool) {
        preferences.setBool(key, value as bool);
      } else if (T == List<String>) {
        preferences.setStringList(key, value as List<String>);
      } else {
        throw UnimplementedError('Type $T is not supported');
      }
    });
  }
}
