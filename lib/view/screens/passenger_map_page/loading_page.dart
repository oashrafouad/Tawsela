import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage(this.message, {super.key});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(78, 255, 255, 255),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(message, style: TextStyle(fontSize: 20)),
              CircularProgressIndicator(
                color: Colors.green,
              )
            ],
          ),
        ),
      ),
    );
  }
}
