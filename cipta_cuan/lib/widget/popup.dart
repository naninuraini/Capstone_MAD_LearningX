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
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          contentPadding: EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                imagePath,
                height: 120,
              ),
              SizedBox(height: 16.0),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24.0),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tombol Batal
                  SecondaryButton(
                    onPressed: () => Navigator.of(context).pop(),
                    title: 'Batal',
                    colorTitle: Color(0xFF375DFB),
                    width: 130,
                    height: 46,
                  ),
                  // Tombol Konfirmasi
                  ButtonWidget(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onConfirm();
                    },
                    title: 'Konfirmasi',
                    width: 130,
                    height: 46,
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.of(context).pop();
                  //     onConfirm();
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.transparent,
                  //     elevation: 0,
                  //   ),
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  //     decoration: BoxDecoration(
                  //       gradient: LinearGradient(
                  //         colors: [
                  //           Color(0xFF0DA6C2),
                  //           Color(0xFF0E39C6),
                  //         ],
                  //         begin: Alignment.topLeft,
                  //         end: Alignment.bottomRight,
                  //       ),
                  //       borderRadius: BorderRadius.circular(16.0),
                  //     ),
                  //     child: Text(
                  //       'Konfirmasi',
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
