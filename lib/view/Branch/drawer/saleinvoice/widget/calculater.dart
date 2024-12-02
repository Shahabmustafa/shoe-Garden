import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _controller = TextEditingController();

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _controller.clear();
      } else if (value == '<') {
        if (_controller.text.isNotEmpty) {
          _controller.text =
              _controller.text.substring(0, _controller.text.length - 1);
        }
      } else if (value == '100' || value == '1000') {
        _controller.text += value;
      } else if (value == 'Next') {
        // Implement the action for the "Next" button here.
        // For now, we'll just clear the text field.
        _controller.clear();
      } else {
        _controller.text += value;
      }
    });
  }

  Widget _buildButton(String value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(value),
          child: Text(value, style: TextStyle(fontSize: 20)),
          style: ElevatedButton.styleFrom(
            // primary: value == '100' || value == '1000' || value == 'Next' ? Colors.blue : Colors.white,
            // onPrimary: value == '100' || value == '1000' || value == 'Next' ? Colors.white : Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        width: 500,
        height: 300,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "Keyboard",
              style: GoogleFonts.lato(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('100'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('1000'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('Next'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('C'),
                    _buildButton('0'),
                    _buildButton('.'),
                    _buildButton('<'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
