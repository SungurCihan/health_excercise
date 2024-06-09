import 'package:flutter/material.dart';

/// Login button
class LoginButton extends StatelessWidget {
  /// Login button constructor
  const LoginButton({
    required this.text,
    this.onPressed,
    super.key,
    this.color,
  });

  /// Text
  final String text;

  /// On pressed
  final VoidCallback? onPressed;

  /// Color
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          color ?? const Color(0xffFA738F),
        ), // Arka plan rengi F5E5E8 olur
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Kenarları yuvarlar
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
