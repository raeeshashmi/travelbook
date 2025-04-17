import 'package:flutter/material.dart';

class CustomPostBtn extends StatelessWidget {
  final void Function() onTap;
  final bool isLoading;

  const CustomPostBtn({
    super.key,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                )
              : const Text(
                  'Post',
                  style: TextStyle(
                    fontSize: 22.5,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
