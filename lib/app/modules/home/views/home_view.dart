import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tray_test1/app/utils/theme/appcolors.dart';
import 'package:tray_test1/app/utils/theme/theme.dart';
import 'package:tray_test1/app/widget/custom_button.dart';
import 'package:tray_test1/app/widget/custom_field.dart';

import '../controllers/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:window_manager/window_manager.dart';

ThemeData theme = AppTheme.fromType(AppTheme.defaultTheme).build();

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 233, 235, 254),
            appBar: AppBar(
              backgroundColor:
                  const Color.fromARGB(255, 233, 235, 254).withOpacity(0.9),
              iconTheme: const IconThemeData(color: Colors.black),
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () {
                    windowManager.hide();
                  },
                  icon: const Icon(Icons.remove),
                )
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  color: AppColors.borderGrey,
                  child: const TabBar(
                    labelColor: AppColors.primary,
                    indicatorColor: AppColors.primary,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(
                        child: Text(
                          'Pending',
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Approved',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TabBarView(
                children: [
                  Container(
                      height: 500.h,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      color: AppColors.borderGrey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "What are you working on?",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: const [
                                Text("Project Name: LMS System"),
                                Icon(Icons.edit_note_rounded)
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomField(
                              controller: controller.taskNameController,
                              label: "Enter Task Title",
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomField(
                                controller:
                                    controller.taskDescriptionController,
                                label: "Enter Task Description",
                                maxLength: 300,
                                maxline: 5),
                            SizedBox(
                              height: 10.h,
                            ),
                            const CustomDropDownField(
                              label: "Select Category",
                              items: ["Category 1", "Category 2", "Category 3"],
                              // isHaveSuffixIcon: true,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomButton(text: "START", tap: () {}),
                          ],
                        ),
                      )),
                  const Text('Tab 2'),
                ],
              ),
            )));
  }
}
