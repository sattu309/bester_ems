import 'dart:convert';

import 'package:ecom_demo/common_repository/api_repository.dart';
import 'package:ecom_demo/resources/add_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/services_model.dart';
import '../resources/api_urls.dart';
import '../resources/app_theme.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  Repositories repositories =Repositories();
  ServicesModel? servicesModel;
  getServiceData(){
    repositories.getApi(url: ApiUrls.serviceUrl).then((value){
      servicesModel = ServicesModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    getServiceData();
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
      servicesModel != null ?
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
        borderRadius: BorderRadius.circular(20),
                child: Image.asset("assets/images/servicesbanner.png")),
            addHeight(20),
            Padding(
              padding: const EdgeInsets.only(left: 7),
              child: Text("Services",
                  style: GoogleFonts.poppins(fontSize: 18, color: Color(0xff191723), fontWeight: FontWeight.w600)),
            ),
            addHeight(15),
            ListView.builder(
              shrinkWrap: true,
              itemCount: servicesModel!.success!.length,
          itemBuilder: (BuildContext, index){
            return  Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 7,
                    width: 7,
                    decoration: const BoxDecoration(
                      color:AppTheme.buttonColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  addWidth(10),
                  Expanded(
                    child: Text(servicesModel!.success![index].toString(),
                        style: GoogleFonts.poppins(fontSize: 15,
                            color: Color(0xff191723).withOpacity(.80), fontWeight: FontWeight.w500)),
                  ),

                ],
              ),
            );
          }),
          ],
        ),
      ):const Center(child: CircularProgressIndicator(
        color: AppTheme.buttonColor,),),
    );
  }
}
