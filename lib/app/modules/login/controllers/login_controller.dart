import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

import 'package:flutter/material.dart';

class LoginController extends GetxController with WindowListener {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final count = 0.obs;
  @override
  void onInit() {
    windowManager.addListener(this);
    super.onInit();
  }

  @override
  void onClose() {
    windowManager.removeListener(this);
  }
}
