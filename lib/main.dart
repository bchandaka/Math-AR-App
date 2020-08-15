import 'package:flutter/material.dart';
import 'package:flutter_unity/flutter_unity.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'echoAR Unity demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'echoAR Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('MathAR')),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UnityViewPage()));
              },
              child: Text('Number Line'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UnityViewPage()));
              },
              child: Text('Protractor'),
            ),
          ],
        ),
      ),
    );
  }
}

class questionCard extends StatefulWidget {
  @override
  _questionCardState createState() => _questionCardState();
}

class _questionCardState extends State<questionCard> {
  int _answer = 0;
  String _question = "No Question";
  TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    genQuestion();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void genQuestion() {
    var rng = new Random();
    int num1 = rng.nextInt(10);
    int num2 = rng.nextInt(10);
    String operator = (num1 - num2 >= -9) ? "-" : "+";
    _answer = (num1 - num2 >= -9) ? num1 - num2 : num1 + num2;
    _question = "$num1 $operator $num2 =";
  }

  void updateText() {
    setState(() => _question = _question);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Text("Question:"),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text(
              '$_question',
              style: TextStyle(fontSize: 30.0, color: Colors.black),
            ),
            Container(
              width: 100.0,
              child: TextField(
                style:
                    TextStyle(fontSize: 15.0, height: 2.0, color: Colors.black),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Answer', isDense: true, // Added this
                  contentPadding: EdgeInsets.all(8), // Added this
                ),
                controller: _controller,
                onSubmitted: (String value) async {
                  await showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      print("$_answer");
                      print("$value");
                      String checkStr = "Oh no, That's Wrong.";
                      if ("$_answer" == "$value") {
                        genQuestion();
                        checkStr = "That's Right!";
                      }
                      _controller.clear();
                      return AlertDialog(
                        title: const Text('Answer Submitted'),
                        content: Text(checkStr),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              updateText();
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

class UnityViewPage extends StatefulWidget {
  @override
  _UnityViewPageState createState() => _UnityViewPageState();
}

class _UnityViewPageState extends State<UnityViewPage> {
  UnityViewController unityViewController;

  String _projectKey = 'divine-sound-5224';
  String _entryID = '5c5f5d05-252c-4454-8a38-bfb2a7031d06';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('echoAR unity app'),
      ),
      body: Stack(
        children: <Widget>[
          UnityView(
            onCreated: onUnityViewCreated,
            onReattached: onUnityViewReattached,
            onMessage: onUnityViewMessage,
          ),
          Positioned(
            top: 10,
            left: 20,
            right: 20,
            height: 90,
            child: questionCard(),
          ),
        ],
      ),
    );
  }

  void onUnityViewCreated(UnityViewController controller) {
    print('onUnityViewCreated');

    unityViewController = controller;
  }

  void onUnityViewReattached(UnityViewController controller) {
    print('onUnityViewReattached');
  }

  void onUnityViewMessage(UnityViewController controller, String message) {
    print('onUnityViewMessage');

    print(message);
  }

  void setScale(String scale) {
    String url = 'https://console.echoar.xyz/post';
    print(scale);
    http.post(url, body: {
      'key': _projectKey,
      'entry': _entryID,
      'data': 'scale',
      'value': scale
    }).then((value) => print(value.body));
  }
}
