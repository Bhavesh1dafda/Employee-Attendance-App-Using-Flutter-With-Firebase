import 'package:flutter/material.dart';

import 'TextView.dart';

class AppDropdown extends StatelessWidget {
  final List<AppDropdownItem>? items;
  final dynamic selectedValue;
  final String? hint;
  final EdgeInsetsGeometry? padding;
  final double? outlineRadius;
  final Function(dynamic)? onChanged;
  FormFieldValidator<dynamic>? validator;
  bool? optional;

  AppDropdown(
      {this.items,
      this.selectedValue,
      this.hint,
      this.padding = const EdgeInsets.symmetric(horizontal: 0),
      this.outlineRadius = 0,
      this.onChanged,
      this.validator,
      this.optional = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.transparent),
        borderRadius: BorderRadius.circular(outlineRadius!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          isExpanded: true,
          validator: validator,
          elevation: 1,
          hint: hint != null
              ? optional!
                  ? Padding(
                      padding: const EdgeInsets.only(left: 11),
                      child: TextView(hint),
                    )
                  : TextView(hint)
              : null,
          items: items!
              .map(
                (e) => DropdownMenuItem(
                  child: e.widget!,
                  value: e.value,
                ),
              )
              .toList(),
          value: selectedValue,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class AppDropdownItem {
  Widget? widget;
  dynamic value;

  AppDropdownItem({this.widget, @required this.value});
}
