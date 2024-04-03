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
import '../models/update_token_model.dart';
import '../resources/helper.dart';

Future<OtpVerifyModel> otpVerifyRepo(
    {
      required String mobileNumber,
      required String otp,
      required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['mobile'] = mobileNumber;
  map['otp'] = otp;
  log(map.toString());

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  print('REQUEST ::${jsonEncode(map)}');
  http.Response response = await http.post(Uri.parse(ApiUrls.loginApi),
      body: jsonEncode(map), headers: headers);
  log("response.body....      ${response.body}");
  if (response.statusCode == 200 || response.statusCode == 400) {
    return OtpVerifyModel.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
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

// token
Future<UpdateToken> updateTokenRepo({
      required String fcmToken,
     }) async {
  var map = <String, dynamic>{};
  map['fcm'] = fcmToken;
  log(map.toString());

SharedPreferences pref = await SharedPreferences.getInstance();
OtpVerifyModel? user = OtpVerifyModel.fromJson(jsonDecode((pref.getString('user_info')!)));

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader:'Bearer ${user.success!.token}'
  };
  print('REQUEST ::${jsonEncode(map)}');
  http.Response response = await http.post(Uri.parse(ApiUrls.updateTokenUrl),
      body: jsonEncode(map), headers: headers);
  log("TOKEN response....      ${response.body}");
  if (response.statusCode == 200 || response.statusCode == 400) {
    return UpdateToken.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}