abstract class PrefsRepository {
  int getInt(String key);
  Future<void> saveInt(String key, int value);
}