import 'package:bahaya_rokok/button_widget.dart';
import 'package:bahaya_rokok/master_data.dart';
import 'package:flutter/material.dart';

class QuizWidget extends StatefulWidget {
  const QuizWidget({Key? key}) : super(key: key);

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  final quizData = masterDataQuiz;
  final List<String> _userAnswers = [
    'A',
    'A',
    'A',
    'A',
    'A',
    'A',
    'A',
    'A',
    'A',
    'A'
  ];
  final List<String> _answers = [];

  int _currentIndex = 0;
  int score = 0;
  bool _showScore = false;

  @override
  Widget build(BuildContext context) {
    final question = quizData['questions'] as List<String>;
    final choices = quizData['choices'] as List<List<String>>;

    _answers.clear();
    _answers.addAll(quizData['answers'] as List<String>);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
            child: Text(
              question[_currentIndex],
              style: const TextStyle(fontSize: 18),
            ),
          ),
          _buildChoice(choices[_currentIndex]),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ButtonWidget(
                title: _currentIndex < 9 ? 'Next' : 'Submit',
                onPressed: () {
                  if (_currentIndex < 9) {
                    setState(() {
                      _currentIndex += 1;
                    });
                  } else {
                    _calculateScore();
                    _showScore = true;
                  }
                }),
          ),
          Visibility(
              visible: _showScore,
              child: Center(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      child: Text(
                        'Skor Kamu',
                        style: TextStyle(fontSize: 32),
                      ),
                    ),
                    Text(
                      score.toString(),
                      style: const TextStyle(fontSize: 24),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildChoice(List<String> data) {
    return Column(
      children: [
        _buildChoiceItem(data[0], 'A'),
        _buildChoiceItem(data[1], 'B'),
        _buildChoiceItem(data[2], 'C')
      ],
    );
  }

  Widget _buildChoiceItem(String text, String alphabet) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
      leading: Radio(
          value: alphabet,
          groupValue: _userAnswers[_currentIndex],
          onChanged: (String? value) {
            setState(() {
              _userAnswers[_currentIndex] = value!;
            });
          }),
    );
  }

  _calculateScore() {
    for (int i = 0; i < _userAnswers.length; i++) {
      if (_answers[i] == _userAnswers[i]) {
        score += 10;
      }
    }

    setState(() {});
  }
}
