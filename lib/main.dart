import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:system_tray/system_tray.dart';
import 'package:tray_test1/app/routes/app_pages.dart';
import 'package:tray_test1/app/utils/theme/theme.dart';
import 'package:window_manager/window_manager.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await Window.setEffect(
  effect: WindowEffect.acrylic
);
  await Window.initialize();
  await windowManager.hide();

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  LaunchAtStartup.instance.setup(
    appName: packageInfo.appName,
    appPath: Platform.resolvedExecutable,
  );
  await LaunchAtStartup.instance.enable();

  var initialSize = const Size(375, 750);
  WindowOptions windowOptions = WindowOptions(
    size: initialSize,
    maximumSize: initialSize,
    minimumSize: initialSize,
    skipTaskbar: true,
  );

  await windowManager.waitUntilReadyToShow(
    windowOptions,
    () async {
      await windowManager.setAsFrameless();
      Platform.isWindows
          ? await windowManager.setAlignment(Alignment.bottomRight)
          : await windowManager.setAlignment(Alignment.topRight);
      await windowManager.show();
    },
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);
    initSystemTray();
    super.initState();
    Window.setEffect(effect: WindowEffect.acrylic);
    setState(() {});
  }

  Future<void> initSystemTray() async {
    String path =
        Platform.isWindows ? 'assets/app_icon.ico' : 'assets/app_icon.png';

    final SystemTray systemTray = SystemTray();

    await systemTray.initSystemTray(
      title: "system tray",
      iconPath: path,
    );

    final Menu menu = Menu();
    await menu.buildFrom([
      MenuItemLabel(
          label: 'Show',
          onClicked: (menuItem) async => {await windowManager.show()}),
      MenuItemLabel(
          label: 'Hide', onClicked: (menuItem) => windowManager.hide()),
      MenuItemLabel(
          label: 'Exit', onClicked: (menuItem) => windowManager.close()),
    ]);

    await systemTray.setContextMenu(menu);

    systemTray.registerSystemTrayEventHandler((eventName) async {
      windowManager.removeListener(this);

      debugPrint("eventName: $eventName");
      if (eventName == kSystemTrayEventClick) {
        if (await windowManager.isVisible()) {
          await windowManager.hide();
          windowManager.addListener(this);
        } else {
          await windowManager.show();
          windowManager.addListener(this);
          setState(() {});
        }
      }
      if (eventName == kSystemTrayEventRightClick) {
        windowManager.addListener(this);
        await systemTray.popUpContextMenu();
      }
    });
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 750),
        builder: ((context, child) {
          ScreenUtil.init(context);
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.fromType(AppTheme.defaultTheme).build(),
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
          );
        }));
  }

  @override
  Future<void> onWindowEvent(String eventName) async {}

  @override
  void onWindowClose() {}

  @override
  void onWindowFocus() async {}

  @override
  void onWindowBlur() async {
    await windowManager.hide();
  }

  @override
  void onWindowMaximize() {
    // do something
  }

  @override
  void onWindowUnmaximize() {
    // do something
  }

  @override
  void onWindowMinimize() {
    // do something
  }

  @override
  void onWindowRestore() {
    // do something
  }

  @override
  void onWindowResize() {
    // do something
  }

  @override
  void onWindowMove() {
    // do something
  }

  @override
  void onWindowEnterFullScreen() {
    // do something
  }

  @override
  void onWindowLeaveFullScreen() {
    // do something
  }
}
