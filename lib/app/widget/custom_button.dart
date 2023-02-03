import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/theme/appcolors.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    required this.text,
    this.tap,
    Key? key,
  }) : super(key: key);

  final String text;
  VoidCallback? tap;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return ElevatedButton(
      onPressed: tap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Text(
          text,
          style: TextStyle(color: AppColors.surfaceWhite, fontSize: 15.sp),
        ),
      ),
    );
  }
}
