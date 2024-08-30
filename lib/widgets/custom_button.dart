import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.backgroundColor = Colors.black87,
    this.foregroundColor = Colors.white,
    this.borderRadius = 10.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  final Color backgroundColor;
  final Color foregroundColor;
  final double borderRadius;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[900],
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(borderRadius: BorderRadius.circular(borderRadius),
        onTap: onPressed,
        child: Padding(
          padding: padding,
          child: DefaultTextStyle(
            style: TextStyle(color: foregroundColor),
            child: child,
          ),
        ),
      ),
    );
  }
}