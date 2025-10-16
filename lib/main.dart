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
  bool isPaused = false;

  void startTimer() {
    if (isRunning) return;
    isRunning = true;

    timer = Timer.periodic(Duration(seconds: 1), (activeTimer) {
      setState(() {
        remainingSeconds--;
      });

      if (remainingSeconds == 0) {
        pauseWhenTimerZero();
      }
    });
  }

  void resetTimer() {
    setState(() {
      remainingSeconds = 20;
      isRunning = false;
      isPaused = false;
      timer?.cancel();
    });
  }

  void pauseTimer() {
    setState(() {
      isRunning = false;
      isPaused = true;
      timer?.cancel();
    });
  }

  void resumeTimer() {
    setState(() {
      isPaused = false;
    });

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
            Text(
              formatTime(remainingSeconds),
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!isRunning && !isPaused)
                  ElevatedButton(onPressed: startTimer, child: Text('Start')),
                if (isRunning) ...[
                  ElevatedButton(onPressed: pauseTimer, child: Text('Pause')),
                ],
                if (isPaused)
                  ElevatedButton(onPressed: resumeTimer, child: Text('Resume')),

                ElevatedButton(onPressed: resetTimer, child: Text('Reset')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
