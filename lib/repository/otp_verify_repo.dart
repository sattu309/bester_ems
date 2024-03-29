import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:ecom_demo/resources/api_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/bester_login_model.dart';
import '../models/otpverify_model.dart';
import '../resources/helper.dart';

Future<OtpVerifyModel> otpVerifyRepo(
    {
      required String mobileNumber,
      required String otp,
      required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['mobile'] = mobileNumber;
  map['otp'] = otp;
  // map['device_id'] =pref.getString('deviceId');
  log(map.toString());


  // OverlayEntry loader = Helpers.overlayLoader(context);
  // Overlay.of(context)!.insert(loader);

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  print('REQUEST ::${jsonEncode(map)}');
  // log(pref.getString('deviceId')!);
  http.Response response = await http.post(Uri.parse(ApiUrls.loginApi),
      body: jsonEncode(map), headers: headers);
  log("response.body....      ${response.body}");
  if (response.statusCode == 200 || response.statusCode == 400) {
    // Helpers.hideLoader(loader);
    return OtpVerifyModel.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
    // Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}


// resend otp
Future<BesterLoginModel> resendOtpRepo(
    {
      required String mobileNumber,
      required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['mobile'] = mobileNumber;
  log(map.toString());


  // OverlayEntry loader = Helpers.overlayLoader(context);
  // Overlay.of(context)!.insert(loader);

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  print('REQUEST ::${jsonEncode(map)}');
  // log(pref.getString('deviceId')!);
  http.Response response = await http.post(Uri.parse(ApiUrls.loginApi),
      body: jsonEncode(map), headers: headers);
  log("response.body....      ${response.body}");
  if (response.statusCode == 200 || response.statusCode == 400) {
    // Helpers.hideLoader(loader);
    return BesterLoginModel.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
    // Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}