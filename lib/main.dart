import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int remainingSeconds = 20;
  Timer? timer;
  bool isRunning = false;

  void startTimer() {
    if (isRunning) return;
    isRunning = true;

    timer = Timer.periodic(Duration(seconds: 1), (activeTimer) {
      var display = formatTime(remainingSeconds);

      setState(() {
        remainingSeconds--;
      });

      print('Remaining: $display');

      if (remainingSeconds == 0) {
        pauseWhenTimerZero();
      }
    });
  }

  void resetTimer() {
    setState(() {
      remainingSeconds = 20;
      isRunning = false;
    });
  }

  void pauseTimer() {
    setState(() {
      isRunning = false;
      timer?.cancel();
    });
  }

  void resumeTimer() {
    if (!isRunning) startTimer();
  }

  formatTime(int activeSeconds) {
    int minutes = activeSeconds ~/ 60;
    int seconds = activeSeconds % 60;
    var display =
        '${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';

    return display;
  }

  pauseWhenTimerZero() {
    print('Time is up');
    timer?.cancel();
    setState(() {
      isRunning = false;
      timer = null;
      remainingSeconds = 20;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: startTimer, child: Text('Start')),
            ElevatedButton(onPressed: resetTimer, child: Text('Reset')),
            ElevatedButton(onPressed: pauseTimer, child: Text('Pause')),
            ElevatedButton(onPressed: resumeTimer, child: Text('Resume')),
          ],
        ),
      ),
    );
  }
}
