import 'dart:convert';

import 'package:ecom_demo/common_repository/api_repository.dart';
import 'package:ecom_demo/resources/add_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/aboutus_model.dart';
import '../resources/api_urls.dart';
import '../resources/app_theme.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  Repositories repositories =Repositories();
  AboutUsModel? aboutUsModel;
  getAboutUsData(){
    repositories.getApi(url: ApiUrls.aboutUsApiUrl).then((value){
      aboutUsModel = AboutUsModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    getAboutUsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body:
          aboutUsModel != null ?
      Padding(
        padding: const EdgeInsets.all(17.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("About Us",
                style: GoogleFonts.poppins(fontSize: 17, color: Color(0xff191723), fontWeight: FontWeight.w600)),
           addHeight(15),
            Text(aboutUsModel!.success.toString().replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' '),

                style: GoogleFonts.poppins(fontSize: 15, color: Color(0xff191723).withOpacity(.50), fontWeight: FontWeight.w600)),
          ],
        ),
      ):const Center(child: CircularProgressIndicator(
            color: AppTheme.buttonColor,),),
    );
  }
}
