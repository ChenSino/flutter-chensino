
import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Error',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Something went wrong',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Please try again later',
              style: TextStyle(fontSize: 16),
            ),
    ]
    ),
      ),
    );
  }
}
