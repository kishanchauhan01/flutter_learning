import "dart:async";
import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  int seconds = 0;
  late Timer timer;
  String _secondtoText() => seconds <= 1 ? 'Second' : 'Seconds';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stopwatch Experiment")),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              '$seconds ${_secondtoText()}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.teal),
                  foregroundColor: WidgetStatePropertyAll(Colors.black),
                ),
                onPressed: null,
                child: Row(children: [Text("Start"), Icon(Icons.play_arrow)]),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.red),
                  foregroundColor: WidgetStatePropertyAll(Colors.black),
                ),
                onPressed: null,
                child: Row(children: [Text("Stop"), Icon(Icons.stop)]),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blue),
                  foregroundColor: WidgetStatePropertyAll(Colors.black),
                ),
                onPressed: null,
                child: Row(children: [Text("Pause"), Icon(Icons.pause)]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), _onTick);
  }

  void _onTick(Timer timer) {
    if (mounted) {
      setState(() {
        seconds++;
      });
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
