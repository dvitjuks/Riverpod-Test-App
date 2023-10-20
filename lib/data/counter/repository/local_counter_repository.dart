import 'package:riverpod_test/domain/counter/repository/counter_repository.dart';
import 'package:riverpod_test/domain/prefs/repository/prefs_repository.dart';

const _kCounter = 'key.counter';

class LocalCounterRepository implements CounterRepository {
  final PrefsRepository _prefsRepository;

  LocalCounterRepository(this._prefsRepository);

  @override
  int getCounter() {
    final counter = _prefsRepository.getInt(_kCounter);
    return counter;
  }

  @override
  Future<void> saveCounter(int counter) async {
    await _prefsRepository.saveInt(_kCounter, counter);
  }
}
