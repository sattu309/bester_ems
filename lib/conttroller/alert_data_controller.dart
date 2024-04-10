import 'package:get/get.dart';
import '../models/emergency_alert_model.dart';
import '../repository/send_alert_repo.dart';

class AlertDataController extends GetxController{
 RxBool isDataLoading = false.obs;
 Rx<EmergencyAlertsModel> emergencyAlertsModel = EmergencyAlertsModel().obs;

 getEmergencyData() {
   // Timer.periodic(const Duration(seconds: 2), (timer) {
     getEmergencyAlertRepo().then((value) {
       isDataLoading.value = true;
       emergencyAlertsModel.value = value;
     });
   // });

 }

 @override
 void onInit() {
   super.onInit();
   getEmergencyData();
 }
}