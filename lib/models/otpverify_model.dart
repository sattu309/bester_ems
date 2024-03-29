class OtpVerifyModel {
  int? appVersion;
  Success? success;

  OtpVerifyModel({this.appVersion, this.success});

  OtpVerifyModel.fromJson(Map<String, dynamic> json) {
    appVersion = json['appVersion'];
    success =
    json['success'] != null ? new Success.fromJson(json['success']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appVersion'] = this.appVersion;
    if (this.success != null) {
      data['success'] = this.success!.toJson();
    }
    return data;
  }
}

class Success {
  String? token;
  int? id;
  String? name;
  Null? lname;
  String? mobile;
  String? companyname;
  String? email;
  dynamic utype;
  String? aPPNAME;
  dynamic showsec;
  String? secadmin;
  String? secadminlogo;

  Success(
      {this.token,
        this.id,
        this.name,
        this.lname,
        this.mobile,
        this.companyname,
        this.email,
        this.utype,
        this.aPPNAME,
        this.showsec,
        this.secadmin,
        this.secadminlogo});

  Success.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    name = json['name'];
    lname = json['lname'];
    mobile = json['mobile'];
    companyname = json['companyname'];
    email = json['email'];
    utype = json['utype'];
    aPPNAME = json['APP_NAME'];
    showsec = json['showsec'];
    secadmin = json['secadmin'];
    secadminlogo = json['secadminlogo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['id'] = this.id;
    data['name'] = this.name;
    data['lname'] = this.lname;
    data['mobile'] = this.mobile;
    data['companyname'] = this.companyname;
    data['email'] = this.email;
    data['utype'] = this.utype;
    data['APP_NAME'] = this.aPPNAME;
    data['showsec'] = this.showsec;
    data['secadmin'] = this.secadmin;
    data['secadminlogo'] = this.secadminlogo;
    return data;
  }
}
