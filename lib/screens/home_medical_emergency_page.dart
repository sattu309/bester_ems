import 'dart:convert';
import 'dart:developer';
import 'package:ecom_demo/resources/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common_repository/api_repository.dart';
import '../conttroller/alert_handle_controller.dart';
import '../models/get_active_alert_model.dart';
import '../models/send_alert_mode.dart';
import '../resources/add_text.dart';
import '../resources/app_theme.dart';
import '../common_repository/api_repository.dart';
import '../conttroller/get_current_location.dart';
import '../resources/dimension.dart';
import '../models/emergency_alert_model.dart';
import '../models/otpverify_model.dart';
import '../repository/push_notification_api.dart';
import '../repository/send_alert_repo.dart';
import '../resources/api_urls.dart';

class MedicalEmergencyPage extends StatefulWidget {
  final String emsTypeMedical;
  final String emsTypeMotor;
  final String emsTypeInjury;
  final String emsTypeSec;
  final Function? callback;
  const MedicalEmergencyPage({Key? key, required this.emsTypeMedical, required this.emsTypeInjury, required this.emsTypeMotor, required this.emsTypeSec, required this.callback,}) : super(key: key);

  @override
  State<MedicalEmergencyPage> createState() => _MedicalEmergencyPageState();
}

class _MedicalEmergencyPageState extends State<MedicalEmergencyPage> {

  final locationController = Get.put(LocationController());
  final userDataController = Get.put(AlertHandleController());

