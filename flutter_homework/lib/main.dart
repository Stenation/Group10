import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(backgroundColor: Colors.blue,
        body: Center(
          child: SizedBox(height: 400,width: 1000, 
              child: Column(
                children: [
                  Expanded(flex: 5, child: Container(color: Colors.white)),
                  Expanded(flex: 5, child: Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(flex: 3,
                        child: Align(alignment: Alignment.centerRight, 
                          child: Text ("Login: ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),),
                      Expanded(flex: 5, child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your username',
                        ),
                      )),
                    ],
                  )),
                  Expanded(flex: 5, child: Container(color: Colors.purple)),
                  Expanded(flex: 5, child: Container(color: Colors.green)),
                ],
              ),
          ),
        ),
      ),
    );
  }
}
