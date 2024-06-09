import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Login text form field
class LoginTextFormField extends StatefulWidget {
  /// Login text form field constructor
  const LoginTextFormField({
    required this.hintText,
    this.isPassword = false,
    this.controller,
    super.key,
    this.digitOnly = false,
    this.maxLength,
  });

  /// Hint text
  final String hintText;

  /// TextEditingController
  final TextEditingController? controller;

  /// Is password
  final bool isPassword;

  /// Digit only
  final bool? digitOnly;

  /// Max length
  final int? maxLength;

  @override
  State<LoginTextFormField> createState() => _LoginTextFormFieldState();
}

class _LoginTextFormFieldState extends State<LoginTextFormField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      keyboardType:
          widget.digitOnly ?? false ? TextInputType.number : TextInputType.text,
      inputFormatters: widget.digitOnly ?? false
          ? [FilteringTextInputFormatter.digitsOnly]
          : null,
      obscureText: widget.isPassword && _isObscure,
      controller: widget.controller,
      decoration: InputDecoration(
        counterText: '',
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                icon: _isObscure
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              )
            : null,
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Color(0xff9E4759),
        ),
        fillColor: const Color(0xffF5E5E8), // Arka plan rengi F5E5E8 olur
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none, // Çerçeveyi kaldırır
          borderRadius: BorderRadius.circular(10), // Kenarları yuvarlar
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none, // Çerçeveyi kaldırır
          borderRadius: BorderRadius.circular(10), // Kenarları yuvarlar
        ),
      ),
    );
  }
}
