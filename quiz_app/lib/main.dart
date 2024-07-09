import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  final List<Map<String, Object>> _questions = [
    {
      'question':
          '1]Who developed the Flutter Framework and continues to maintain it today?',
      'options': ['Facebook', 'Microsoft', 'Google', 'Oracle'],
      'answer': 'Google'
    },
    {
      'question': '2]How many types of widgets are there in Flutter?',
      'options': ['2', '4', '6', '8'],
      'answer': '2'
    },
    {
      'question':
          '3]Which programming language is used to build Flutter applications?',
      'options': ['Kotlin', 'Dart', 'Java', 'Go'],
      'answer': 'Dart'
    },
    {
      'question':
          '4]Which of the following widget is used for repeating content in Flutter?',
      'options': ['Listview', 'Arrayview', 'Expandedview', 'None of the above'],
      'answer': 'Listview'
    },
    {
      'question': '5]Everything is a widget in Flutter. True or False?',
      'options': ['True', 'False'],
      'answer': 'True'
    },
  ];

  void _answerQuestion(String selectedOption) {
    if (selectedOption == _questions[_currentQuestionIndex]['answer']) {
      setState(() {
        _score++;
      });
    }

    setState(() {
      _currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CurvedAppBar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _currentQuestionIndex < _questions.length
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _questions[_currentQuestionIndex]['question']
                              as String,
                          style: TextStyle(fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        ...(_questions[_currentQuestionIndex]['options']
                                as List<String>)
                            .map((option) {
                          return Column(
                            children: [
                              ElevatedButton(
                                onPressed: () => _answerQuestion(option),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor:
                                      Colors.deepOrangeAccent, // Text color
                                ),
                                child: Text(option),
                              ),
                              SizedBox(height: 10), // Add space between buttons
                            ],
                          );
                        }).toList(),
                      ],
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Quiz Completed!',
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            'Your score: $_score',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _currentQuestionIndex = 0;
                                _score = 0;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green, // Text color
                            ),
                            child: Text('Restart Quiz'),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurvedAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyCustomClipper(),
      child: Container(
        color: Colors.deepOrangeAccent,
        height: 200,
        child: Center(
          child: Text(
            'QUIZ APP',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    var firstControlPoint = Offset(size.width / 2, size.height);
    var firstEndPoint = Offset(size.width, size.height - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
