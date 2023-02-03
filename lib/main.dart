import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:system_tray/system_tray.dart';
import 'package:window_manager/window_manager.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await windowManager.hide();
  await Window.initialize();

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  LaunchAtStartup.instance.setup(
    appName: packageInfo.appName,
    appPath: Platform.resolvedExecutable,
  );
  await LaunchAtStartup.instance.enable();

  var initialSize = const Size(375, 600);
  WindowOptions windowOptions = WindowOptions(
    size: initialSize,
    maximumSize: initialSize,
    minimumSize: initialSize,
    // backgroundColor: Colors.transparent,
    skipTaskbar: true,
    titleBarStyle: TitleBarStyle.hidden,
  );

  await Window.setEffect(
    effect: WindowEffect.acrylic,
    color: const Color.fromARGB(204, 255, 255, 255),
  );

  await windowManager.waitUntilReadyToShow(
    windowOptions,
    () async {
      await windowManager.setResizable(false);
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

enum InterfaceBrightness {
  light,
  dark,
  auto,
}

extension InterfaceBrightnessExtension on InterfaceBrightness {
  bool getIsDark(BuildContext? context) {
    if (this == InterfaceBrightness.light) return false;
    if (this == InterfaceBrightness.auto) {
      if (context == null) return true;
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }

    return true;
  }

  Color getForegroundColor(BuildContext? context) {
    return getIsDark(context) ? Colors.white : Colors.black;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WindowListener {
  // WindowEffect effect = WindowEffect.mica;

  // Color color =
  //     Platform.isWindows ? const Color(0xCC222222) : Colors.transparent;
  // InterfaceBrightness brightness =
  //     Platform.isMacOS ? InterfaceBrightness.auto : InterfaceBrightness.dark;
  // MacOSBlurViewState macOSBlurViewState =
  //     MacOSBlurViewState.followsWindowActiveState;

  @override
  void initState() {
    windowManager.addListener(this);
    initSystemTray();
    super.initState();
    setState(() {});
  }

  // void setWindowEffect(WindowEffect value) {
  //   Window.setEffect(
  //     effect: value,
  //     color: color,
  //     dark: brightness == InterfaceBrightness.dark,
  //   );
  //   if (Platform.isMacOS) {
  //     if (brightness != InterfaceBrightness.auto) {
  //       Window.overrideMacOSBrightness(
  //           dark: brightness == InterfaceBrightness.dark);
  //     }
  //   }
  //   setState(() => effect = value);
  // }

  Future<void> initSystemTray() async {
    String path = Platform.isWindows
        ? 'assets/images/app_icon.ico'
        : 'assets/images/app_icon.png';

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
        designSize: const Size(375, 600),
        builder: ((context, child) {
          ScreenUtil.init(context);
          // return GetMaterialApp(
          //   debugShowCheckedModeBanner: false,
          //   theme: AppTheme.fromType(AppTheme.defaultTheme).build(),
          //   initialRoute: AppPages.INITIAL,
          //   getPages: AppPages.routes,
          // );
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                visualDensity: VisualDensity.adaptivePlatformDensity,
                colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
                    .copyWith(background: Colors.transparent)),
            home: const Scaffold(
              backgroundColor: Color.fromARGB(105, 255, 255, 255),
              body: Center(
                child: Text("Hello"),
              ),
            ),
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
    await windowManager.minimize();
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

// import 'package:flutter/material.dart';
// import 'package:flutter_acrylic/flutter_acrylic.dart';
// import 'package:window_manager/window_manager.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await windowManager.ensureInitialized();
//   // await windowManager.hide();
//   await Window.initialize();
//   await Window.setEffect(
//     effect: WindowEffect.acrylic,
//     color: const Color.fromARGB(255, 255, 255, 255),
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//         title: 'Flutter Demo',
//         // theme: ThemeData(
//         //     visualDensity: VisualDensity.adaptivePlatformDensity,
//         //     colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
//         //         .copyWith(background: Colors.transparent)),
//         home: MyHomePage(title: 'Flutter Demo Home Page'));
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final int _counter = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       backgroundColor: const Color.fromARGB(105, 255, 255, 255),
//     );
//   }
// }
