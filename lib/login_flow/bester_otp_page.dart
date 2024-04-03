import 'dart:async';
import 'dart:convert';
import 'package:ecom_demo/resources/add_text.dart';
import 'package:ecom_demo/custom_bottom_bar.dart';
import 'package:ecom_demo/resources/helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../resources/common_button.dart';
import '../repository/otp_verify_repo.dart';

class BesterOtpPage extends StatefulWidget {
  final String mobileNumber;
  const BesterOtpPage({super.key, required this.mobileNumber});

  @override
  State<BesterOtpPage> createState() => _BesterOtpPageState();
}

class _BesterOtpPageState extends State<BesterOtpPage> {
  final otpController = TextEditingController();
  late Timer timer;
  RxInt timerSeconds = 30.obs;
  RxBool showTimer = false.obs;
  setTimer() {
    if (showTimer.value == false) {
      showTimer.value = true;
      timer = Timer.periodic(const Duration(seconds: 1), (value) {
        if (timerSeconds.value > 1) {
          timerSeconds.value--;
        } else {
          showTimer.value = false;
          timer.cancel();
          timerSeconds.value = 30;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setTimer();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/screenbg.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    addHeight(height * .25),
                    Center(
                        child: Image.asset(
                      "assets/images/bester.png",
                      height: 100,
                    )),
                    addHeight(30),
                  ],
                ),
              ),
              Positioned(
                  bottom: 20,
                  left: 20,
                  child: Container(
                      // height: height* .5,
                      width: width * .89,
                      //padding: EdgeInsets.symmetric(horizontal: 35,vertical: 7),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(
                              1,
                              1,
                            ),
                            // blurRadius: 1.0,
                            //spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            addHeight(height * .02),
                            const Text("Enter Verification Code",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            addHeight(10),
                            Text("Otp has been sent to ${widget.mobileNumber}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400)),
                            addHeight(20),
                            PinCodeTextField(
                              mainAxisAlignment: MainAxisAlignment.center,
                              appContext: context,
                              textStyle: const TextStyle(color: Colors.grey),
                              controller: otpController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              pastedTextStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              animationType: AnimationType.fade,
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return "                                  OTP code Required";
                                } else if (v.length != 4) {
                                  return "                         Enter complete OTP code";
                                }
                                return null;
                              },
                              length: 4,
                              pinTheme: PinTheme(
                                fieldOuterPadding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(10),
                                fieldWidth: 45,
                                fieldHeight: 40,
                                activeFillColor: Colors.black26,
                                inactiveColor: Colors.black26,
                                inactiveFillColor: Colors.black26,
                                selectedFillColor: Color(0xffDB3022),
                                selectedColor: Colors.black26,
                                activeColor: Colors.black26,
                              ),
                              cursorColor: Colors.black26,
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                setState(() {
                                  // currentText = v;
                                });
                              },
                            ),
                            addHeight(10),
                            GestureDetector(
                              onTap: () {
                                if (showTimer.value == false) {
                                  resendOtpRepo(
                                          mobileNumber: widget.mobileNumber,
                                          context: context)
                                      .then((value) {
                                    if (value.success != null) {
                                      Helpers.showToast(
                                          value.success.toString());
                                      setTimer();
                                    } else {
                                      Helpers.showToast(value.error.toString());
                                    }
                                    return;
                                  });
                                }
                              },
                              child:
                                  Obx((){
                                    return  Text(
                                        !showTimer.value
                                            ? "Resend OTP"
                                            : "Resend OTP in 00:${timerSeconds.value > 9 ?
                                        timerSeconds.value : "0${timerSeconds.value}"}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            decoration: TextDecoration.underline,
                                            fontSize: 15,
                                            color: Color(0xffDB3022),
                                            fontWeight: FontWeight.w400));
                                  })

                            ),
                            addHeight(18),
                            CommonButtonGreen1(
                              title: 'CONFIRM OTP',
                              onPressed: () async {
                                var fcmToekn =
                                    await FirebaseMessaging.instance.getToken();
                                if(otpController.text!.isNotEmpty){
                                  otpVerifyRepo(
                                      mobileNumber: widget.mobileNumber,
                                      otp: otpController.text, context: context,
                                      )
                                      .then((value) async {
                                    if (value.success != null) {
                                      SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                      pref.setString(
                                          "user_info", jsonEncode(value));
                                      Helpers.showToast("Login successful");
                                      updateTokenRepo(
                                        fcmToken: fcmToekn!,
                                      );
                                      Get.off(() => MyNavigationBar());
                                    } else {
                                      Helpers.showToast(
                                          "Please Enter the Valid OTP");
                                    }
                                  });
                                }else{
                                  Helpers.showToast("Please Enter the OTP");
                                }

                              },
                            ),
                            addHeight(height * .05),
                          ],
                        ),
                      ))),
            ],
          ),
        ));
  }
}
