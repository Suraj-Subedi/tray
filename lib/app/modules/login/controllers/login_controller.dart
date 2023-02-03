import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

import 'package:flutter/material.dart';

class LoginController extends GetxController with WindowListener {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey4 = GlobalKey<FormState>();

  final count = 0.obs;
  @override
  void onInit() {
    windowManager.addListener(this);
    Window.setEffect(
        effect: WindowEffect.transparent,
        color: const Color.fromARGB(0, 236, 236, 236));
    super.onInit();
  }

  @override
  void onClose() {
    windowManager.removeListener(this);
  }
}
