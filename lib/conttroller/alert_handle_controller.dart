import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/localData_model.dart';
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
  RxString eType = "".obs;
  RxString status = "".obs;
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
    log("USER TYPE $userType");
    log("USER ID $userId");
  }



  getDataLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LocalDataModel? jsonData = LocalDataModel.fromJson(jsonDecode(prefs.getString("data")!));
    status.value = jsonData.reqStatus.toString();
    eType.value = jsonData.eType.toString();
    log("LOCAL STATUS ${status.value.toString()}");
    log("TYPE ${eType.value.toString()}");
  }
  clearDataLocally() async {
    status.value = "";
    eType.value = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("data");
    log("Data removed from local storage");
  }

  @override
  void onInit() {
    super.onInit();
    getUserType();
  }
}
