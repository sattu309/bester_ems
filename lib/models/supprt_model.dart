class SupportModel {
  Success? success;

  SupportModel({this.success});

  SupportModel.fromJson(Map<String, dynamic> json) {
    success =
    json['success'] != null ? new Success.fromJson(json['success']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.success != null) {
      data['success'] = this.success!.toJson();
    }
    return data;
  }
}

class Success {
  String? tagtext;
  String? phone;
  String? email;
  String? web;
  String? address;
  String? whatsapp;
  String? facebook;
  String? tiktok;

  Success(
      {this.tagtext,
        this.phone,
        this.email,
        this.web,
        this.address,
        this.whatsapp,
        this.facebook,
        this.tiktok});

  Success.fromJson(Map<String, dynamic> json) {
    tagtext = json['tagtext'];
    phone = json['phone'];
    email = json['email'];
    web = json['web'];
    address = json['address'];
    whatsapp = json['whatsapp'];
    facebook = json['facebook'];
    tiktok = json['tiktok'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tagtext'] = this.tagtext;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['web'] = this.web;
    data['address'] = this.address;
    data['whatsapp'] = this.whatsapp;
    data['facebook'] = this.facebook;
    data['tiktok'] = this.tiktok;
    return data;
  }
}
