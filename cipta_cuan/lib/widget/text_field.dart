import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'constant.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String prefixIcon;
  final TextInputType keyboardType;
  bool obscurePassword;
  Widget? suffixIcon;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  TextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    required this.keyboardType,
    required this.validator,
    this.inputFormatters,
    this.onChanged,
    this.obscurePassword = false,
    this.suffixIcon,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      obscureText: widget.obscurePassword,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      style: TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.primary,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.borderTextField),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColors.white),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColors.red),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 14.0, 15.0),
          child: SvgPicture.asset(widget.prefixIcon),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: AppColors.textTF),
        suffixIconColor: AppColors.textTF,
        suffixIcon: widget.suffixIcon
      ),
    );
  }
}

// ignore: must_be_immutable
class SecondTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String headerText;
  final TextInputType keyboardType;
  final String suffixIcon;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onPressedSuffix;
  final int? maxLines;
  final bool readOnly;
  final TextStyle? hintStyle;

  SecondTextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.headerText,
    required this.keyboardType,
    required this.validator,
    required this.onPressedSuffix,
    required this.suffixIcon,
    this.hintStyle,
    this.inputFormatters,
    this.onChanged,
    this.maxLines = 1,
    this.readOnly = false,
  });

  @override
  State<SecondTextFieldWidget> createState() => _SecondTextFieldWidgetState();
}

class _SecondTextFieldWidgetState extends State<SecondTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 3.0),
          child: Text(
            widget.headerText,
            style: TextStyle(
              color: AppColors.textPurple,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextFormField(
          readOnly: widget.readOnly,
          validator: widget.validator,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          inputFormatters: widget.inputFormatters,
          style: TextStyle(color: AppColors.black),
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: AppColors.borderTextField),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: AppColors.white),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: AppColors.white),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: AppColors.red),
            ),
            hintText: widget.hintText,
            hintStyle: widget.hintStyle != null
                ? widget.hintStyle
                : TextStyle(color: AppColors.textTF),
            suffixIconColor: AppColors.textTF,
            suffixIcon: IconButton(
              onPressed: widget.onPressedSuffix,
              icon: widget.suffixIcon != 'clock'
                  ? SvgPicture.asset(widget.suffixIcon)
                  : Icon(Icons.alarm),
            ),
          ),
        ),
      ],
    );
  }
}

class ImageTextFieldWidget extends StatefulWidget {
  final String headerText;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final VoidCallback? onTapField;

  ImageTextFieldWidget({
    super.key,
    required this.headerText,
    required this.validator,
    this.onChanged,
    this.onTapField,
  });

  @override
  State<ImageTextFieldWidget> createState() => _ImageTextFieldWidgetState();
}

class _ImageTextFieldWidgetState extends State<ImageTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 3.0),
          child: Text(
            widget.headerText,
            style: TextStyle(
              color: AppColors.textPurple,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextFormField(
          validator: widget.validator,
          onChanged: widget.onChanged,
          style: TextStyle(color: AppColors.white),
          onTap: widget.onTapField,
          readOnly: true,
          maxLines: 5,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/gallery.png",
                      height: 30,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Gambar',
                      style: TextStyle(
                        color: AppColors.textTF,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: AppColors.borderTextField),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: AppColors.white),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: AppColors.white),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: AppColors.red),
            ),
          ),
        ),
      ],
    );
  }
}
