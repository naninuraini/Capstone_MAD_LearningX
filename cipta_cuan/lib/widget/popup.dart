import 'package:cipta_cuan/widget/button.dart';
import 'package:flutter/material.dart';

class ConfirmationPopup {
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String imagePath,
    required VoidCallback onConfirm,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFFE1E1E1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  imagePath,
                  height: 200,
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6C757D), 
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: SecondaryButton(
                        onPressed: () => Navigator.of(context).pop(),
                        title: 'Batal',
                        colorTitle: const Color(0xFF6C757D), 
                        width: double.infinity,
                        height: 46,
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Expanded(
                      child: ButtonWidget(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onConfirm();
                        },
                        title: 'Konfirmasi',
                        width: double.infinity,
                        height: 46,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
