import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

import 'package:flutter/material.dart';

class LoginController extends GetxController with WindowListener {
  //TODO: Implement LoginController
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey4 = GlobalKey<FormState>();

  final count = 0.obs;
  @override
  void onInit() {
    windowManager.addListener(this);
    // initSystemTray();
    Window.setEffect(effect: WindowEffect.acrylic);
    super.onInit();
  }

  @override
  void onClose() {
    windowManager.removeListener(this);
  }
}
