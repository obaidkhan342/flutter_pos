// ignore_for_file: file_names

import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

Widget addCustomerTextField({
  required BuildContext context,
  String? name,
  TextInputType? keyboard,
  bool? isPassword,
  IconData? myIcon,
  Widget? suffixIcon,
  Function(String)? onChanged,
  final String? Function(String?)? validator,
  TextEditingController? controller,
  FocusNode? focus,
  FocusNode? nextFocus,
  double? iconSize,
  int? noOfLine,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5.0),
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: noOfLine != null
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.end,
      children: [
        Icon(myIcon, size: iconSize, color: Colors.black),
        SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            focusNode: focus,
            autovalidateMode: AutovalidateMode.disabled,
            onChanged: onChanged,
            validator: validator,
            maxLength: noOfLine,
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
              labelText: name,
              hintText: name,
              suffixIcon: suffixIcon,
              // prefixIcon: prefixIcon,
              // border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              // focusedBorder: const OutlineInputBorder(
              //   // borderSide: BorderSide(color: AppColors.primaryColor),
              // ),
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
        ),
      ],
    ),
  );
}
