import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_number_checker/flutter_number_checker.dart' as checker;

void main() {
  runApp(const NumberCheckerApp());
}

class NumberCheckerApp extends StatelessWidget {
  const NumberCheckerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      home: const NumberCheckerPage(title: 'Number Shapes'),
    );
  }
}

class NumberCheckerPage extends StatefulWidget {
  const NumberCheckerPage({super.key, required this.title});

  final String title;

  @override
  State<NumberCheckerPage> createState() => _NumberCheckerPageState();
}

class _NumberCheckerPageState extends State<NumberCheckerPage> {
  String _resultMessage = '';
  num _resultingNumber = 0;

  final TextEditingController sumController = TextEditingController();

  void _showResult() {
    setState(() {
      if (sumController.text.isEmpty) {
        _resultMessage = 'Please enter a number.';
      } else {
        _resultingNumber = int.parse(sumController.text);
        _resultMessage = "Number $_resultingNumber is neither TRIANGULAR nor SQUARE.";
        bool isSquare = checker.FlutterNumberChecker.isPerfectSquare(_resultingNumber);
        bool isTriangle = checker.FlutterNumberChecker.isPerfectCube(_resultingNumber);
        if (isSquare && isTriangle) {
          _resultMessage = "Number $_resultingNumber is both SQUARE and TRIANGLE.";
        } else {
          if (isSquare) {
            _resultMessage = "Number $_resultingNumber is SQUARE.";
          }
          if (isTriangle) {
            _resultMessage = "Number $_resultingNumber is TRIANGLE.";
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Center(child: Text(widget.title)),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
                'Please input a number to see if it is square or triangular.'
            ),
            TextField(
              controller: sumController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+(?:\.\d+)?$')),
              ],
            ),
            TextButton(
                onPressed: () {
                  _showResult();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(_resultingNumber.toString()),
                        content: Text(_resultMessage),
                        actions: [
                          TextButton(
                            child: Text("Close"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },

                child: const Text("CONVERT",
                    style: TextStyle(fontSize: 20))
            ),


          ],
        ),
      ),
    );
  }
}