import 'package:flutter/material.dart';

class AccentButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const AccentButton(this.text, this.onTap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: MaterialButton(
      onPressed: onTap,
      color: Colors.blue,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}
