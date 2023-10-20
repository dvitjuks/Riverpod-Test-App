import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/data/counter/repository/local_counter_repository.dart';
import 'package:riverpod_test/data/prefs/repository/local_prefs_repository.dart';
import 'package:riverpod_test/domain/counter/repository/counter_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// From https://riverpod.dev/docs/concepts/providers
/// NOTE Do not feel threatened by the fact that a provider is declared as a global.
/// While providers are globals, the variable is fully immutable.
/// This makes creating a provider no different from declaring a function or a class.
/// 🥴🥴

final sharedPreferencesProvider = FutureProvider<SharedPreferences>(
  (ref) async {
    return await SharedPreferences.getInstance();
  },
);

final prefsRepositoryProvider = Provider<LocalPrefsRepository>(
  (ref) {
    final sharedPrefs = ref.watch(sharedPreferencesProvider);
    return LocalPrefsRepository(sharedPrefs.valueOrNull!);
  },
);

final counterRepositoryProvider = Provider<CounterRepository>(
  (ref) {
    final prefsRepository = ref.watch(prefsRepositoryProvider);
    return LocalCounterRepository(prefsRepository);
  },
);
