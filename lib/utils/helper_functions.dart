import 'package:flutter/material.dart';

class HelperFunctions {
  static Widget customAppBar(String title, BuildContext context,
      {Color? backgroundColor, Color? iconColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: SizedBox(
        height: 40, // Slightly taller for better touch target
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Back button with improved visual feedback
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: backgroundColor ?? Colors.blue,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 18, // Slightly larger icon
                    color: iconColor ?? Colors.white,
                  ),
                ),
              ),
            ),
            // Title with improved typography
            Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600, // Slightly less bold
                  fontSize: 22, // Slightly smaller for better proportion
                  letterSpacing: 0.5,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static customSnackBar({
    required BuildContext context,
    required String text,
    required Color bgColor,
    Color? txtColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: bgColor,
        content: Text(
          text,
          style: TextStyle(color: txtColor ?? Colors.black),
        ),
      ),
    );
  }
}
