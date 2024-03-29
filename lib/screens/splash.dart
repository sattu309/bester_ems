import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custom_bottom_bar.dart';
import '../login_flow/bester_login_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  userCheck() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('user_info') != null) {
     Get.offAll(()=>MyNavigationBar());
    }
    else{
      Get.offAll(()=>const BesterLoginPage());
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3 ), ()async{
      Get.off(()=>const BesterLoginPage());
      userCheck();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:  Colors.transparent,
      body:
      Container(child:
      Image.asset("assets/images/splash.png",fit: BoxFit.fill))
    );
  }
}
