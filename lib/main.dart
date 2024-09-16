import 'package:flutter/material.dart';
import 'package:simple_calculator/widget/button_widget.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '';

  // Array of buttons
  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Calculator"),
      ), // AppBar
      backgroundColor: Colors.grey[400],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            // Display section
            Expanded(
              child: SingleChildScrollView(
                // Qo'shildi
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userInput,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      alignment: Alignment.centerRight,
                      child: Text(
                        answer,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Buttons section
            Expanded(
              flex: 3,
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisExtent: 100, // Main axis extentni moslash
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return buildButton(index); // Alohida funksiyaga joylandi
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

// Buttonni alohida funksiya sifatida tuzing
  Widget buildButton(int index) {
    if (index == 0) {
      return MyButton(
        buttontapped: () {
          setState(() {
            userInput = '';
            answer = '0';
          });
        },
        buttonText: buttons[index],
        color: Colors.blue[50],
        textColor: Colors.black,
      );
    } else if (index == 1) {
      return MyButton(
        buttonText: buttons[index],
        color: Colors.blue[50],
        textColor: Colors.black,
      );
    } else if (index == 2) {
      return MyButton(
        buttontapped: () {
          setState(() {
            userInput += buttons[index];
          });
        },
        buttonText: buttons[index],
        color: Colors.blue[50],
        textColor: Colors.black,
      );
    } else if (index == 3) {
      return MyButton(
        buttontapped: () {
          setState(() {
            userInput = userInput.substring(0, userInput.length - 1);
          });
        },
        buttonText: buttons[index],
        color: Colors.blue[50],
        textColor: Colors.black,
      );
    } else if (index == 18) {
      return MyButton(
        buttontapped: () {
          setState(() {
            equalPressed();
          });
        },
        buttonText: buttons[index],
        color: Colors.orange[700],
        textColor: Colors.white,
      );
    } else {
      return MyButton(
        buttontapped: () {
          setState(() {
            userInput += buttons[index];
          });
        },
        buttonText: buttons[index],
        color: isOperator(buttons[index]) ? Colors.blueAccent : Colors.white,
        textColor: isOperator(buttons[index]) ? Colors.white : Colors.black,
      );
    }
  }

// function to calculate the input operation
  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput =
        userInput.replaceAll('x', '*'); // Ko'paytirish belgisini almashtirish

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput); // Ifodani parslash
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm); // Hisoblash
    answer = eval.toStringAsFixed(2); // Natijani saqlash
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }
}
