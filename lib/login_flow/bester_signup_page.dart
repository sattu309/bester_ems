import 'package:ecom_demo/resources/add_text.dart';
import 'package:ecom_demo/resources/app_theme.dart';
import 'package:ecom_demo/login_flow/bester_login_page.dart';
import 'package:ecom_demo/login_flow/bester_otp_page.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resources/common_button.dart';
import '../repository/login_api.dart';
import '../resources/customer_textfield.dart';
import '../resources/helper.dart';

class BesterSignUpPage extends StatefulWidget {
  const BesterSignUpPage({super.key});

  @override
  State<BesterSignUpPage> createState() => _BesterSignUpPageState();
}

class _BesterSignUpPageState extends State<BesterSignUpPage> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final companyController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxString errorText="".obs;



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
                  addHeight(height * .07),
                  Center(child: Image.asset("assets/images/bester.png", height: 100,)),
                  addHeight(30)
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
                        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              addHeight(height*.05),
                               Text("Welcome to Bester EMS,Please note this\n Emergency App is for Port Elizabeth & surrounding Areas only.",
                                   textAlign: TextAlign.center,
                                   style: GoogleFonts.poppins(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500)),
                              addHeight(5),
                              Obx((){
                                return  Text(
                                    errorText.value != "null" ?
                                    errorText.value:"",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(fontSize: 13, color: AppTheme.buttonColor,  fontWeight: FontWeight.w400));
                              }),

                              errorText.value != "null" ? addHeight(5):addHeight(1),
                              CommonTextFieldWidget(
                                controller: nameController,
                                hint: "Name",
                                keyboardType: TextInputType.emailAddress,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Please Enter Your Name'),
                                ]),
                              ),
                              addHeight(8),
                              CommonTextFieldWidget(
                                controller: mobileController,
                                hint: "Mobile Number",
                                keyboardType: TextInputType.number,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Please Enter Your Mobile Number'),
                                ]),
                              ),
                              addHeight(8),
                              CommonTextFieldWidget(
                                controller: emailController,
                                hint: "Email",
                                keyboardType: TextInputType.emailAddress,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Please Enter Your Password'),
                                ]),
                              ),
                              addHeight(8),
                              CommonTextFieldWidget(
                                controller: companyController,
                                hint: "Company Name",
                                keyboardType: TextInputType.emailAddress,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Please Enter Your Company Name'),
                                ]),
                              ),
                              addHeight(20),
                              CommonButtonGreen(
                                title: 'SIGN UP',
                                onPressed: (){
                                  if(formKey.currentState!.validate()){
                                    besterSignUp(
                                        companyName: companyController.text,
                                        email: emailController.text,
                                        mobileNumber: mobileController.text,
                                        name: nameController.text,
                                        context: context
                                    ).then((value){
                                      if(value.success == "OTP sent please enter OTP to login"){
                                        Helpers.showToast(value.success.toString());
                                        Get.offAll(()=>   BesterOtpPage(mobileNumber: mobileController.text,));
                                      }
                                      else{
                                        errorText.value = value.error.toString();
                                        // Helpers.showToast(value.error.toString());
                                      }
                                    });
                                  }

                                },
                              ),
                              addHeight(10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                   Text("Already have an account?",
                                      //textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400)),
                                  addWidth(4),
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(()=>const BesterLoginPage());
                                    },
                                    child: const Text("Login",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 15, color: Color(0xffDB3022), fontWeight: FontWeight.w400)),
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