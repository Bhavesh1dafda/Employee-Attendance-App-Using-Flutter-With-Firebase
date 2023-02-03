import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class EditTextSearch extends StatelessWidget {
  final TextEditingController? controller;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FocusNode? focusNode;
  final Color? textColor;
  final String? lableText;
  final TextStyle? lableStyle;
  final String? hint;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization? textCapitalization;
  final bool? autoCorrect;
  bool? obscureText = false;
  final int? maxLength;
  final bool? filled;
  final InputBorder? border;
  final Color? cursorColor;
  final Color? fillColor;
  bool? showRectangularInputBorder = true;
  bool? showBorder = false;
  final double? borderRadius;
  BorderSide? borderSide;
  final EdgeInsetsGeometry? contentPadding;
  final FormFieldValidator<String>? validator;
  final int? minLines;
  final int? maxLines;
  final bool? enable;
  final bool? enableSuggestions;
  final bool? enableInteractiveSelection;
  final TextAlign? textAlign;
  final TextInputAction? inputAction;
  final Function(String value)? onFieldSubmitted;

  EditTextSearch({
    this.focusNode,
    this.controller,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.normal,
    this.textColor,
    this.lableText,
    this.lableStyle,
    this.hint,
    this.cursorColor = Colors.white,
    this.hintStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.border,
    this.inputType,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.autoCorrect = true,
    this.obscureText = false,
    this.maxLength,
    this.filled,
    this.fillColor,
    this.showRectangularInputBorder = false,
    this.showBorder = false,
    this.borderRadius = 0.0,
    this.borderSide,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 10),
    this.validator,
    this.minLines = 1,
    this.maxLines = 1,
    this.enable = true,
    this.enableSuggestions = true,
    this.enableInteractiveSelection = true,
    this.textAlign = TextAlign.start,
    this.inputAction,
    this.onFieldSubmitted,
  }) {
    if (showRectangularInputBorder! && (showBorder == null)) {
      showBorder = true;
    }
    if (borderSide == null) {
      borderSide = BorderSide();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization!,
      autocorrect: autoCorrect!,
      obscureText: obscureText!,
      validator: validator,
      maxLength: maxLength,
      cursorColor: cursorColor,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: hintStyle,
        labelText: lableText,
        labelStyle: lableStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: filled,
        fillColor: fillColor,
        border: border,
        contentPadding: contentPadding,
      ),
      minLines: minLines,
      maxLines: maxLines,
      enabled: enable,
      enableSuggestions: enableSuggestions!,
      enableInteractiveSelection: enableInteractiveSelection!,
      textAlign: textAlign!,
      textInputAction: inputAction,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
