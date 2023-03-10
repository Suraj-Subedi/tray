import 'dart:async';
import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
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
  await Window.initialize();
  if (Platform.isWindows) {
    Window.hideWindowControls();
    Window.hideTitle();
    Window.makeTitlebarTransparent();
  }
  await windowManager.ensureInitialized();

  await Window.setEffect(effect: WindowEffect.acrylic);
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
    center: false,
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

  if (Platform.isWindows) {
    doWhenWindowReady(() {
      const initialSize = Size(375, 750);
      appWindow.minSize = initialSize;
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.bottomRight;
      appWindow.show();
    });
  }
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
          onClicked: (menuItem) async => {
                (Platform.isWindows)
                    ? windowManager.restore()
                    : await windowManager.show()
              }),
      MenuItemLabel(
          label: 'Hide',
          onClicked: (menuItem) => (Platform.isWindows)
              ? windowManager.minimize()
              : windowManager.hide()),
      MenuItemLabel(
          label: 'Exit', onClicked: (menuItem) => windowManager.close()),
    ]);

    await systemTray.setContextMenu(menu);

    systemTray.registerSystemTrayEventHandler((eventName) async {
      windowManager.removeListener(this);

      debugPrint("eventName: $eventName");
      if (eventName == kSystemTrayEventClick) {
        if (Platform.isWindows) {
          if (await windowManager.isMinimized()) {
            await windowManager.restore();
            // setState(() {});
            windowManager.addListener(this);

            return;
          } else {
            await windowManager.minimize();
            // setState(() {});
            windowManager.addListener(this);

            return;
          }
        } else {
          if (await windowManager.isVisible()) {
            await windowManager.hide();
          } else {
            await windowManager.show();
            setState(() {});
          }
        }
      }
      if (eventName == kSystemTrayEventRightClick) {
        await systemTray.popUpContextMenu();
      }
      windowManager.addListener(this);
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
  void onWindowFocus() async {
    (Platform.isWindows) ? windowManager.restore() : await windowManager.show();
  }

  @override
  void onWindowBlur() async {
    (Platform.isWindows)
        ? windowManager.minimize()
        : await windowManager.hide();
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
