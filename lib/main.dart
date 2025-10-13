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
  int _counter = 0;

  void startTimer() {
    int remainingSeconds = 20;

    Timer.periodic(Duration(seconds: 1), (timer) {
      int minutes = remainingSeconds ~/ 60;
      int seconds = remainingSeconds % 60;
      var display =
          '${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
      remainingSeconds--;
      print('Remaining: $display');

      if (remainingSeconds == 0) {
        print('Time is up');
        timer.cancel();
      }
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
          ],
        ),
      ),
    );
  }
}
