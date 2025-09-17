import "dart:async";
import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  double seconds = 0;
  late Timer timer;
  String _secondtoText() => seconds <= 1 ? 'Second' : 'Seconds';
  int millis = 0;
  final laps = <int>[];
  bool isTicking = false;

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
          // SizedBox(height: 10.0),
          Expanded(child: controlPanel()),
          Expanded(child: _buildDisplay()),
        ],
      ),
    );
  }

  Row controlPanel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.teal),
            foregroundColor: WidgetStatePropertyAll(Colors.black),
          ),
          onPressed: () {
            isTicking ? null : _startTimer();
          },
          child: Row(children: [Text("Start"), Icon(Icons.play_arrow)]),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.red),
            foregroundColor: WidgetStatePropertyAll(Colors.black),
          ),
          onPressed: () {
            isTicking ? _stopTimer() : null;
          },
          child: Row(children: [Text("Stop"), Icon(Icons.stop)]),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.amber),
            foregroundColor: WidgetStatePropertyAll(Colors.black),
          ),
          onPressed: () => _lapCLick(),
          child: Row(children: [Text("Lap"), Icon(Icons.clear)]),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 100), _onTick);
    setState(() {
      isTicking = true;
      seconds = 0;
    });
  }

  void _stopTimer() {
    timer.cancel();
    // seconds = 0;
    setState(() {
      isTicking = false;
    });
  }


  void _lapCLick() {
    if (isTicking) {
      setState(() {
        laps.add(millis);
        millis = 0;
      });
    }
    print(laps);
  }

  void _onTick(Timer timer) {
    if (mounted) {
      setState(() {
        millis += 100;
        seconds = millis / 1000;
      });
    }
  }

  Widget _buildDisplay() {
    return ListView(
      children: [
        for (int i in laps)
          ListTile(
            leading: Icon(Icons.timer),
            title: Text('Lap ${laps.indexOf(i) + 1}: ${i / 1000} seconds'),
          ),
      ],
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
