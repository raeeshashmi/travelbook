import 'package:flutter/material.dart';

class CustomAuthImage extends StatelessWidget {
  final String url;
  const CustomAuthImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(150),
      ),
      child: Image.asset(url),
    );
  }
}
