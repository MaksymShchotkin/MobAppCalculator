import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHomePage(),
      routes: {
        '/converter': (context) => ConverterPage(),
      },
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _output = "0";
  String _result = "0";
  String _operand = "";
  double _num1 = 0.0;
  double _num2 = 0.0;

  buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _output = "0";
      _num1 = 0.0;
      _num2 = 0.0;
      _result = "0";
      _operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "/" || buttonText == "*") {
      _num1 = double.parse(_output);
      _operand = buttonText;
      _result = "0";
    } else if (buttonText == ".") {
      if (!_result.contains(".")) {
        _result += buttonText;
      }
    } else if (buttonText == "=") {
      _num2 = double.parse(_output);

      if (_operand == "+") {
        _result = (_num1 + _num2).toString();
      }
      if (_operand == "-") {
        _result = (_num1 - _num2).toString();
      }
      if (_operand == "*") {
        _result = (_num1 * _num2).toString();
      }
      if (_operand == "/") {
        _result = (_num1 / _num2).toString();
      }

      _num1 = 0.0;
      _num2 = 0.0;
      _operand = "";
    } else {
      _result = _result + buttonText;
    }

    setState(() {
      _output = double.parse(_result).toString();
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: Text(
                _output,
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Column(
              children: [
                Row(
                  children: [
                    buildButton("7"),
                    buildButton("8"),
                    buildButton("9"),
                    buildButton("/")
                  ],
                ),
                Row(
                  children: [
                    buildButton("4"),
                    buildButton("5"),
                    buildButton("6"),
                    buildButton("*")
                  ],
                ),
                Row(
                  children: [
                    buildButton("1"),
                    buildButton("2"),
                    buildButton("3"),
                    buildButton("-")
                  ],
                ),
                Row(
                  children: [
                    buildButton("."),
                    buildButton("0"),
                    buildButton("00"),
                    buildButton("+")
                  ],
                ),
                Row(
                  children: [
                    buildButton("CLEAR"),
                    buildButton("="),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        child: Text(
                          "KM to Miles",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/converter');
                        },
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ConverterPage extends StatefulWidget {
  @override
  _ConverterPageState createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  final TextEditingController _controller = TextEditingController();
  String _result = "";

  void _convert() {
    double kilometers = double.tryParse(_controller.text) ?? 0;
    double miles = kilometers * 0.621371;
    setState(() {
      _result = "$miles miles";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kilometer to Mile Converter'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter kilometers',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
