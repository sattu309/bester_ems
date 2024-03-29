
import 'package:ecom_demo/resources/add_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/common_button.dart';
import '../resources/customer_textfield.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
              Text("Sign Up",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0xff222222),),),
              addHeight(65),
              CommonTextFieldWidget(
                controller: nameController,
                hint: "Name",
              ),
              addHeight(10),
              CommonTextFieldWidget(
                controller: emailController,
                hint: "Email",
              ),
              addHeight(10),
              CommonTextFieldWidget(
                controller: passWordController,
                hint: "Password",
              ),
              addHeight(20),
              GestureDetector(
                onTap: (){
                  Get.to(()=>const LoginPage());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("Already have an account?",
                      style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: Color(0xff222222)),),
                    Image.asset("assets/images/arrow.png",),
                  ],
                ),
              ),
              addHeight(50),
              CommonButtonGreen(
                title: 'SIGN UP',
              onPressed: (){

              },
              ),
              addHeight(70),
              Center(
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
                    padding: EdgeInsets.symmetric(horizontal: 25,vertical: 7),
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
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
