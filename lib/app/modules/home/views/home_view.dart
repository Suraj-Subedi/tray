import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                leading: const Icon(Icons.settings),
                iconTheme: const IconThemeData(color: Colors.white),
                elevation: 0,
                backgroundColor: Colors.transparent,
                actions: [
                  IconButton(
                    onPressed: () {
                      windowManager.minimize();
                    },
                    icon: const Icon(Icons.remove),
                  )
                ],
                bottom: const TabBar(
                  // isScrollable: true,
                  tabs: [
                    Tab(text: "Active"),
                    Tab(text: "Completed"),
                  ],
                )),
            body: TabBarView(children: [
              Container(
                  child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "What are you working on?",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              )),
              Container(
                child: const Center(
                  child: Text("Tab 2"),
                ),
              ),
            ])));
  }
}
