import 'package:flutter/material.dart';

class Paragraph extends StatelessWidget {
  const Paragraph(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
