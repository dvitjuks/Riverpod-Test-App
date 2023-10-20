import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/domain/counter/repository/counter_repository.dart';
import 'package:riverpod_test/domain/providers/providers.dart';

final homeNotifierProvider = StateNotifierProvider<HomeNotifier, HomeState>(
  (ref) => HomeNotifier(
    counterRepository: ref.watch(counterRepositoryProvider),
  )..init(),
);

class HomeNotifier extends StateNotifier<HomeState> {
  final CounterRepository counterRepository;

  HomeNotifier({
    required this.counterRepository,
  }) : super(const HomeState(counter: 0));

  void init() {
    final counter = counterRepository.getCounter();
    state = HomeState(counter: counter);
  }

  void increment() {
    final counter = counterRepository.getCounter();
    counterRepository.saveCounter(counter + 1);
    state = HomeState(counter: counter + 1);
  }

  void decrement() {
    final counter = counterRepository.getCounter();
    counterRepository.saveCounter(counter - 1);
    state = HomeState(counter: counter - 1);
  }

  void reset() {
    counterRepository.saveCounter(0);
    state = const HomeState(counter: 0);
  }
}

class HomeState extends Equatable {
  final int counter;

  const HomeState({required this.counter});

  @override
  List<Object?> get props => [counter];
}
