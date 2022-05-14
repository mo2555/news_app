import 'package:flutter/material.dart';

Widget defaultFormField({
   TextEditingController? controller,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChanged,
  GestureTapCallback? onTap,
  bool isPassword = false,
  required FormFieldValidator<String>? validate,
  required Widget label,
  required Widget prefix,
  Widget? suffix,
  Function? suffixPressed,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    onFieldSubmitted: onSubmit,
    onTap: onTap,
    onChanged: onChanged,
    validator: validate,
    decoration: InputDecoration(
        label: label,
        prefixIcon: prefix,
        suffix: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )),
  );
}