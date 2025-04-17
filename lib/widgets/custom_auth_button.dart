import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;

  const CustomAuthButton({
    super.key,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(child: child),
      ),
    );
  }
}
