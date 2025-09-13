import 'package:flutter/material.dart';

class BaseBody extends StatelessWidget {
  final Widget body;
  final double height;
  final Widget childcontiner;

  const BaseBody({
    super.key,
    required this.height,
    required this.body,
    required this.childcontiner,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          SizedBox(
            height: height,
            width: double.infinity,
            child:childcontiner,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: body,
            ),
          ),
        ],
    );
  }
}
