import 'package:ecom_demo/resources/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/add_text.dart';

class BesterContactUsPage extends StatefulWidget {
  const BesterContactUsPage({Key? key}) : super(key: key);

  @override
  State<BesterContactUsPage> createState() => _BesterContactUsPageState();
}

class _BesterContactUsPageState extends State<BesterContactUsPage> {
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/bester.png", height: 150,width: 150,),
           userInfo(
               iconData: Icons.call,
               title: "95348534348"),
            addHeight(5),
            const Divider(
              height: 1,
              thickness: 1.5,
            ),
            userInfo(
                iconData: Icons.mail,
                title: "demo@gmail.com"),
            addHeight(5),
            const Divider(
              height: 1,
              thickness: 1.5,
            ),
            userInfo(
                iconData: Icons.location_on,
                title: "H 23 Swaj farm Near Hub"),
            addHeight(5),
            const Divider(
              height: 1,
              thickness: 1.5,
            ),
            userInfo(
                iconData: Icons.wordpress,
                title: "https://www.besterems.co.za"),
            addHeight(5),
            const Divider(
              height: 1,
              thickness: 1.5,
            ),
            addHeight(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Image.asset("assets/images/whatsapp.png",
                height: 20,width: 20, color: AppTheme.buttonColor,),
              addWidth(2),
              Image.asset("assets/images/fb.png",height: 16,width: 20,color: AppTheme.buttonColor),
                addWidth(2),
                Image.asset("assets/images/logo-tiktok.png",height: 16,width: 20,color: AppTheme.buttonColor),
              ],
            ),
            addHeight(35),
            Text(
              "App Version: 1.0.11",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500, fontWeight: FontWeight.w500),
            ),
           addHeight(20),
            Image.asset("assets/images/bitlogiq.png",
               height: 50,width: 140,
            ),
            Text(
              "https://www.besterems.co.za",
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(iconData, size: iconSize, color: iconColor),
          const SizedBox(width: 8),
          Expanded(
            child:
            Text(
              title,
              style: TextStyle(fontSize: 14, color: textColor, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

}
