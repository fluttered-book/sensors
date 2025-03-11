import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String text;

  const Header(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
