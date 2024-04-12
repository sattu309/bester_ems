import 'dart:developer';

import 'package:ecom_demo/push_notification/notifcation_service.dart';
import 'package:ecom_demo/resources/add_text.dart';
import 'package:ecom_demo/resources/app_theme.dart';
import 'package:ecom_demo/resources/dimension.dart';
import 'package:ecom_demo/screens/bester_homepage.dart';
import 'package:ecom_demo/screens/bester_profile_page.dart';
import 'package:ecom_demo/screens/emergency_alert_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'conttroller/alert_data_controller.dart';
import 'conttroller/alert_handle_controller.dart';
import 'conttroller/get_current_location.dart';
import 'conttroller/main_homecontroller.dart';
import 'login_flow/bester_login_page.dart';

String forSound = "";
class MyNavigationBar extends StatefulWidget {
  MyNavigationBar ({key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar > {
  final controller = Get.put(MainHomeController());
  final alertHandlerController = Get.put(AlertHandleController());
  final locationController = Get.put(LocationController());
  final emergencyDataController = Get.put(AlertDataController());
  manageNotification() async {
    print("function call");
    NotificationService().createNotificationChannel();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationService().showNotification(message );
      // Handle foreground messages
      print("Foreground message received: ${message.notification?.body}");
      if (message.data.isNotEmpty) {
        emergencyDataController.getEmergencyData();
       //forSound = message.data['sound'] ?? 'default';
       //  log("SOUND CHECK $forSound");
        log("Payload data: ${message.data}");
        log("Payload data: ${message.notification!.title.toString()}");
        log("Payload data: ${message.notification!.body.toString()}");
        showDialog(context: context, builder: (BuildContext context){
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    addHeight(10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/images/bester.png"),
                    ),
                    addHeight(10),
                    Text(message.notification!.title.toString().capitalizeFirst.toString(),
                        //textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 15, color: Color(0xff303C5E),
                            fontWeight: FontWeight.bold)),
                    addHeight(5),
                    Text(message.notification!.body.toString().capitalizeFirst.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black54,
                            fontWeight: FontWeight.w600)),

                    addHeight(30),
                    //Obx((){
                  //    return
                  Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          // color: AppTheme.buttonColor
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              emergencyDataController.getEmergencyData();
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize:
                              Size(AddSize.screenWidth, AddSize.size50 * 1.1),
                              backgroundColor: AppTheme.buttonColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8), // <-- Radius
                              ),
                              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("OK",
                                    style:  GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        letterSpacing: .5,
                                        fontSize: 15)),
                              ],
                            )),
                      ),
                    //}),
                    addHeight(5),
                  ],
                ),
              ),
            ),
          );
        });
        // Handle payload data here
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("App opened by notification: ${message.notification?.title}");
      print("App opened by notification: ${message.notification?.body}");
      // print("App opened by notification: ${message.data[].}");
      if (message.data.isNotEmpty) {
        forSound = message.data['sound'];
        final forNavigate = message.data['screen_name'];
        // print("Payload data: ${message.data['screen_name']}");
        // NotificationService.showNotification(message);
        if(forNavigate == "alerts"){
          Get.to(()=>const EmergencyAlertPage());
        }else{
          Get.to(()=>const BesterHomePage());
        }
      }else{
        print("BODY IS EMPTY");
      }
    });
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message!.data.isNotEmpty) {
        forSound = message.data['sound'];
        final forNavigate = message.data['screen_name'];
        if(forNavigate == "alerts"){
          Get.to(()=>const EmergencyAlertPage());
        }else{
          Get.to(()=>const BesterHomePage());
        }
      }else{
        print("BODY IS EMPTY");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    manageNotification();
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
