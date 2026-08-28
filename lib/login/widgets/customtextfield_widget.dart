import 'package:flutter/material.dart';

class CustomtextfieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool showPasswordIcon;
  final bool obscureText;

  const CustomtextfieldWidget({super.key, required this.controller, 
  required this.label, required this.icon,
  this.onPressed, 
  this.showPasswordIcon = false,
  this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        label: Text(label),
        prefixIcon: Icon(icon),
        suffixIcon: showPasswordIcon
        ? IconButton(
          onPressed: onPressed, 
          icon: Icon(
            obscureText
            ? Icons.visibility_off
            : Icons.visibility
          )
        )
        : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        )
      ),
    );
  }
}
