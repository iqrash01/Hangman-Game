import 'package:flutter/material.dart';
import 'GamePage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _numWords = 1;
  int _numTries = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Hangman'),
    ),
    body: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text(
    'Number of words: $_numWords',
    style: TextStyle(fontSize: 20),
    ),
    Slider(
    value: _numWords.toDouble(),
    min: 1,
    max: 10,
    divisions: 9,
    onChanged: (double value) {
    setState(() {
    _numWords = value.toInt();
    });
    },
    ),
      Text(
        'Number of tries: $_numTries',
        style: TextStyle(fontSize: 20),
      ),
      Slider(
        value: _numTries.toDouble(),
        min: 1,
        max: 10,
        onChanged: (double value) {
          setState(() {
            _numTries = value.toInt();
          });
        },
      ),
      SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GamePage(
                numWords: _numWords,
                numTries: _numTries,
              ),
            ),
          );
        },
        child: Text('Start Game'),
      ),
    ],
    ),
    ),
    );
  }
}