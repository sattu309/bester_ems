import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/otpverify_model.dart';

class AlertHandleController extends GetxController {
  RxString userType = "".obs;
  RxString userId = "".obs;
  getUserType() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    OtpVerifyModel? user =
    OtpVerifyModel.fromJson(jsonDecode(pref.getString("user_info")!));
    userType.value = user.success!.utype.toString();
    userId.value = user.success!.id.toString();
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
