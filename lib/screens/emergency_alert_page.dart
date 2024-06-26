import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:ecom_demo/resources/add_text.dart';
import 'package:ecom_demo/resources/app_theme.dart';
import 'package:ecom_demo/common_repository/api_repository.dart';
import 'package:ecom_demo/resources/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../conttroller/alert_data_controller.dart';
import '../conttroller/alert_handle_controller.dart';
import '../models/emergency_alert_model.dart';
import 'alert_details_page.dart';
import 'home_medical_emergency_page.dart';

class EmergencyAlertPage extends StatefulWidget {
  const EmergencyAlertPage({Key? key}) : super(key: key);

  @override
  State<EmergencyAlertPage> createState() => _EmergencyAlertPageState();
}

class _EmergencyAlertPageState extends State<EmergencyAlertPage> {
  final alertHandleController = Get.put(AlertHandleController());
  final emergencyDataController = Get.put(AlertDataController());



  @override
  void initState() {
    super.initState();
    alertHandleController.getUserType();
    WidgetsBinding.instance.addPostFrameCallback((_) {
        emergencyDataController.getEmergencyData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return
    Obx((){
      return
      Scaffold(
        backgroundColor: Colors.white,
        body:
        emergencyDataController.isDataLoading.value ? emergencyDataController.emergencyAlertsModel.value.success!.isNotEmpty
            ?

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addHeight(height * .05),
              Row(
                children: [
                  Image.asset(
                    "assets/images/warning.png",
                    height: 30,
                    width: 30,
                    color: AppTheme.buttonColor,
                  ),
                  addWidth(16),
                  Text("Emergency Alerts",
                      //textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: const Color(0xffDB3022),
                          fontWeight: FontWeight.w600)),
                ],
              ),
              // addHeight(2),

              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: emergencyDataController.emergencyAlertsModel!.value.success!.length,
                    itemBuilder: (BuildContext, index) {
                      final emergencyData =
                      emergencyDataController.emergencyAlertsModel!.value.success![index];
                      String formattedDate = DateFormat('MMM dd yy hh:mm a')
                          .format(DateTime.parse(emergencyData.createdAt!));

                      return InkWell(
                        onTap: () {
                          log(emergencyData!.emstype
                              .toString(),);
                          ((emergencyData.status == 1 ||
                              emergencyData.status == 4) &&
                              alertHandleController.userType.value ==
                                  "1")
                              ? Get.to(() => MedicalEmergencyPage(
                            emsTypeMedical:
                            emergencyData.emstype.toString(),
                            emsTypeInjury: emergencyData.emstype.toString(),
                            emsTypeMotor: emergencyData.emstype.toString(),
                            emsTypeSec: emergencyData.emstype.toString(),
                            eTypeHome: emergencyData.emstype.toString(),
                          ))
                              :
                          (emergencyData.status == 2 || emergencyData.status == 5) ? null :
                          Get.to(() => AlertDetailsPage(
                              alertId: emergencyData!.id
                                  .toString(),
                              alertStatus: emergencyData!
                                  .status
                                  .toString(),
                              emsType: emergencyData!.emstype
                                  .toString(),
                              dateApi: formattedDate
                          ));
                          // ((((emergencyData.status == 1 ||
                          //                     emergencyData.status == 4) &&
                          //                 alertHandleController
                          //                         .userType.value ==
                          //                     1) ||
                          //             (alertHandleController
                          //                             .userType.value ==
                          //                         "0" &&
                          //                     (alertHandleController
                          //                                 .userId.value ==
                          //                             emergencyData
                          //                                 .responderId ||
                          //                         emergencyData
                          //                                 .responderId ==
                          //                             0)) &&
                          //                 emergencyData.status != 5)
                          //         ? false
                          //         : true)
                          //             ? null
                          //             :
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(
                              height: 1,
                              thickness: 1.5,
                            ),
                            addHeight(7),
                            Text(
                                emergencyData.emstype == "medical"
                                    ? "MEDICAL EMERGENCY"
                                    : emergencyData.emstype == "motor"
                                    ? "MOTOR ACCIDENT"
                                    : emergencyData.emstype == "sec"
                                    ? "SECURITY EMERGENCY"
                                    : "INJURY ON DUTY",

                                //textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Color(0xff303C5E),
                                    fontWeight: FontWeight.w600)),
                            //  addHeight(1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    emergencyData.name
                                        .toString()
                                        .capitalizeFirst
                                        .toString(),
                                    //textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500)),
                                addWidth(width * .1),
                                Text(
                                    emergencyData.status == 1
                                        ? "PENDING"
                                        : emergencyData.status == 2
                                        ? "CANCELLED"
                                        : emergencyData.status == 3
                                        ? "         OUT OF EMERGENCY"
                                        : emergencyData.status == 4
                                        ? "HELP DISPATCHED"
                                        : "COMPLETED",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: (alertHandleController
                                            .userId.value !=
                                            emergencyData
                                                .responderId &&
                                            alertHandleController
                                                .userType.value ==
                                                0 &&
                                            emergencyData.responderId >
                                                0)
                                            ? Colors.grey
                                            : emergencyData.status == 1
                                            ? const Color(0xffFF0000)
                                            : emergencyData.status == 2
                                            ? const Color(
                                            0xffC0C0C0)
                                            : emergencyData
                                            .status ==
                                            3
                                            ? const Color(
                                            0xffffa905)
                                            : emergencyData
                                            .status ==
                                            4
                                            ? const Color(
                                            0xff3b9414)
                                            : emergencyData
                                            .status ==
                                            5
                                            ? const Color(
                                            0xffcccccc)
                                            : const Color(
                                            0xff0b1338),
                                        fontWeight: FontWeight.w500)),
                                //  addWidth(10),
                                ((((emergencyData.status == 1 ||
                                    emergencyData.status ==
                                        4) &&
                                    alertHandleController
                                        .userType.value ==
                                        "1") ||
                                    ((emergencyData.status == 1 ||
                                        emergencyData.status == 4) && alertHandleController.userType.value ==
                                        "0"))
                                    ? const Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  size: 15,
                                  color: Color(0xff666666),
                                )
                                    : const SizedBox()
                                )],
                            ),

                            Text(formattedDate.toString(),
                                //textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500)),
                            (alertHandleController.userId.value !=
                                emergencyData.responderId &&
                                alertHandleController.userType.value ==
                                    "0" &&
                                emergencyData.responderId! > 0)
                                ? Text(
                                "Responded by: ${emergencyData.responder.toString()}",
                                style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: const Color(0xff666666),
                                    fontWeight: FontWeight.w500))
                                : const SizedBox(),
                            addHeight(7),
                            const Divider(
                              height: 1,
                              thickness: 1,
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        )

            : const Center(
            child: CircularProgressIndicator(
              color: AppTheme.buttonColor,
            )):const Center(
            child: CircularProgressIndicator(
              color: AppTheme.buttonColor,
            )),
      );
    });

  }
}
