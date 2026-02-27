import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp()); // Renamed from RPSGame to MyApp
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rock Paper Scissors',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int userScore = 0;
  int computerScore = 0;
  String userChoice = "";
  String computerChoice = "";
  String resultMessage = "Make your move!";

  final List<String> choices = ["Rock", "Paper", "Scissors"];

  void playRound(String playerMove) {
    String computerMove = choices[Random().nextInt(3)];
    String message = "";

    if (playerMove == computerMove) {
      message = "It's a Draw!";
    } else if ((playerMove == "Rock" && computerMove == "Scissors") ||
        (playerMove == "Paper" && computerMove == "Rock") ||
        (playerMove == "Scissors" && computerMove == "Paper")) {
      message = "You Win!";
      userScore++;
    } else {
      message = "Computer Wins!";
      computerScore++;
    }

    setState(() {
      userChoice = playerMove;
      computerChoice = computerMove;
      resultMessage = message;
    });
  }

  void resetGame() {
    setState(() {
      userScore = 0;
      computerScore = 0;
      userChoice = "";
      computerChoice = "";
      resultMessage = "Game Reset. Make your move!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rock Paper Scissors", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Text("Score", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                Text("You: $userScore", style: const TextStyle(fontSize: 18)),
                Text("Computer: $computerScore", style: const TextStyle(fontSize: 18)),
              ],
            ),
            Column(
              children: [
                Text("Your Choice: $userChoice", style: const TextStyle(fontSize: 16)),
                Text("Computer Choice: $computerChoice", style: const TextStyle(fontSize: 16)),
              ],
            ),
            Text(
              resultMessage,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: choices.map((choice) {
                return ElevatedButton(
                  onPressed: () => playRound(choice),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  child: Text(choice),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: resetGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              child: const Text("Reset Game"),
            ),
          ],
        ),
      ),
    );
  }
}