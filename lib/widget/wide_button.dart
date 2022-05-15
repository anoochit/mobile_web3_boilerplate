import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  const WideButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => onPressed(),
        child: Text(text),
      ),
    );
  }
}
