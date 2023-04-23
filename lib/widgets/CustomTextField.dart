import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String? labelText;
  String? hintText;
  String? errorText;
  Widget? prefixIcon;
  Color? prefixIconColor;
  Widget? prefix;
  Color? fillColor;
  TextEditingController? controller;
  Function(String)? onChanged;
  Function()? onTap;
  bool? enabled;
  bool readOnly;
  CustomTextField(
      {Key? key,
      this.labelText,
      this.errorText,
      this.hintText,
      this.prefixIcon,
      this.prefixIconColor,
      this.fillColor,
      this.onChanged,
      this.onTap,
      this.controller,
      this.enabled,
      this.prefix,
      this.readOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      onChanged: onChanged != null ? (value) => onChanged!(value) : null,
      onTap: onTap,
      readOnly: readOnly,
      decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          labelText: labelText,
          hintText: hintText,
          errorText: errorText,
          prefixIcon: prefixIcon,
          prefix: prefix,
          prefixIconColor: prefixIconColor,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: Colors.white)),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: Colors.white),
          )),
    );
  }
}
