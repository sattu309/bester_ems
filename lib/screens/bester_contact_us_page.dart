import 'dart:convert';

import 'package:ecom_demo/common_repository/api_repository.dart';
import 'package:ecom_demo/resources/api_urls.dart';
import 'package:ecom_demo/resources/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/supprt_model.dart';
import '../resources/add_text.dart';

class BesterContactUsPage extends StatefulWidget {
  const BesterContactUsPage({Key? key}) : super(key: key);

  @override
  State<BesterContactUsPage> createState() => _BesterContactUsPageState();
}

class _BesterContactUsPageState extends State<BesterContactUsPage> {

  Repositories repositories = Repositories();
  SupportModel? supportModel;
  getSupportData(){
    repositories.getApi(url: ApiUrls.supportUrl).then((value){
      supportModel= SupportModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  makingPhoneCall(call) async {
    var url = Uri.parse(call);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> shareOnWhatsApp(String phone) async {
    String formattedPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
    if (!formattedPhone.startsWith('+')) {
      formattedPhone = '+91$formattedPhone';
    }

    var whatsappUrl = "whatsapp://send?phone=$formattedPhone";
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      var whatsappWebUrl = "https://wa.me/$formattedPhone";
      if (await canLaunch(whatsappWebUrl)) {
        await launch(whatsappWebUrl);
      } else {
        throw 'Could not launch WhatsApp.';
      }
    }
  }


  void sendEmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: supportModel!.success!.email.toString(),
      query: 'subject=Hello%20from%20Flutter',
    );
    await launch(params.toString());
  }


@override
  void initState() {
    super.initState();
    getSupportData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
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
      body: supportModel != null ?
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/bester.png", height: 150,width: 150,),
           addHeight(30),
           GestureDetector(
             onTap: (){
               makingPhoneCall("tel:+91${supportModel!.success!.phone.toString()}");
             },
             child: userInfo(
                 iconData: Icons.call,
                 title: supportModel!.success!.phone.toString()),
           ),
            addHeight(5),
            const Divider(
              height: 1,
              thickness: 1.5,
            ),
            GestureDetector(
              onTap: (){
                print("hey man");
                sendEmail();
              },
              child: userInfo(
                  iconData: Icons.mail,
                  title: supportModel!.success!.email.toString()),
            ),
            addHeight(5),
            const Divider(
              height: 1,
              thickness: 1.5,
            ),
            userInfo(
                iconData: Icons.location_on,
                title: supportModel!.success!.address.toString()),
            addHeight(5),
            const Divider(
              height: 1,
              thickness: 1.5,
            ),
            GestureDetector(
              onTap: (){
                makingPhoneCall(supportModel!.success!.web.toString());
              },
              child: userInfo(
                  iconData: Icons.wordpress,
                  title: supportModel!.success!.web.toString()),
            ),
            addHeight(5),
            const Divider(
              height: 1,
              thickness: 1.5,
            ),
            addHeight(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              GestureDetector(
                onTap: (){
                  shareOnWhatsApp(supportModel!.success!.phone.toString());
                },
                child: Image.asset("assets/images/whatsapp.png",
                  height: 22,width: 22, color: AppTheme.buttonColor,),
              ),
              addWidth(5),
              Image.asset("assets/images/fb.png",height: 20,width: 20,color: AppTheme.buttonColor),
                addWidth(5),
                Image.asset("assets/images/logo-tiktok.png",height: 20,width: 20,color: AppTheme.buttonColor),
              ],
            ),
            addHeight(50),
            Text(
              "App Version: 1.0.11",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500, fontWeight: FontWeight.w500),
            ),
           addHeight(20),
            Image.asset("assets/images/bitlogiq.png",
               height: 55,width: 140,
            ),
            Text(
              supportModel!.success!.web.toString(),
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ):const Center(child: CircularProgressIndicator(color: AppTheme.buttonColor,),)
    );
  }
  

  Widget userInfo({required IconData iconData,
    required String title,
    double iconSize = 20.0,
    Color iconColor = AppTheme.buttonColor,
    Color textColor = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(iconData, size: iconSize, color: iconColor),
          const SizedBox(width: 8),
          Expanded(
            child:
            Text(
              title,
              style: TextStyle(fontSize: 15, color: textColor, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

}
