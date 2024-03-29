import 'dart:developer';

import 'package:ecom_demo/resources/add_text.dart';
import 'package:ecom_demo/login_flow/bester_otp_page.dart';
import 'package:ecom_demo/resources/helper.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/app_theme.dart';
import '../resources/common_button.dart';
import '../custom_bottom_bar.dart';
import '../models/bester_login_model.dart';
import '../repository/login_api.dart';
import '../resources/customer_textfield.dart';
import 'bester_signup_page.dart';


class BesterLoginPage extends StatefulWidget {
  const BesterLoginPage({super.key});

  @override
  State<BesterLoginPage> createState() => _BesterLoginPageState();
}

class _BesterLoginPageState extends State<BesterLoginPage> {
  final loginController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxString errorText="".obs;
  // userCheck() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   if (pref.getString('user_info') != null) {
  //    Get.offAllNamed(CustomNavigationBar.customNavigationBar);
  //   }
  //   else{
  //     Get.offAllNamed(OnBoardingScreen.onboardingScreen);
  //   }
  // }
  BesterLoginModel? besterLoginModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor:  Colors.transparent,
        body: Container(

          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/screenbg.png",),
              fit: BoxFit.cover,

            ),

          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  addHeight(height * .3),
                  Center(child: Image.asset("assets/images/bester.png", height: 100,)),
                  addHeight(30),
                ],),
              Positioned(
                  bottom: 0,
                  left: 20,
                  child: Container(
                 // height: height* .5,
                  width: width* .89,
                  //padding: EdgeInsets.symmetric(horizontal: 35,vertical: 7),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:  Colors.white,
                        offset: Offset(.1, .1,
                        ),
                        // blurRadius: 1.0,
                        //spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child:
                   Padding(
                     padding: const EdgeInsets.all(12.0),
                     child: Form(
                       key: formKey,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addHeight(height*.05),
                           Text("    Welcome Back! Please login to continue",
                             textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xff191723), fontWeight: FontWeight.w500)),
                           addHeight(5),
                          Obx((){
                            return  Text(
                                errorText.value != "null" ?
                                errorText.value:"",
                                textAlign: TextAlign.center,
                                //maxLines: 2,
                                style: GoogleFonts.poppins(fontSize: 13, color: AppTheme.buttonColor,  fontWeight: FontWeight.w400));
                          }

                          ),
                         // addHeight(1),
                         errorText.value != "null" ? addHeight(5):addHeight(1),
                          CommonTextFieldWidget(
                            controller: loginController,
                            hint: "Mobile Number",
                            keyboardType: TextInputType.number,
                            length: 10,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Mobile Number is Required'),
                            ]),
                          ),
                          addHeight(10),
                          CommonButtonGreen(
                            title: 'SIGN IN',
                            onPressed: (){
                              log("hello");
                              if(formKey.currentState!.validate()){
                                log("hello");
                                createLogin(
                                    mobileNumber: loginController.text,
                                    context: context).then((value){
                                      if(value.success != null){
                                        //Helpers.showToast(value.success.toString());
                                        Get.to(()=> BesterOtpPage(mobileNumber: loginController.text));
                                      }
                                      else{
                                        // log(errorText);
                                        errorText.value = value.error.toString();
                                       // Helpers.showToast(value.error.toString());
                                       // Get.to(()=> const BesterSignUpPage());
                                      }
                                });
                              }
                            },
                          ),
                           addHeight(8),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Text("Don't have an account",
                                  //textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400)),
                              addWidth(4),
                              GestureDetector(
                                onTap: (){
                                  Get.to(()=>const BesterSignUpPage());
                                },
                                child:  Text("Register",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(fontSize: 15, color: Color(0xffDB3022), fontWeight: FontWeight.w400)),
                              ),
                            ],
                          ),
                          addHeight(height*.02),
                        ],
                                         ),
                     ),
                   )
              )),



            ],

          ),
        )

    );
  }
}