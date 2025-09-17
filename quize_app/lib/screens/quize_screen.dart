import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app/data/quize_question.dart';
import 'package:quize_app/screens/score_screen.dart';

class QuizeScreen extends StatefulWidget {
  const QuizeScreen({super.key});

  @override
  State<QuizeScreen> createState() => _QuizeScreenState();
}

class _QuizeScreenState extends State<QuizeScreen> {
  late Timer _timer;
  int _remainingSeconds = 30 * 60; // 30 minutes in seconds
  int _currentQuestionIndex = 0;
  int? _selectedOption;
  late List<int> seleOptions = List.filled(QuizData.questions.length, -1); 

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer.cancel();
        Get.off(ScoreScreen());
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < QuizData.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOption = null;
      });
    } else {
      // Get.off(() => const NextPage());
    }
  }

  void _prevQuestion() {
    if (_currentQuestionIndex < QuizData.questions.length - 1) {
      setState(() {
        _currentQuestionIndex--;
        _selectedOption = null;
      });
    } else {
      // Get.off(() => const NextPage());
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = QuizData.questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text("Time Left: ${_formatTime(_remainingSeconds)}"),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text("${_currentQuestionIndex + 1}/${QuizData.questions.length}"),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                question.question,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Options with Radio Buttons
            ...List.generate(
              question.options.length,
              (index) => RadioListTile<int>(
                title: Text(question.options[index]),
                value: index,
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _currentQuestionIndex == 0
                      ? null
                      : () {
                          _prevQuestion();
                        },
                  child: Text("Prev"),
                ),
                ElevatedButton(
                  onPressed:
                      _currentQuestionIndex == QuizData.questions.length - 1
                      ? null
                      : () {
                          _nextQuestion();
                        },
                  child: _currentQuestionIndex == QuizData.questions.length - 1
                      ? Text("Submit")
                      : Text("Next"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//0 0 2 6 12 20 30 42 56... i^2-i
// 0 1 5 15 37... i^2 + prev number