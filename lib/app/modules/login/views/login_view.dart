import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:tray_test1/app/routes/app_pages.dart';
import 'package:tray_test1/app/utils/asset_strings.dart';
import 'package:tray_test1/app/utils/theme/theme.dart';
import 'package:tray_test1/app/utils/validators.dart';
import 'package:tray_test1/app/widget/custom_button.dart';
import 'package:tray_test1/app/widget/my_textformfield.dart';
import 'package:window_manager/window_manager.dart';

import '../controllers/login_controller.dart';

ThemeData theme = AppTheme.fromType(AppTheme.defaultTheme).build();
// class LoginView extends GetView<LoginController> {
//   const LoginView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(10),
//       child: Scaffold(
//         backgroundColor: Colors.white.withOpacity(0.97),
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.blue),
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           centerTitle: true,
//           title: const Text(
//             'Add new Log',
//             style: TextStyle(color: Colors.blue),
//           ),
//           actions: [
//             IconButton(
//               onPressed: () async {
//                 await windowManager.hide();
//               },
//               icon: const Icon(Icons.remove),
//             )
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Form(
//               child: Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               children: [
//                 TextFormField(
//                   decoration: const InputDecoration(
//                     labelText: 'Title',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 TextFormField(
//                   textAlignVertical: TextAlignVertical.top,
//                   maxLines: 5,
//                   decoration: const InputDecoration(
//                     labelText: 'Description',
//                     alignLabelWithHint: true,
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 CalendarDatePicker(
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime(2020),
//                     lastDate: DateTime(2050),
//                     onDateChanged: (newDate) {}),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 10, horizontal: 50),
//                       child: const Text('Add')),
//                 )
//               ],
//             ),
//           )),
//         ),
//         drawer: Drawer(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const CircleAvatar(
//                   radius: 50,
//                   backgroundImage: AssetImage('assets/app_icon.ico'),
//                 ),
//                 const Text(
//                   'Suraj Subedi',
//                   style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 ListTile(
//                   onTap: () {},
//                   title: const Text('Add new Log'),
//                 ),
//                 ListTile(
//                   onTap: () {},
//                   title: const Text('View Logs'),
//                 ),
//                 ListTile(
//                   onTap: () {},
//                   title: const Text('Settings'),
//                 ),
//                 ListTile(
//                   onTap: () {},
//                   title: const Text('About'),
//                 ),
//                 ListTile(
//                   onTap: () {},
//                   title: const Text('Log Out'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class LoginView extends GetView<LoginController> with WindowListener {
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      // backgroundColor: theme.backgroundColor.withOpacity(0.2),
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              windowManager.hide();
            },
            icon: const Icon(Icons.remove),
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                AssetStrings.logo,
                height: 140.h,
                width: 140.h,
              ),
              SizedBox(height: 20.h),
              const Text("Enter Login Credentials",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              SizedBox(height: 20.h),
              CustomTextFormField(
                  controller: controller.usernameController,
                  leadingIcon: AssetStrings.email_icon,
                  labelName: "Email",
                  // trailingIcon: Icons.check
                  showEyeIcon: false,
                  showTrailingIcon: false,
                  validator: (value) => Validators.emailValidator(value)),
              SizedBox(
                height: 20.h,
              ),
              CustomTextFormField(
                  controller: controller.passwordController,
                  leadingIcon: AssetStrings.key,
                  labelName: "Password",
                  showEyeIcon: true,
                  showTrailingIcon: true,
                  validator: (value) => Validators.passwordValidator(value)),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                  text: "Login",
                  tap: () {
                    Get.offAllNamed(Routes.HOME);
                  }),
              SizedBox(height: 50.h),
            ],
          )),
    );
  }
}
