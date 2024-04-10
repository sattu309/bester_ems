import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:ecom_demo/resources/api_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/bester_login_model.dart';
import '../models/emergency_alert_model.dart';
import '../models/get_active_alert_model.dart';
import '../models/otpverify_model.dart';
import '../models/send_alert_mode.dart';
import '../models/send_eta_model.dart';
import '../resources/helper.dart';

Future<SendAlertModel> sendAlertRepo(
    {
      required String userLat,
      required String userLong,
      required String emerType,
      required String userAddress,
      required String alertStatus,
      required String alertID,
      required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['latitude'] = userLat;
  map['longitude'] = userLong;
  map['emstype'] = emerType;
  map['address'] = userAddress;
  map['alertstatus'] = alertStatus;
  map['alertID'] = alertID;
  log(map.toString());
  SharedPreferences pref = await SharedPreferences.getInstance();
  OtpVerifyModel? user =
  OtpVerifyModel.fromJson(jsonDecode(pref.getString('user_info')!));


  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: "Bearer ${user.success!.token}"
  };
  print('REQUEST ::${jsonEncode(map)}');
  // log(pref.getString('deviceId')!);
  http.Response response = await http.post(Uri.parse(ApiUrls.sendEmergencyAlertApi),
      body: jsonEncode(map), headers: headers);
  log("response.body....      ${response.body}");
  if (response.statusCode == 200 || response.statusCode == 400) {
    // Helpers.hideLoader(loader);
    return SendAlertModel.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
    // Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}


// send eta
Future<SendEtaModel> sendEtaTimeRepo(
    {
      required String emsType,
      required String etaTime,
      required String alertStatus,
      required String alertId,
      required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['emstype'] = emsType;
  map['eta'] = etaTime;
  map['alertstatus'] = alertStatus;
  map['alertID'] = alertId;
  log(map.toString());
  SharedPreferences pref = await SharedPreferences.getInstance();
  OtpVerifyModel? user =
  OtpVerifyModel.fromJson(jsonDecode(pref.getString('user_info')!));


  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: "Bearer ${user.success!.token}"
  };
  print('REQUEST ::${jsonEncode(map)}');
  // log(pref.getString('deviceId')!);
  http.Response response = await http.post(Uri.parse(ApiUrls.sendEtaApiUrl),
      body: jsonEncode(map), headers: headers);
  log("ETA response.body....      ${response.body}");
  if (response.statusCode == 200 || response.statusCode == 400) {
    // Helpers.hideLoader(loader);
    return SendEtaModel.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
    // Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}

// get alert data

Future<EmergencyAlertsModel> getEmergencyAlertRepo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  OtpVerifyModel? user =
  OtpVerifyModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.success!.token}'
  };
  http.Response response =
  await http.get(Uri.parse(ApiUrls.emergencyAlertApi), headers: headers);

  if (response.statusCode == 200) {
    print("EMERGENCY ALERT REPO ...${response.body}");
    return EmergencyAlertsModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}



