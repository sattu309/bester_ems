import 'package:ecom_demo/resources/add_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../conttroller/alert_handle_controller.dart';
import 'home_medical_emergency_page.dart';

class BesterHomePage extends StatefulWidget {
  const BesterHomePage({Key? key}) : super(key: key);

  @override
  State<BesterHomePage> createState() => _BesterHomePageState();
}

class _BesterHomePageState extends State<BesterHomePage> {
  final userDataController= Get.put(AlertHandleController());

  getFcmToken() async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    print("FCM TOKEN IS $fcmToken");
  }

  @override
  void initState() {
    super.initState();
    userDataController.getUserType();
    getFcmToken();

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
                    addHeight(20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/images/bester.png",),
                    ),
                    addHeight(15),
                    Obx((){
                      return Text("Hey ${userDataController.userName.value}",
                          style: GoogleFonts.poppins(fontSize: 16, color: Color(0xff191723), fontWeight: FontWeight.w600));
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
                          emsTypeSec: '', callback: null,));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
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
                              Image.asset("assets/images/medical_icon.png",height: 72,width: 60,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left:10),
                                  child: Text("Medical Emergency",
                                      style: GoogleFonts.poppins(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400)),
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
                          emsTypeSec: '', callback: null,));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
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
                              Image.asset("assets/images/motor_icon.png",height: 70,width: 60,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left:10),
                                  child: Text("Motor Accident/Town-in\n Service",
                                      style: GoogleFonts.poppins(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400)),
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
                          emsTypeSec: '', callback: null,));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
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
                              Image.asset("assets/images/injury_icon.png",height: 70,width: 60,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left:10),
                                  child: Text("Injured on Duty",
                                      style: GoogleFonts.poppins(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400)),
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_right, color: Colors.white,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    addHeight(10),
                    userDataController.showSec.value != "0" ?
                    GestureDetector(
                      onTap: (){
                        Get.to(()=>const MedicalEmergencyPage(
                          emsTypeMedical: '',
                          emsTypeInjury: '',
                          emsTypeMotor: '',
                          emsTypeSec: 'sec', callback: null,));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
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
                              Image.asset("assets/images/sec_icon.png",height: 70,width: 60,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left:10),
                                  child: Text("Security Emergency",
                                      // textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400)),
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
