
import 'package:ecom_demo/resources/add_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../resources/common_button.dart';
import '../resources/customer_textfield.dart';

class Forgotpage extends StatefulWidget {
  const Forgotpage({Key? key}) : super(key: key);

  @override
  State<Forgotpage> createState() => _ForgotpageState();
}

class _ForgotpageState extends State<Forgotpage> {
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
              Text("Forgot Password",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Color(0xff222222)),),
              addHeight(65),
              Text("Please, enter your email address you will recive a link to create new password",
                style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17,color: Color(0xff222222)),),
              addHeight(10),
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
              addHeight(40),

              CommonButtonGreen(
                title: 'SEND',
                onPressed: (){

                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
