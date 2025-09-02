// ignore_for_file: file_names

import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

Widget buildTextFormField({
  required BuildContext context,
  String? name,
  TextInputType? keyboard,
  bool? isPassword,
  Icon? prefixIcon,
  Widget? suffixIcon,
  Function(String)? onChanged,
  final String? Function(String?)? validator,
  TextEditingController? controller,
  FocusNode? focus,
  FocusNode? nextFocus,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5.0),
    width: MediaQuery.of(context).size.width,
    child: TextFormField(
      focusNode: focus,
      autovalidateMode: AutovalidateMode.disabled,
      onChanged: onChanged,
      validator: validator,
      obscureText: isPassword ?? false,
      controller: controller,
      keyboardType: keyboard,

      // cursorColor: AppColors.primaryColor,
      cursorWidth: 2,

      style: const TextStyle(fontSize: 17),
      onSaved: (value) {
        // controller.getStorage.write(name, value);
      },
      decoration: InputDecoration(
        hintText: name,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        focusedBorder: const OutlineInputBorder(
          // borderSide: BorderSide(color: AppColors.primaryColor),
        ),
      ),
      onFieldSubmitted: (_) {
        if (nextFocus != null) {
          focus?.unfocus();
          FocusScope.of(focus!.context!).requestFocus(nextFocus);
        } else {
          focus?.unfocus();
        }
      },
    ),
  );
}
