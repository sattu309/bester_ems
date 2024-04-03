import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/otpverify_model.dart';

class AlertHandleController extends GetxController {
  RxString userType = "".obs;
  RxString userId = "".obs;
  RxString userName ="".obs;
  RxString showSec ="".obs;
  RxString email ="".obs;
  RxString companyName ="".obs;
  RxString userAppName ="".obs;
  RxString userToken ="".obs;
  RxString mobile ="".obs;
  getUserType() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    OtpVerifyModel? user =
    OtpVerifyModel.fromJson(jsonDecode(pref.getString("user_info")!));
    userType.value = user.success!.utype.toString();
    userId.value = user.success!.id.toString();
    userName.value= user.success!.name.toString();
    showSec.value= user.success!.showsec.toString();
    email.value= user.success!.email.toString();
    companyName.value= user.success!.companyname.toString();
    userAppName.value= user.success!.aPPNAME.toString();
    userToken.value= user.success!.token.toString();
    mobile.value= user.success!.mobile.toString();
    log("USER TYPE $userType.value.toString()");
    log("USER ID $userId.value.toString()");
  }

  @override
  void onInit() {
    super.onInit();
    getUserType();
    // print("result11111");
  }
}
