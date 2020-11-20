import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project One',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: MyHomePage(title: 'Currency convertor',),
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
  String error;
  String _inputValue = '0';
  double _convertedValue = 0;
  bool _visibility = false;

  void _convert(String _inputValue) {
    setState(() {
      _convertedValue = double.parse(_inputValue) * 4.87;
      print(_convertedValue);
      _visibility = true;
    });
  }

  void _throwError() {
    setState(() {
      error = "You can only enter valid positive numbers!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            widget.title,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image(
              image: NetworkImage('https://lh3.googleusercontent.com/BeUE71bVNSFu-8D8XQpkGJuFMlvEcEp0z5hRd-PqDEiJd1ucpVkHF-6w5LTa0RTFZQ'),
              height: 200,
              width: 500,
            ),
            Container(
              width: 370,
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  hintText: 'Enter the amount in EUR',
                  errorText: error,
                ),
                onChanged: (String value) {
                  _inputValue = value;
                },
              ),
            ),
            RaisedButton(
              child: const Text('Convert'),
              onPressed: () {
                if (_inputValue.contains(new RegExp("^[0-9]+(\\.[0-9]+)?\$")) == true) {

                  error = null;
                  _convert(_inputValue);
                } else {
                  _throwError();
                }
              },
            ),
            Visibility(
              child: Text(
                _convertedValue.toString() + ' RON',
                style: Theme.of(context).textTheme.headline4,
              ),
              visible: _visibility,
            )
          ],
        ),
      ),
    );
  }
}
