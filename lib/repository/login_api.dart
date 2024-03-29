import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:ecom_demo/models/otpverify_model.dart';
import 'package:ecom_demo/resources/api_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/bester_login_model.dart';
import '../resources/helper.dart';

Future<BesterLoginModel> createLogin(
    {required String mobileNumber,
      required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['mobile'] = mobileNumber;
 // map['device_id'] =pref.getString('deviceId');
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

Future<BesterLoginModel> besterSignUp(
    {
      required String companyName,
      required String email,
      required String mobileNumber,
      required String name,
      required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['companyname'] = companyName;
  map['email'] = email;
  map['mobile'] = mobileNumber;
  map['name'] = name;
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
  http.Response response = await http.post(Uri.parse(ApiUrls.userSignUpApi),
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
