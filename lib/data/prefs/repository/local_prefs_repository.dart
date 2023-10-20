import 'package:riverpod_test/domain/prefs/repository/prefs_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalPrefsRepository implements PrefsRepository {
  final SharedPreferences _sharedPreferences;

  LocalPrefsRepository(this._sharedPreferences);

  @override
  int getInt(String key) {
    final result = _sharedPreferences.getInt(key) ?? 0;
    return result;
  }

  @override
  Future<void> saveInt(String key, int value) async {
    await _sharedPreferences.setInt(key, value);
  }
}