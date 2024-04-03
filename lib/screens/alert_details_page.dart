import 'dart:convert';
import 'package:ecom_demo/resources/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../conttroller/alert_data_controller.dart';
import '../models/alert_details_model.dart';
import '../repository/send_alert_repo.dart';
import '../resources/add_text.dart';
import '../resources/app_theme.dart';
import '../common_repository/api_repository.dart';
import '../resources/dimension.dart';

class AlertDetailsPage extends StatefulWidget {
  final String alertId;
  final String alertStatus;
  final String emsType;
  final String dateApi;
  const AlertDetailsPage({Key? key, required this.alertId, required this.alertStatus, required this.emsType, required this.dateApi,}) : super(key: key);

  @override
  State<AlertDetailsPage> createState() => _AlertDetailsPageState();
}

class _AlertDetailsPageState extends State<AlertDetailsPage> {
  final emergencyDataController = Get.put(AlertDataController());
  Repositories repositories = Repositories();
  AlertDetailsModel? alertDetailsModel;
  RxString dropdownvalue = '60'.obs;
  var items = [
    '60',
    '30',
    '20',
    '10',
    '5',
    'Bester EMS has now arrived',
  ];

  alertDetailsRepo(){
    repositories.getApi(url:"${ApiUrls.alertDetailsApiUrl}/${widget.alertId}" ).then((value) async {
      alertDetailsModel = AlertDetailsModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  makingPhoneCall(call) async {
    var url = Uri.parse(call);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  void initState() {
    super.initState();
    alertDetailsRepo();
    emergencyDataController.getEmergencyData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return  Scaffold(
      //backgroundColor: Color(0xffFFFFFF),
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
      body:
      alertDetailsModel != null ?
      Padding(

        padding: const EdgeInsets.symmetric(
            horizontal: 30,vertical: 30),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Column(

                children: [
                 // addHeight(height* .1),
                  Image.asset("assets/images/bester.png", height: 100,),
                  addHeight(10),
                  Text(alertDetailsModel!.success!.name.toString(),
                      //textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(fontSize: 16, color:  Color(0xffDB3022), fontWeight: FontWeight.w600)),
                  addHeight(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/ring.png",height: 15,width: 15,),
                      addWidth(8),
                      Text(alertDetailsModel!.success!.mobile.toString(),
                          //textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: 14, color:  Color(0xff191723), fontWeight: FontWeight.w500)),
                    ],
                  ),
                  addHeight(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.mail),
                      addWidth(6),
                      Text(alertDetailsModel!.success!.email.toString(),
                          //textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: 14, color:  Color(0xff191723), fontWeight: FontWeight.w500)),
                    ],
                  ),
                  addHeight(5),
                  alertDetailsModel!.success!.companyname != null ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.mail),
                      addWidth(6),
                      Text(alertDetailsModel!.success!.companyname.toString(),
                          //textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: 14, color:  Color(0xff191723), fontWeight: FontWeight.w500)),
                    ],
                  ):SizedBox(),

                  addHeight(20),
                  const Divider(
                    height: 2,
                    thickness: 1,
                  ),
                  addHeight(15),
                  Text(
                      widget.emsType == "medical"
                          ? "Medical Emergency"
                          : widget.emsType == "motor"
                          ? "Motor Accident"
                          : widget.emsType == "sec"
                          ? "Security Emergency"
                          : "Injury on Duty",

                      //textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: AppTheme.buttonColor,
                          fontWeight: FontWeight.w600)),
                  addHeight(5),
                   Text(
                      widget.dateApi,
                      //textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12, color: Colors.black,
                          fontWeight: FontWeight.w500)),
                  addHeight(5),
                  Text(alertDetailsModel!.success!.status == 1 ? "Pending" :
                      "Help Dispatched",
                      //textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 13, color: alertDetailsModel!.success!.status == 1 ? const Color(0xffd1242a):const Color(0xff3b9414),
                          fontWeight: FontWeight.w500)),
                  addHeight(20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      // color: AppTheme.buttonColor
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          openMap(
                              double.parse(alertDetailsModel!.success!.latitude.toString(),),
                              double.parse(alertDetailsModel!.success!.longitude.toString())
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                          Size(AddSize.screenWidth, AddSize.size50 * 1.1),
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
                            Text("SHOW DIRECTIONS",
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
                            makingPhoneCall("tel:+91${alertDetailsModel!.success!.mobile.toString()}");
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                          Size(AddSize.screenWidth, AddSize.size50 * 1.1),
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
                            addWidth(10),
                            Text("CALL",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    letterSpacing: .5,
                                    fontSize: 15)),
                          ],
                        )),
                  ),
                  addHeight(13),
                  alertDetailsModel!.success!.status > 1 ?
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      // color: AppTheme.buttonColor
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          buildShowDialog(context);
                          emergencyDataController.getEmergencyData();
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                          Size(AddSize.screenWidth, AddSize.size50 * 1.1),
                          backgroundColor: Colors.orange,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // <-- Radius
                          ),
                          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.watch_later_outlined),
                            addWidth(8),
                            Text("SEND ETA",
                                style:  GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    letterSpacing: .5,
                                    fontSize: 15)),
                          ],
                        )),
                  ):SizedBox(),
                  alertDetailsModel!.success!.status > 1 ?
                  addHeight(13):SizedBox(),
                  alertDetailsModel!.success!.status == 1 ?
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: AppTheme.buttonColor
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          sendEtaTimeRepo(
                              emsType: widget.emsType.toString(),
                              etaTime: "",
                              alertStatus: "4",
                              alertId: widget.alertId.toString(),
                              context: context).then((value){
                            if(value.success != null){
                              alertDetailsRepo();
                              emergencyDataController.getEmergencyData();
                              // Get.back();
                            }else{
                              print("Hellooo");
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                          Size(AddSize.screenWidth, AddSize.size50 * 1.1),
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
                            Text("Send Help",
                                style:  GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    letterSpacing: .5,
                                    fontSize: 15)),
                          ],
                        )),
                  ):
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: AppTheme.buttonColor
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          sendEtaTimeRepo(
                              emsType: widget.emsType.toString(),
                              etaTime: "",
                              alertStatus: "5",
                              alertId: widget.alertId.toString(),
                              context: context).then((value){
                            if(value.success != null){
                              emergencyDataController.getEmergencyData();
                              Get.back();
                            }else{
                              print("Hellooo");
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                          Size(AddSize.screenWidth, AddSize.size50 * 1.1),
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
                            Text("Emergency Resolved",
                                style:  GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    letterSpacing: .5,
                                    fontSize: 15)),
                          ],
                        )),
                  ),

                ],
              )),
              addHeight(20),

            ],
          ),
        ),
      ): const Center(child: CircularProgressIndicator(color: AppTheme.buttonColor,),)
    );
  }

  Future<dynamic> buildShowDialog(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext){
                        return Dialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)
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
                                  const Text("Estimated Time of Arrival",
                                      //textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                                  addHeight(10),
                                  Obx((){
                                    return
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            //width: 200,
                                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.white,
                                                border: Border.all(color: const Color(0xFFEEEEEE))),
                                            child:
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                borderRadius: BorderRadius.circular(10),
                                                focusColor: Colors.black87,
                                                elevation: 1,
                                                isDense: true,
                                                hint: Text(
                                                  '',
                                                  style: TextStyle(
                                                      color: AppTheme.userText,
                                                      fontSize: AddSize.font14,
                                                      fontWeight: FontWeight.w500),
                                                  textAlign: TextAlign.start,
                                                ),
                                                isExpanded: false,
                                                style: const TextStyle(
                                                  color: Color(0xFF697164),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                value: dropdownvalue.value,
                                                icon:null,
                                                // icon: const Icon(
                                                //   Icons.keyboard_arrow_down,
                                                //   color: Color(0xFF000000),
                                                // ),
                                                items: items.map((value) {
                                                  return DropdownMenuItem(
                                                    value: value.toString(),
                                                    child: Text(

                                                      value.toString(),
                                                      style: GoogleFonts.poppins(
                                                          fontSize: AddSize.font14,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.black
                                                      ),
                                                  ));
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    dropdownvalue.value = newValue!.toString();
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            child: Text("Minutes",
                                                //textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 15, color: Colors.black,
                                                    fontWeight: FontWeight.w600)),
                                          )
                                        ],
                                      );
                                  }),

                                  addHeight(30),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      // color: AppTheme.buttonColor
                                    ),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          sendEtaTimeRepo(
                                              emsType: widget.emsType.toString(),
                                              etaTime: dropdownvalue.value.toString(),
                                              alertStatus: "4",
                                              alertId: widget.alertId.toString(),
                                              context: context).then((value){
                                                if(value.success != null){
                                                  emergencyDataController.getEmergencyData();
                                                  Get.back();
                                                }else{
                                                  print("Hellooo");
                                                }
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize:
                                          Size(AddSize.screenWidth, AddSize.size50 * 1.1),
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
