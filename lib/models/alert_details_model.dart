class AlertDetailsModel {
  Success? success;

  AlertDetailsModel({this.success});

  AlertDetailsModel.fromJson(Map<String, dynamic> json) {
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
  dynamic latitude;
  dynamic longitude;
  dynamic id;
  dynamic address;
  dynamic emstype;
  dynamic eta;
  dynamic status;
  dynamic responderId;
  dynamic createdBy;
  dynamic createdAt;
  dynamic name;
  dynamic mobile;
  dynamic email;
  dynamic companyname;

  Success(
      {this.id,
        this.latitude,
        this.longitude,
        this.address,
        this.emstype,
        this.eta,
        this.status,
        this.responderId,
        this.createdBy,
        this.createdAt,
        this.name,
        this.mobile,
        this.email,
        this.companyname});

  Success.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    emstype = json['emstype'];
    eta = json['eta'];
    status = json['status'];
    responderId = json['responder_id'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    companyname = json['companyname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    data['emstype'] = this.emstype;
    data['eta'] = this.eta;
    data['status'] = this.status;
    data['responder_id'] = this.responderId;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['companyname'] = this.companyname;
    return data;
  }
}
