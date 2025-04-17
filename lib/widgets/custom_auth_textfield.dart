import 'package:flutter/material.dart';

class CustomAuthTextfield extends StatelessWidget {
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextInputType? keyboadrType;
  final String text;
  final TextEditingController controller;
  const CustomAuthTextfield({
    super.key,
    required this.text,
    required this.controller,
    this.obscureText,
    this.keyboadrType,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.only(left: 25, top: 5, bottom: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(25),
          ),
          child: TextField(
            keyboardType: keyboadrType,
            obscureText: obscureText ?? false,
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.grey,
            controller: controller,
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
