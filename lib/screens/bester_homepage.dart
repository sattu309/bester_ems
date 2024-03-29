
import 'dart:convert';

import 'package:ecom_demo/models/otpverify_model.dart';
import 'package:ecom_demo/resources/add_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../push_notification/notifcation_service.dart';
import 'home_medical_emergency_page.dart';

class BesterHomePage extends StatefulWidget {
  const BesterHomePage({Key? key}) : super(key: key);

  @override
  State<BesterHomePage> createState() => _BesterHomePageState();
}

class _BesterHomePageState extends State<BesterHomePage> {

  getFcmToken() async {
    var fcmToekn = await FirebaseMessaging.instance.getToken();
    print("FCM TOEKN IS ${fcmToekn}");
  }

  // getInit() async{
  //   RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  //   log("Kill messgae ${initialMessage.toString()}");
  //   // if(initialMessage != null && initialMessage.notification != null){
  //   //   NotificationOnClickModel groupModal = NotificationOnClickModel.fromJson(jsonDecode(initialMessage.data["payload"]));
  //   //
  //   //   if(groupModal.screenType== 'chat'){
  //   //     Get.toNamed(OrderDetails.route, arguments: [groupModal.orderId.toString()]);
  //   //   } else if(groupModal.screenType== 'post_or_product_update'){
  //   //     if (groupModal.isAnother == true) {
  //   //       makingPhoneCall(groupModal.pLink.toString());
  //   //     }else{
  //   //       if(groupModal.isProduct == true ) {
  //   //         Get.toNamed(SingleProductScreen.route, arguments: [groupModal.pId.toString()]);
  //   //       }else{
  //   //         makingPhoneCall(groupModal.pLink.toString());
  //   //       }
  //   //     }
  //   //   }else {
  //   //   }
  //   // }
  // }
  RxString userName ="".obs;
  RxString showSec ="".obs;

  getUserInfo() async {
    SharedPreferences pref= await SharedPreferences.getInstance();
    OtpVerifyModel? user=
    OtpVerifyModel.fromJson(jsonDecode(pref.getString("user_info")!));
    userName.value= user.success!.name.toString();
    showSec.value= user.success!.showsec.toString();
}
  manageNotification() async {
    print("functionnnnn callll");
    // getInit();
    NotificationService.createNotificationChannel();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});


  }
  @override
  void initState() {
    super.initState();
    getUserInfo();
    getFcmToken();
    manageNotification();

  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body:
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Obx((){
                return
                Column(
                  children: [
                    addHeight(10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/images/bester.png",),
                    ),
                    addHeight(15),
                    Obx((){
                      return Text("Hey $userName",
                          style: GoogleFonts.poppins(fontSize: 15, color: Color(0xff191723), fontWeight: FontWeight.w600));
                    }),

                    //textAlign: TextAlign.center,
                    addHeight(3),
                    const Text("We're here for you",
                        //textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400)),
                    addHeight(10),
                    GestureDetector(
                      onTap: (){
                        Get.to(()=>const MedicalEmergencyPage(
                          emsTypeMedical: 'medical',
                          emsTypeInjury: '',
                          emsTypeMotor: '',
                          emsTypeSec: '',));
                      },
                      child: Container(
                        decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage("assets/images/medicalbg.png",),
                              fit: BoxFit.fitWidth,
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/images/medical_icon.png",height: 70,width: 55,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left:10),
                                  child: Text("Medical Emergency",
                                      style: GoogleFonts.poppins(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400)),
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_right, color: Colors.white,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    addHeight(10),
                    GestureDetector(
                      onTap: (){
                        Get.to(()=>const MedicalEmergencyPage(
                          emsTypeMedical: '',
                          emsTypeInjury: '',
                          emsTypeMotor: 'motor',
                          emsTypeSec: '',));
                      },
                      child: Container(
                        decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage("assets/images/motorbg.png",),
                              fit: BoxFit.fitWidth,
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/images/motor_icon.png",height: 70,width: 55,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left:10),
                                  child: Text("Motor Accident/Town-in\n Service",
                                      style: GoogleFonts.poppins(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400)),
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_right, color: Colors.white,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    addHeight(10),
                    GestureDetector(
                      onTap: (){
                        Get.to(()=>const MedicalEmergencyPage(
                          emsTypeMedical: '',
                          emsTypeInjury: 'injury',
                          emsTypeMotor: '',
                          emsTypeSec: '',));
                      },
                      child: Container(
                        decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage("assets/images/injurybg.png",),
                              fit: BoxFit.fitWidth,
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Image.asset("assets/images/injury_icon.png",height: 70,width: 55,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left:10),
                                  child: Text("Injured on Duty",
                                      style: GoogleFonts.poppins(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400)),
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_right, color: Colors.white,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    addHeight(10),
                    showSec.value != "0" ?
                    GestureDetector(
                      onTap: (){
                        Get.to(()=>const MedicalEmergencyPage(
                          emsTypeMedical: '',
                          emsTypeInjury: '',
                          emsTypeMotor: '',
                          emsTypeSec: 'sec',));
                      },
                      child: Container(
                        decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage("assets/images/secbg.png",),
                              fit: BoxFit.fitWidth,
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/images/sec_icon.png",height: 70,width: 55,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left:10),
                                  child: Text("Security Emergency",
                                      // textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400)),
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_right, color: Colors.white,),
                            ],
                          ),
                        ),
                      ),
                    ):const SizedBox(),
                  ],
                );
              }),

        ),
      ),
    );
  }
}
