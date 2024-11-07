import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final IconData icon;
  final ValueChanged<String> onChanged;

  const CustomTextField({
    required this.label,
    required this.icon,
    required this.onChanged,
    this.obscureText = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),
    );
  }
}
