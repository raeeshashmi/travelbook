import 'package:flutter/material.dart';

class CustomAuthNavigator extends StatelessWidget {
  final String text1;
  final String text2;
  final void Function() onTap;
  const CustomAuthNavigator({
    super.key,
    required this.text1,
    required this.text2,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "$text1 have an account?",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              text2,
              style: TextStyle(
                fontSize: 16,
                color: Colors.orange,
              ),
            ),
          )
        ],
      ),
    );
  }
}
