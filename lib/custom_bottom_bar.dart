import 'dart:convert';

import 'package:ecom_demo/screens/bester_homepage.dart';
import 'package:ecom_demo/screens/bester_profile_page.dart';
import 'package:ecom_demo/screens/emergency_alert_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'conttroller/alert_handle_controller.dart';
import 'conttroller/get_current_location.dart';
import 'conttroller/main_homecontroller.dart';
import 'models/otpverify_model.dart';

class MyNavigationBar extends StatefulWidget {
  MyNavigationBar ({key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar > {
  final controller = Get.put(MainHomeController());
  final alertHandlerController = Get.put(AlertHandleController());
  final locationController = Get.put(LocationController());


  @override
  void initState() {
    super.initState();
    alertHandlerController.getUserType();
    locationController.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return
    Obx((){
      return Scaffold(
          bottomNavigationBar: Obx(() {
            return
              BottomAppBar(
                  color: Colors.white,
                  shape: const CircularNotchedRectangle(),
                  clipBehavior: Clip.hardEdge,
                  elevation: 0,
                  child: Theme(
                      data: ThemeData(
                          splashColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          bottomNavigationBarTheme:
                          const BottomNavigationBarThemeData(backgroundColor: Colors.white, elevation: 1)),
                      child:
                      alertHandlerController.userType.value == "1" ?
                      BottomNavigationBar(
                        unselectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
                        selectedLabelStyle:
                        const TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.black),
                        items: [
                          BottomNavigationBarItem(
                            icon: GestureDetector(
                              onTap: () {
                                controller.onItemTap(0);
                              },
                              child:   Image.asset("assets/images/home.png",
                                height: 30,width: 30,
                                color: controller.currentIndex.value == 0 ?
                                const Color(0xffDB3022) :Colors.grey  ,),
                            ),
                            label: 'HOME',
                          ),
                          BottomNavigationBarItem(
                            icon: InkWell(
                              onTap: () async {
                                controller.onItemTap(1);
                                //print("VALLLUUU"+controller.onItemTap(1));
                              },
                              child:
                              Image.asset("assets/images/warning.png",
                                height: 30,width: 30,
                                color: controller.currentIndex.value == 1 ?
                                const Color(0xffDB3022) :Colors.grey  ,),
                            ),
                            label: 'ALERTS',
                          ),
                          BottomNavigationBarItem(
                            icon: InkWell(
                              onTap: () async {
                                controller.onItemTap(2);
                                //print("VALLLUUU"+controller.onItemTap(1));
                              },
                              child:  Image.asset("assets/images/user.png",
                                height: 30,width: 30,
                                color: controller.currentIndex.value == 2 ?
                                const Color(0xffDB3022) :Colors.grey  ,),
                            ),
                            label: 'PROFILE',
                          ),
                        ],
                        type: BottomNavigationBarType.fixed,
                        currentIndex: controller.currentIndex.value,
                        selectedItemColor: Color(0xffDB3022),
                        iconSize: 30,
                        onTap: controller.onItemTap,
                        elevation: 10,

                      ):
                      BottomNavigationBar(
                        unselectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
                        selectedLabelStyle:
                        const TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.black),
                        items: [
                          BottomNavigationBarItem(
                            icon: InkWell(
                              onTap: () async {
                                controller.onItemTap1(0);
                                //print("VALLLUUU"+controller.onItemTap(1));
                              },
                              child:
                              Image.asset("assets/images/warning.png",
                                height: 30,width: 30,
                                color: controller.adminIndex.value == 0 ?
                                const Color(0xffDB3022) :Colors.grey  ,),
                            ),
                            label: 'ALERTS',
                          ),
                          BottomNavigationBarItem(
                            icon: InkWell(
                              onTap: () async {
                                controller.onItemTap1(1);
                                //print("VALLLUUU"+controller.onItemTap(1));
                              },
                              child:  Image.asset("assets/images/user.png",
                                height: 30,width: 30,
                                color: controller.adminIndex.value == 1 ?
                                const Color(0xffDB3022) :Colors.grey  ,),
                            ),
                            label: 'PROFILE',
                          ),
                        ],
                        type: BottomNavigationBarType.fixed,
                        currentIndex: controller.adminIndex.value,
                        selectedItemColor: Color(0xffDB3022),
                        iconSize: 30,
                        onTap: controller.onItemTap1,
                        elevation: 10,

                      )
                  ));
          }),
          body:
          alertHandlerController.userType.value == "1" ?
          Center(
            child: Obx(() {
              return IndexedStack(
                index: controller.currentIndex.value,
                children: const [
                  BesterHomePage(),
                  EmergencyAlertPage(),
                  BesterProfilePage(),

                ],
              );
            }),
          ):Center(
            child: Obx(() {
              return IndexedStack(
                index: controller.adminIndex.value,
                children: const [
                  EmergencyAlertPage(),
                  BesterProfilePage(),

                ],
              );
            }),
          )
      );
    });

  }
}
