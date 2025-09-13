import 'package:flutter/material.dart';

class EmptyOrdersWidget extends StatelessWidget {
  final String text;
  const EmptyOrdersWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text, style: const TextStyle(fontSize: 16, color: Colors.grey)),
    );
  }
}
