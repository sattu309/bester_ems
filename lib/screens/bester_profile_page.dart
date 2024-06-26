import 'package:ecom_demo/resources/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../conttroller/alert_handle_controller.dart';
import '../resources/add_text.dart';
import '../common_repository/api_repository.dart';
import 'bester_aboutUs_page.dart';
import 'bester_contact_us_page.dart';
import 'bester_service_page.dart';

class BesterProfilePage extends StatefulWidget {
  const BesterProfilePage({Key? key}) : super(key: key);

  @override
  State<BesterProfilePage> createState() => _BesterProfilePageState();
}

class _BesterProfilePageState extends State<BesterProfilePage> {
  final userDataController = Get.put(AlertHandleController());
  Repositories repositories = Repositories();
  @override
  void initState() {
    super.initState();
    userDataController.getUserType();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Scaffold(
      //backgroundColor: Color(0xffFFFFFF),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 30,vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                addHeight(height* .1),
                Image.asset("assets/images/bester.png", height: 100,),
                addHeight(10),
                Text(
                    userDataController.userName.value.toString(),
                    //textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 16, color:  Color(0xffDB3022), fontWeight: FontWeight.w600)),
                addHeight(7),
             userInfo(),
                addHeight(5),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 const Icon(Icons.mail),
                 addWidth(6),
                 Flexible(
                   child: Text(
                       userDataController.email.value.toString(),

                       //textAlign: TextAlign.center,
                       style: GoogleFonts.poppins(fontSize: 14, color:  const Color(0xff191723), fontWeight: FontWeight.w500)),
                 ),
               ],
             ),
                addHeight(5),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 const Icon(Icons.dashboard),
                 addWidth(6),
                 Text(
                   userDataController.companyName.value == "" ?
                     userDataController.companyName.value.toString() : "Ssspl",
                     //textAlign: TextAlign.center,
                     style: GoogleFonts.poppins(fontSize: 14, color:  Color(0xff191723), fontWeight: FontWeight.w500)),
               ],
             ),
                addHeight(20),
                const Divider(
                  height: 2,
                  thickness: 1,
                ),

              ],
            ),
            addHeight(30),
            GestureDetector(
              onTap: (){
                Get.to(()=>const BesterContactUsPage());
              },
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.help_outline_outlined,
                    color: Color(0xffDB3022),),
                  addWidth(20),
                  Text("HELP & SUPPORT",
                      //textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(fontSize: 16, color:
                      const Color(0xff6F7183), fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            addHeight(30),
            GestureDetector(
              onTap: (){
                Get.to(()=>const ServicePage());
              },
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/briefcase.png",height: 23,width: 23, color: AppTheme.buttonColor,),
                  addWidth(20),
                  Text("SERVICES",
                      //textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(fontSize: 16, color:
                      const Color(0xff6F7183), fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            addHeight(30),
            GestureDetector(
              onTap: (){
                Get.to(()=>const AboutUsPage());
              },
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.account_circle_outlined,color: Color(0xffDB3022),),
                  addWidth(20),
                  Text("ABOUT",
                      //textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(fontSize: 16,
                          color:  Color(0xff6F7183), fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            addHeight(30),
            GestureDetector(
              onTap: (){
                repositories.logOutUser();
              },
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/logout.png",height: 23,width: 23, color: AppTheme.buttonColor,),
                  addWidth(20),
                  Text("LOGOUT",
                      //textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(fontSize: 16,
                          color:  const Color(0xff6F7183), fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row userInfo() {
    return
      Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Image.asset("assets/images/ring.png",height: 15,width: 15,),
               addWidth(8),
               Text(
                   userDataController.mobile.value.toString(),
                   //textAlign: TextAlign.center,
                   style: GoogleFonts.poppins(fontSize: 14, color:  Color(0xff191723), fontWeight: FontWeight.w500)),
             ],
           );
  }
}
