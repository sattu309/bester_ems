class EmergencyAlertsModel {
  List<Success>? success;

  EmergencyAlertsModel({this.success});

  EmergencyAlertsModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] != null) {
      success = <Success>[];
      json['success'].forEach((v) {
        success!.add(new Success.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.success != null) {
      data['success'] = this.success!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Success {
  int? id;
  String? emstype;
  dynamic responderId;
  String? name;
  int? status;
  String? createdAt;
  String? responder;

  Success(
      {this.id,
        this.emstype,
        this.responderId,
        this.name,
        this.status,
        this.createdAt,
        this.responder});

  Success.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    emstype = json['emstype'];
    responderId = json['responder_id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    responder = json['responder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['emstype'] = this.emstype;
    data['responder_id'] = this.responderId;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['responder'] = this.responder;
    return data;
  }
}
