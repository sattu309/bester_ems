import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:ecom_demo/resources/api_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/bester_login_model.dart';
import '../models/otpverify_model.dart';
import '../models/send_alert_mode.dart';
import '../resources/helper.dart';

Future<SendAlertModel> sendAlertRepo(
    {
      required String userLat,
      required String userLong,
      required String emerType,
      required String userAddress,
      required String alertStatus,
      required String alertId,
      required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['latitude'] = userLat;
  map['longitude'] = userLong;
  map['emstype'] = emerType;
  map['address'] = userAddress;
  map['alertstatus'] = alertStatus;
  map['alertId'] = alertId;
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

