import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final double height;
  final double width;

  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.height = 50,
    this.width = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0DA6C2),
            Color(0xFF0E39C6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Color(0xFF375DFB),
          width: 1.0,
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          child: Text(title),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final double height;
  final double width;
  final Color colorTitle;
  final double fontSize;
  final FontWeight fontWeight;

  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.height = 50,
    this.width = 100,
    this.colorTitle = Colors.white,
    this.fontSize = 16,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Color(0xFF375DFB),
          width: 1.0,
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: colorTitle,
          ),
        ),
      ),
    );
  }
}
