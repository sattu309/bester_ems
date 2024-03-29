
import 'package:ecom_demo/resources/add_text.dart';
import 'package:ecom_demo/login_flow/forgot_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../resources/common_button.dart';
import '../custom_bottom_bar.dart';
import '../resources/customer_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey= GlobalKey();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passWordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar2(title: "", context: context),
      body:  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Login",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0xff222222)),),
              addHeight(65),
              CommonTextFieldWidget(
                controller: emailController,
                hint: "Email",
                validator: MultiValidator([
                  RequiredValidator(
                      errorText:
                      'Please enter your email '),
                  EmailValidator(errorText: "please enter valid mail")

                ]),
              ),
              addHeight(10),
              CommonTextFieldWidget(
                controller: passWordController,
                hint: "Password",
                validator: MultiValidator([
                  RequiredValidator(
                      errorText: 'Please Enter Your Password'),
                ]),
              ),
              addHeight(20),
              GestureDetector(
                onTap: (){
                  Get.to(()=>const Forgotpage());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("Forgot your password?",
                      style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: Color(0xff222222)),),
                    Image.asset("assets/images/arrow.png",),
                  ],
                ),
              ),
              addHeight(50),
              CommonButtonGreen(
                title: 'LOGIN',
                onPressed: (){
                  Get.offAll(()=> MyNavigationBar());
                },
              ),
              addHeight(70),
              const Center(
                child: Text("Or sign up with social account",
                  style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color: Color(0xff222222)),),
              ),
              addHeight(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25,vertical: 7),
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/images/google.png",height: 40,width: 40,),
                    ),
                  ),
                  addWidth(40),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 7),
                    decoration: BoxDecoration(
                      color: const Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/images/fb.png",height: 40,width: 40,),
                    ),
                  ),
                ],
              ),
              addHeight(10),
            ],
          ),
        ),
      ),
    );
  }
}
