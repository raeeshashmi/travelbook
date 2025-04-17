import 'package:flutter/material.dart';

class CustomHomeTextfield extends StatelessWidget {
  final TextEditingController controller;
  const CustomHomeTextfield({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 25,
      right: 25,
      bottom: 10,
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(5),
        child: Container(
          padding: EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.black,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search your destination',
                  ),
                ),
              ),
              Icon(Icons.search),
              SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
