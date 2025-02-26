import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(QuoteApp());
}

class QuoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuoteScreen(),
    );
  }
}

class QuoteScreen extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  String _quote = "QUOTES";

  Future<void> fetchQuote() async {
    try {
      final response = await http.get(Uri.parse('https://api.quotable.io/random'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _quote = data['content'];
        });
      } else {
        setState(() {
          _quote = "Failed to fetch quote. Try again.";
        });
      }
    } catch (e) {
      setState(() {
        _quote = "An error occurred. Please try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('EXAM MATE QUOTE',style: TextStyle(color: Colors.white,),),backgroundColor: Colors.black,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _quote,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic,color: Colors.white,),
            ),
            SizedBox(height: 20),
             Center(
              child: ElevatedButton(
                onPressed: fetchQuote,
                child: Text('Fetch Quote',style: TextStyle(color: Colors.black,)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
