import 'package:flutter/material.dart';

class CustomMessage extends StatelessWidget {
  final String message;
  const CustomMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Text(
        message,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
      ),
    );
  }
}
