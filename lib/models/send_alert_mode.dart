class SendAlertModel {
  String? success;
  dynamic alertID;

  SendAlertModel({this.success, this.alertID});

  SendAlertModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    alertID = json['alertID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['alertID'] = this.alertID;
    return data;
  }
}
