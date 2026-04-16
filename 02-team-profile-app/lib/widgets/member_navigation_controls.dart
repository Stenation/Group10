import 'package:flutter/material.dart';

class MemberNavigationControls extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final EdgeInsetsGeometry buttonPadding;
  final double fontSize;

  const MemberNavigationControls({
    super.key,
    required this.onPrevious,
    required this.onNext,
    required this.buttonPadding,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: onPrevious,
          child: Padding(
            padding: buttonPadding,
            child: Icon(Icons.arrow_back, size: fontSize),
          ),
        ),
        ElevatedButton(
          onPressed: onNext,
          child: Padding(
            padding: buttonPadding,
            child: Icon(Icons.arrow_forward, size: fontSize),
          ),
        ),
      ],
    );
  }
}
