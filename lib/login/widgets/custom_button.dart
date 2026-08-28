import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool loading;
  final String text;

  const CustomButton({
    super.key, 
    this.onPressed, 
    required this.loading, 
    required this.text});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed, 
        child: loading
        ? CircularProgressIndicator(
          color: Colors.blue,
        )
        : Text(text, style: TextStyle(fontSize: 17),)
      ),
    );
  }
}