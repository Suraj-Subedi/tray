import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:system_tray/system_tray.dart';
import 'package:window_manager/window_manager.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();
  await windowManager.hide();

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  LaunchAtStartup.instance.setup(
    appName: packageInfo.appName,
    appPath: Platform.resolvedExecutable,
  );
  await LaunchAtStartup.instance.enable();

  var initialSize = const Size(330, 650);
  WindowOptions windowOptions = WindowOptions(
    size: initialSize,
    // maximumSize: initialSize,
    // minimumSize: initialSize,
    backgroundColor: Colors.transparent,
    skipTaskbar: true,

    titleBarStyle: TitleBarStyle.hidden,
    // titleBarStyle: TitleBarStyle.hidden,
  );

  await windowManager.waitUntilReadyToShow(
    windowOptions,
    () async {
      await windowManager.setAlignment(Alignment.bottomRight);
      await windowManager.show();
    },
  );

  await localNotifier.setup(
    appName: 'Log Tracker',
    shortcutPolicy: ShortcutPolicy.requireCreate,
  );

  runApp(
    MaterialApp(
      color: Colors.white.withOpacity(0),
      debugShowCheckedModeBanner: false,
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
    with WindowListener, SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  );

  late final Animation<Offset> _animation = Tween<Offset>(
          begin: const Offset(0, 1), end: Offset.zero)
      .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  bool _isVisible = true;
  bool _isClickTriggered = false;
  double height = 10;

  @override
  void initState() {
    windowManager.addListener(this);
    initSystemTray();
    super.initState();
    setState(() {});
    _controller.forward();
  }

  Future<void> initSystemTray() async {
    String path =
        Platform.isWindows ? 'assets/app_icon.ico' : 'assets/app_icon.png';

    final SystemTray systemTray = SystemTray();

    // We first init the systray menu
    await systemTray.initSystemTray(
      title: "system tray",
      iconPath: path,
    );

    setState(() {
      height = 1000;
    });

    // create context menu
    final Menu menu = Menu();
    await menu.buildFrom([
      MenuItemLabel(
          label: 'Show', onClicked: (menuItem) => windowManager.show()),
      MenuItemLabel(
          label: 'Hide', onClicked: (menuItem) => windowManager.hide()),
      MenuItemLabel(
          label: 'Exit', onClicked: (menuItem) => windowManager.close()),
    ]);

    // set context menu
    await systemTray.setContextMenu(menu);

    systemTray.registerSystemTrayEventHandler((eventName) async {
      debugPrint("eventName: $eventName");
      if (eventName == kSystemTrayEventClick) {
        setState(() {
          _isClickTriggered = true;
          _isVisible = !_isVisible;
        });

        if (_isVisible) {
          await windowManager.show();
          _controller.forward();
        } else {
          _controller.reverse();
          await windowManager.hide();
        }
      }

      if (eventName == kSystemTrayEventRightClick) {
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
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(color: Colors.blue),
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   centerTitle: true,
      //   title: const Text(
      //     'Add new Log',
      //     style: TextStyle(color: Colors.blue),
      //   ),
      //   actions: [
      //     IconButton(
      //       onPressed: () async {
      //         await windowManager.hide();
      //       },
      //       icon: const Icon(Icons.remove),
      //     )
      //   ],
      // ),
      body: SingleChildScrollView(
        child: SlideTransition(
          position: _animation,
          child: Flexible(
            fit: FlexFit.tight,
            child: Container(
              height: 1000,
              color: Colors.white,
              child: Form(
                  child: Column(
                children: [
                  AppBar(),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Expanded(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Title',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            textAlignVertical: TextAlignVertical.top,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              labelText: 'Description',
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CalendarDatePicker(
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2050),
                              onDateChanged: (newDate) {}),
                          ElevatedButton(
                            onPressed: () {},
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 50),
                                child: const Text('Add')),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/app_icon.ico'),
              ),
              const Text(
                'Suraj Subedi',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                onTap: () {},
                title: const Text('Add new Log'),
              ),
              ListTile(
                onTap: () {},
                title: const Text('View Logs'),
              ),
              ListTile(
                onTap: () {},
                title: const Text('Settings'),
              ),
              ListTile(
                onTap: () {},
                title: const Text('About'),
              ),
              ListTile(
                onTap: () {},
                title: const Text('Log Out'),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     LocalNotification localNotification = LocalNotification(
      //         title: 'Log Tracker',
      //         body: 'Hello Flutter!',
      //         actions: [
      //           LocalNotificationAction(
      //             type: 'button',
      //             text: 'Open',
      //           ),
      //         ]);

      //     localNotification.onShow = () {
      //       print('onShow ${localNotification.identifier}');
      //     };

      //     localNotification.onClose = (reason) {
      //       print('onClose ${localNotification.identifier}');
      //     };
      //     await Future.delayed(const Duration(seconds: 10));

      //     await localNotification.show();
      //   },
      //   child: const Icon(Icons.notification_add),
      // ),
    );
  }

  @override
  Future<void> onWindowEvent(String eventName) async {
    switch (eventName) {
      
    }
  }

  @override
  void onWindowClose() {}

  @override
  void onWindowFocus() async {}

  @override
  void onWindowBlur() async {
    // Timer(const Duration(milliseconds: 50), () {
    //   if (!_isClickTriggered && _isVisible) {
    //     // Perform hide actions here

    //     windowManager.hide();

    //     setState(() {
    //       _isVisible = false;
    //     });
    //   }
    //   setState(() {
    //     _isClickTriggered = false;
    //   });
    // });
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
