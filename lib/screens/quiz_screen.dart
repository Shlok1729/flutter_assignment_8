import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/question_model.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String playerName;

  const QuizScreen({super.key, required this.playerName});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isLoading = true;
  bool _answered = false;
  String _selectedOption = "";

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final String jsonString = await rootBundle.loadString(
      'lib/data/questions.json',
    );
    final List<dynamic> jsonData = json.decode(jsonString);
    setState(() {
      _questions = jsonData.map((q) => Question.fromJson(q)).toList();
      _isLoading = false;
    });
  }

  void _handleAnswer(String selected) {
    if (_answered) return;

    setState(() {
      _selectedOption = selected;
      _answered = true;

      if (selected == _questions[_currentQuestionIndex].answer) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOption = "";
        _answered = false;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            score: _score,
            total: _questions.length,
            playerName: widget.playerName,
          ),
        ),
      );
    }
  }

  Color _getOptionColor(String option) {
    if (!_answered) return Colors.deepPurple;
    if (option == _questions[_currentQuestionIndex].answer) return Colors.green;
    if (option == _selectedOption) return Colors.red;
    return Colors.deepPurple; // unselected options remain purple
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Brain Blitz Quiz"),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.deepPurple[50],
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Question ${_currentQuestionIndex + 1} of ${_questions.length}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(question.question, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ...question.options.map(
              (option) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: _answered ? null : () => _handleAnswer(option),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _getOptionColor(option),
                    foregroundColor: Colors.white, // force white text
                    disabledBackgroundColor: _getOptionColor(
                      option,
                    ), // override default grey
                    disabledForegroundColor:
                        Colors.white, // force white text when disabled
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(option, style: const TextStyle(fontSize: 16)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (_answered)
              ElevatedButton(
                onPressed: _nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
