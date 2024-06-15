abstract class StorageService {
  Future<void> setKeyValue<T>(String key, T value);
  Future<T?> getValueByKey<T>(String key);
  Future<bool> deleteValueByKey(String key);
}