class BesterLoginModel {
  int? appVersion;
  String? success;
  String? error;

  BesterLoginModel({this.appVersion, this.success, this.error});

  BesterLoginModel.fromJson(Map<String, dynamic> json) {
    appVersion = json['appVersion'];
    success = json['success'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appVersion'] = this.appVersion;
    data['success'] = this.success;
    data['error'] = this.error;
    return data;
  }
}
