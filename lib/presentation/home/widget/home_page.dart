import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/presentation/home/notifier/home_notifier.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  late ConfettiController _confettiController;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeNotifierProvider);
    ref.listen(
      homeNotifierProvider.select((state) => state.counter),
      (previousCount, newCount) {
        if (newCount == 69) {
          _confettiController.play();
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ],
            ),
            Text(
              '${homeState.counter}',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 160,
                    fontWeight: FontWeight.w300,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onLongPress: () {
                timer = Timer.periodic(
                  const Duration(milliseconds: 100),
                  (_) => _decrementCounter(),
                );
              },
              onLongPressEnd: (_) {
                timer?.cancel();
              },
              child: FloatingActionButton(
                backgroundColor: Colors.blue,
                onPressed: _decrementCounter,
                child: const Icon(Icons.exposure_minus_1),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onLongPress: () {
                timer = Timer.periodic(
                  const Duration(milliseconds: 100),
                  (_) => _incrementCounter(),
                );
              },
              onLongPressEnd: (_) {
                timer?.cancel();
              },
              child: FloatingActionButton(
                backgroundColor: Colors.green,
                onPressed: _incrementCounter,
                child: const Icon(Icons.plus_one),
              ),
            ),
            const SizedBox(width: 8),
            FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: _resetCounter,
              child: const Icon(Icons.refresh),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _incrementCounter() {
    ref.read(homeNotifierProvider.notifier).increment();
  }

  void _decrementCounter() {
    ref.read(homeNotifierProvider.notifier).decrement();
  }

  void _resetCounter() {
    ref.read(homeNotifierProvider.notifier).reset();
  }
}
