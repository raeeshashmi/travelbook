import 'package:flutter/material.dart';

class CustomHomeButton extends StatelessWidget {
  final Widget child;
  final void Function() onTap;
  const CustomHomeButton({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(7.5),
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: Color(0xFF4361EE),
            borderRadius: BorderRadius.circular(10),
          ),
          child: child,
        ),
      ),
    );
  }
}