  Repositories repositories = Repositories();
  GetActiveAlertModel? getActiveAlertModel;
  getActiveAlertRepo(){
    repositories.getApi(url: ApiUrls.getActiveAlertUrl).then((value){
      getActiveAlertModel = GetActiveAlertModel.fromJson(jsonDecode(value));
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

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  void initState() {
    super.initState();
    locationController.getLocation();
    getActiveAlertRepo();
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
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
      getActiveAlertModel != null ?
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child:
            Obx((){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: width,
                    // height: height* .2,
                    decoration:  BoxDecoration(
                      image: DecorationImage(
                        image:
                        widget.emsTypeMedical == "medical" ?
                        const AssetImage( "assets/images/medicalmain.png",):
                        widget.emsTypeMotor == "motor" ?
                        AssetImage( "assets/images/motorbg.png",):
                        widget.emsTypeInjury == "injury" ?
                        AssetImage( "assets/images/injurybg.png",):
                        AssetImage( "assets/images/secbg.png",),
                        fit: BoxFit.fitWidth,
                      ),
                      borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(70)),
                    ),
                    child:  Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        addHeight(10),
                        Text(
                            "You've requested for",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w400)),
                        Text(
                            widget.emsTypeMedical == "medical" ?
                            "Medical Emergency":
                            widget.emsTypeMotor == "motor" ? "Motor Accident" :
                            widget.emsTypeInjury == "injury" ?  "Injured on Duty":
                            "Security Emergency",
                            style: GoogleFonts.poppins(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w400)),
                        widget.emsTypeMedical == "medical" ?
                        Image.asset(
                          "assets/images/medical_icon.png",
                          height: 70,
                          width: 60,
                        ):
                        widget.emsTypeMotor == "motor" ?
                        Image.asset(
                          "assets/images/motor_icon.png",
                          height: 70,
                          width: 60,
                        ):
                        widget.emsTypeInjury == "injury" ?
                        Image.asset(
                          "assets/images/injury_icon.png",
                          height: 70,
                          width: 60,
                        ):  Image.asset(
                          "assets/images/sec_icon.png",
                          height: 70,
                          width: 60,
                        ),
                      ],
                    ),
                  ),

                  addHeight(7),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            getActiveAlertModel!.success != null && getActiveAlertModel!.success!.status == 1 ?
                            Expanded(
                              child: Text(
                                  "Hold tight, Alert sent to ${getActiveAlertModel!.success!.emstype == "sec" ? userDataController.showSec.value : userDataController.userAppName.value}Keep your phone close at all times, we will call you on ${userDataController.mobile.value}",
                                  style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                            ):
                            getActiveAlertModel!.success != null && getActiveAlertModel!.success!.status == 4  ?
                            Expanded(
                              child: Text("Hold tight, Alert sent to ${getActiveAlertModel!.success!.emstype == "sec" ? userDataController.showSec.value : userDataController.userAppName.value}Keep your phone close at all times, we will call you on ${userDataController.mobile.value}",
                                  style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                            ):
                            RichText(
                              text:  TextSpan(
                                  text: 'Send alert to ',
                                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: userDataController.userAppName.value,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize: 18))
                                  ]),
                            ),
                            Image.asset(
                              "assets/images/callwait.png",
                              height: 40,
                              width: 45,
                            )
                          ],
                        ),
                        addHeight(8),
                        const Divider(
                          height: 1,
                        ),
                        addHeight(4),
                        Column(
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                                addWidth(5),
                                Text("ALERT SENT TO PERSON",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    getActiveAlertModel!.success != null && getActiveAlertModel!.success!.emstype == "sec" ? userDataController.showSec.value : userDataController.userAppName.value,
                                    style: GoogleFonts.poppins(
                                        fontSize: 19,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600)),
                                const Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            addHeight(4),
                          ],
                        ),
                        const Divider(
                          height: 1,
                        ),
                        addHeight(15),
                        getActiveAlertModel!.success != null && getActiveAlertModel!.success!.status == 1 || getActiveAlertModel!.success != null && getActiveAlertModel!.success!.status == 4 ?
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                // color: AppTheme.buttonColor
                              ),
                              child: ElevatedButton(
                                  onPressed: () {
                                    sendAlertRepo(
                                        userLat: locationController.lat.value.toString(),
                                        userLong: locationController.long.value.toString(),
                                        emerType: widget.emsTypeMedical == "medical" ? 'medical':
                                        widget.emsTypeMotor == "motor" ? "motor":
                                        widget.emsTypeInjury == "injury" ?"injury":"Security Emergency",
                                        userAddress: locationController.concatenatedString.value.toString(),
                                        context: context, alertStatus: '2',
                                      alertID: getActiveAlertModel!.success!.id.toString()

                                    ).then((value){
                                      if(value.success != null){
                                      getActiveAlertRepo();
                                      widget.callback!();
                                      }else{
                                        log("something went wrong");
                                        //Helpers.showToast(value.alertID.toString());
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize:
                                    Size(AddSize.screenWidth, AddSize.size50 * 1.2),
                                    backgroundColor: Colors.grey.shade300,
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8), // <-- Radius
                                    ),
                                    // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("CANCEL EMERGENCY",
                                          style:  GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              color: AppTheme.buttonColor,
                                              letterSpacing: .5,
                                              fontSize: 15)),
                                    ],
                                  )),
                            ),
                            addHeight(13),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                // color: AppTheme.buttonColor
                              ),
                              child: ElevatedButton(
                                  onPressed: () {
                                    sendAlertRepo(
                                        userLat: locationController.lat.value.toString(),
                                        userLong: locationController.long.value.toString(),
                                        emerType: widget.emsTypeMedical == "medical" ? 'medical':
                                        widget.emsTypeMotor == "motor" ? "motor":
                                        widget.emsTypeInjury == "injury" ?"injury":"Security Emergency",
                                        userAddress: locationController.concatenatedString.value.toString(),
                                        alertStatus: '3',
                                      alertID: getActiveAlertModel!.success!.id.toString(),
                                        context: context,


                                    ).then((value){
                                      if(value.success != null){
                                        getActiveAlertRepo();
                                        widget.callback!();
                                      }else{
                                        log("something went wrong");
                                        //Helpers.showToast(value.alertID.toString());
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize:
                                    Size(AddSize.screenWidth, AddSize.size50 * 1.2),
                                    backgroundColor: AppTheme.buttonColor,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8), // <-- Radius
                                    ),
                                    // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("EMERGENCY RESOLVED",
                                          style:  GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              letterSpacing: .5,
                                              fontSize: 15)),
                                    ],
                                  )),
                            ),
                            // addHeight(13),
                          ],
                        ):
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            // color: AppTheme.buttonColor
                          ),
                          child: ElevatedButton(
                              onPressed: () async {
                                sendAlertRepo(
                                    userLat: locationController.lat.value.toString(),
                                    userLong: locationController.long.value.toString(),
                                    emerType: widget.emsTypeMedical == "medical" ? 'medical':
                                    widget.emsTypeMotor == "motor" ? "motor":
                                    widget.emsTypeInjury == "injury" ?"injury":"Security Emergency",
                                    userAddress: locationController.concatenatedString.value.toString(),
                                    context: context, alertStatus: '1',
                                    alertID: ""
                                ).then((value) async {
                                  if(value.success != null) {
                                    widget.callback!();
                                    Helpers.showToast(value.success.toString());
                                    // buildShowDialog(context);
                                    getActiveAlertRepo();

                                  }
                                  else{
                                    Helpers.showToast("soomething Went wrong");
                                  }
                                });

                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize:
                                Size(AddSize.screenWidth, AddSize.size50 * 1.2),
                                backgroundColor: AppTheme.buttonColor,
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8), // <-- Radius
                                ),
                                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("SEND EMERGENCY ALERT",
                                      style:  GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          letterSpacing: .5,
                                          fontSize: 15)),
                                ],
                              )),
                        ),
                        addHeight(13),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            // color: AppTheme.buttonColor
                          ),
                          child: ElevatedButton(
                              onPressed: () {
                                openMap(double.parse(locationController.lat.value.toString(),),
                                    double.parse(locationController.long.value.toString())
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize:
                                Size(AddSize.screenWidth, AddSize.size50 * 1.2),
                                backgroundColor: const Color(0xff0074D9),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8), // <-- Radius
                                ),
                                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/navigation.png",
                                    height: 30,width: 30, color: Colors.white,),
                                  addWidth(5),
                                  Text("SHOW MY LOCATION",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          letterSpacing: .5,
                                          fontSize: 15)),
                                ],
                              )),
                        ),
                        addHeight(13),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            // color: AppTheme.buttonColor
                          ),
                          child: ElevatedButton(
                              onPressed: () {
                                makingPhoneCall("tel:+919988776633");
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize:
                                Size(AddSize.screenWidth, AddSize.size50 * 1.2),
                                backgroundColor: Colors.green,
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8), // <-- Radius
                                ),
                                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/phone-call.png",
                                    height: 25,width: 25, color: Colors.white,),
                                  addWidth(5),
                                  Text("CALL BESTER EMS",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          letterSpacing: .5,
                                          fontSize: 15)),
                                ],
                              )),
                        ),
                        addHeight(20),
                      ],
                    ),
                  )
                ],
              );
            })

      ):
      const Center(child: CircularProgressIndicator(
        color: AppTheme.buttonColor,),)
    );
  }

  Future<dynamic> buildShowDialog(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext){
                          return Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    addHeight(10),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset("assets/images/bester.png"),
                                    ),
                                    addHeight(10),
                                    Text("MEDICAL EMERGENCY",
                                        //textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontSize: 14, color: Color(0xff303D48),
                                            fontWeight: FontWeight.w600)),
                                    addHeight(10),
                                    Text("Hi ${userDataController.userName.value}, we've received your Medical Emergency. We are here for you!",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color:  Colors.black,
                                            // color:  Color(0xff6F7183),
                                            fontWeight: FontWeight.w400)),
                                    addHeight(30),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        // color: AppTheme.buttonColor
                                      ),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            minimumSize:
                                            Size(AddSize.screenWidth, AddSize.size50 * 1.2),
                                            backgroundColor: AppTheme.buttonColor,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8), // <-- Radius
                                            ),
                                            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("OK",
                                                  style:  GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.white,
                                                      letterSpacing: .5,
                                                      fontSize: 15)),
                                            ],
                                          )),
                                    ),
                                    addHeight(5),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
  }
}
