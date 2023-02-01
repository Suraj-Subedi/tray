import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tray_test1/app/utils/theme/appcolors.dart';

class CustomTextFormField extends StatefulWidget {
  final String leadingIcon;
  final String? labelName;
  final IconData? trailingIcon;
  final bool showEyeIcon;
  final bool showTrailingIcon;
  final bool readonlycheck;
  final TextEditingController controller;
  final Function? validator;

  const CustomTextFormField(
      {super.key,
      required this.leadingIcon,
      this.labelName,
      this.trailingIcon,
      this.readonlycheck = false,
      this.showEyeIcon = false,
      this.showTrailingIcon = true,
      this.validator,
      required this.controller});

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.showEyeIcon ? _obscureText : false,
      readOnly: widget.readonlycheck,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
        prefixIcon: widget.leadingIcon != null
            ? Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: SvgPicture.asset(widget.leadingIcon),
              )
            : null,
        suffixIcon: widget.showTrailingIcon
            ? widget.showEyeIcon
                ? IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    color: AppColors.borderGrey,
                  )
                : Icon(widget.trailingIcon)
            : null,
        labelText: widget.labelName,
        // not show label text when field is active
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.borderGrey,
            width: 1,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.borderGrey,
            width: 1,
          ),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: AppColors.primary,
      validator: (value) =>
          widget.validator != null ? widget.validator!(value) : null,
    );
  }
}
