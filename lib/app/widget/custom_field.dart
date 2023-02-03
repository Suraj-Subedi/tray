import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tray_test1/app/utils/asset_strings.dart';

// import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:tray_test1/app/utils/theme/appcolors.dart';

class CustomField extends StatelessWidget {
  final TextEditingController controller;
  final Function? validator;
  final Function? onChanged;
  final String label;
  final VoidCallback? suffixIconCallback;
  final String? title;
  final int? maxline;
  final bool isObscureText;
  final bool isHaveSuffixIcon;
  final bool isRequired;
  final TextInputType inputType;
  final int? maxLength;
  const CustomField(
      {Key? key,
      required this.controller,
      this.validator,
      this.suffixIconCallback,
      this.maxLength,
      this.maxline = 1,
      this.title,
      this.inputType = TextInputType.text,
      this.isObscureText = false,
      this.isRequired = false,
      this.isHaveSuffixIcon = false,
      required this.label,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // margin: EdgeInsets.all(10.h),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(110, 199, 191, 191),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: SizedBox(
              child: TextFormField(
                  maxLength: maxLength,
                  maxLines: maxline,
                  obscureText: isObscureText,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: AppColors.blackColor,
                  validator: (value) =>
                      validator != null ? validator!(value) : null,
                  controller: controller,
                  keyboardType: inputType,
                  style: ThemeData().textTheme.headline4,
                  decoration: InputDecoration(
                    fillColor: AppColors.whiteColor,
                    filled: true,
                    hintText: label,
                    labelText: label,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.normal,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(
                        color: AppColors.whiteColor,
                        width: 1.0,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(
                        color: AppColors.whiteColor,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(
                        color: AppColors.whiteColor,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(
                        color: AppColors.whiteColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(
                        color: AppColors.errorColor,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(
                        color: AppColors.errorColor,
                      ),
                    ),
                    suffixIcon: isHaveSuffixIcon
                        ? GestureDetector(
                            onTap: suffixIconCallback,
                            child: const Icon(Icons.close)
                            // Image.asset(AssetStrings.eye_closed)
                            )
                        : null,
                    errorStyle: const TextStyle(
                      color: AppColors.errorColor,
                    ),
                  ))),
        ),
      ],
    );
  }
}

class CustomDropDownField extends StatelessWidget {
  final Function? validator;
  final Function? onChanged;
  final Function? onSaved;
  final String label;
  final String? title;
  final String? errorMessage;
  final VoidCallback? suffixIconCallback;

  final int? maxline;
  final bool isObscureText;
  final bool isHaveSuffixIcon;
  final bool isRequired;
  final TextInputType inputType;
  final int? maxLength;
  final List<String>? items;
  const CustomDropDownField({
    Key? key,
    this.validator,
    this.errorMessage,
    this.suffixIconCallback,
    this.maxLength,
    this.maxline = 1,
    this.items,
    this.inputType = TextInputType.text,
    this.isObscureText = false,
    this.isRequired = false,
    this.isHaveSuffixIcon = false,
    required this.label,
    this.title,
    this.onChanged,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(10.h),
      // padding: EdgeInsets.all(10.h),
      padding: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(110, 199, 191, 191),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null)
            Text(
              title!,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline4?.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.blackColor),
            ),
          SizedBox(
            // height: 60.h,
            child: DropdownButtonFormField2(
                // buttonHeight: 15.h,
                isExpanded: true,
                hint: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    color: AppColors.blackColor,
                  ),
                ),
                icon: const Icon(Icons.keyboard_arrow_down),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                items: items!
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                color: AppColors.blackColor),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return errorMessage;
                  }
                  return null;
                },
                onChanged: (value) {},
                onSaved: (value) {},
                autovalidateMode: AutovalidateMode.onUserInteraction,
                // style: ThemeData().textTheme.headline4,
                decoration: InputDecoration(
                  fillColor: AppColors.whiteColor,
                  filled: true,
                  hintText: label,
                  labelStyle: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.normal,
                  ),
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(8.r),
                  //   borderSide: const BorderSide(
                  //     color: AppColors.textBoxBorderColor,
                  //     width: 1.0,
                  //   ),
                  // ),
                  // disabledBorder: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(8.r),
                  //   borderSide: const BorderSide(
                  //     color: AppColors.textBoxBorderColor,
                  //     width: 1.0,
                  //   ),
                  // ),
                  // enabledBorder: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(8.r),
                  //   borderSide: const BorderSide(
                  //     color: AppColors.textBoxBorderColor,
                  //     width: 1.0,
                  //   ),
                  // ),
                  // focusedBorder: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(8.r),
                  //   borderSide: const BorderSide(
                  //     color: AppColors.textBoxBorderColor,
                  //   ),
                  // ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(
                      color: AppColors.errorColor,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(
                      color: AppColors.errorColor,
                    ),
                  ),
                  suffixIcon: isHaveSuffixIcon
                      ? GestureDetector(
                          onTap: suffixIconCallback,
                          child: const Icon(Icons.keyboard_arrow_down))
                      : null,
                  errorStyle: const TextStyle(
                    color: AppColors.errorColor,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

// class StarRate extends StatefulWidget {
//   const StarRate({Key? key}) : super(key: key);

//   @override
//   State<StarRate> createState() => _StarRateState();
// }

// class _StarRateState extends State<StarRate> {
//   double rating = 0.0;
//   @override
//   Widget build(BuildContext context) {
//     return SmoothStarRating(
//         allowHalfRating: false,
//         onRatingChanged: (v) {
//           rating = v;
//           setState(() {});
//         },
//         starCount: 5,
//         rating: rating,
//         size: 30.0,
//         // filledIconData: Icons.blur_off,
//         // halfFilledIconData: Icons.blur_on,
//         color: Colors.black,
//         borderColor: Colors.black,
//         spacing: 0.0);
//   }
// }
