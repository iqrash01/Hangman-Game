import 'dart:math';

import 'package:flutter/material.dart';
import 'home_page.dart';

class GamePage extfigfigends StatefulWidget {
  final int numWords;
  final int numTries;

  GamePage({required this.numWords, required this.numTries});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  TextEditingController _controller = TextEditingController();
  List<String> _guessedLetters = [];
  List<String> _wordLetters = [];
  late int _numTriesLeft;
  bool _gameOver = false;
  bool _gameWon = false;

  List<String> _words = [
    'apple',
    'banana',
    'cherry',
    'date',
    'elderberry',
    'fig',
    'grape',
    'honeydew',
    'kiwi',
    'lemon'
  ];

  void _newGame() {
    _guessedLetters = [];
    _wordLetters = [];
    _numTriesLeft = widget.numTries;
    _gameOver = false;
    _gameWon = false;
    _controller.clear();

    // Choose a random word
    String word = _words[Random().nextInt(_words.length)];
    _wordLetters = word.split('');
  }

  @override
  void initState() {
    super.initState();
    _newGame();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _guessLetter(String letter) {
    setState(() {
      if (!_guessedLetters.contains(letter)) {
        _guessedLetters.add(letter);
        if (!_wordLetters.contains(letter)) {
          _numTriesLeft--;
        }
      }

      if (_numTriesLeft == 0) {
        _gameOver = true;
      } else if (_wordLetters.every((w) => _guessedLetters.contains(w))) {
        _gameWon = true;
        _gameOver = true;
      }
    });
  }

  void _onSubmit(String value) {
    _guessLetter(value);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hangman'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Number of words: ${widget.numWords}',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Number of tries: $_numTriesLeft',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  for (String letter in _wordLetters)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        _guessedLetters.contains(letter) ? letter : '_',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                controller: _controller,
                maxLength: 1,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  hintText: 'Guess a letter',
                  counterText: '',
                ),
                onSubmitted: _onSubmit,
              ),
              SizedBox(height: 20),
              if (_gameOver)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _gameWon ? 'You won!' : 'You lost!',
                      style: TextStyle(fontSize: 30),
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: null
                    ),
                  ],
                ),
            ]
        ),
      ),
    );
  }
}
