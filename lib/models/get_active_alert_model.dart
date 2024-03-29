class GetActiveAlertModel {
  Success? success;

  GetActiveAlertModel({this.success});

  GetActiveAlertModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? emstype;
  String? name;
  int? status;
  String? createdAt;

  Success({this.id, this.emstype, this.name, this.status, this.createdAt});

  Success.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    emstype = json['emstype'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['emstype'] = this.emstype;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}
