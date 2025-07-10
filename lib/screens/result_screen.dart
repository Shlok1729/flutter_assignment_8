import 'package:flutter/material.dart';
import 'login_screen.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;
  final String playerName;

  const ResultScreen({
    super.key,
    required this.score,
    required this.total,
    required this.playerName,
  });

  String getPerformanceMessage() {
    double percent = (score / total) * 100;
    if (percent >= 90) return "Brilliant, $playerName! 💥";
    if (percent >= 70) return "Great job, $playerName! 🎯";
    if (percent >= 50) return "Nice try, $playerName! 👍";
    return "Keep practicing, $playerName! 🧠";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Quiz Completed!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                getPerformanceMessage(),
                style: const TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Text(
                "Score: $score / $total",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                child: const Text(
                  "Play Again",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
