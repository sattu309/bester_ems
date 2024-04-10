class LocalDataModel {
  String? reqStatus;
  String? emsMedical;
  String? emsMotor;
  String? emsInjury;
  String? emsSec;
  String? eType;

  LocalDataModel(
      {this.reqStatus,
        this.emsMedical,
        this.emsMotor,
        this.emsInjury,
        this.emsSec,
        this.eType});

  LocalDataModel.fromJson(Map<String, dynamic> json) {
    reqStatus = json['reqStatus'];
    emsMedical = json['ems_medical'];
    emsMotor = json['ems_motor'];
    emsInjury = json['ems_injury'];
    emsSec = json['ems_sec'];
    eType = json['eType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reqStatus'] = this.reqStatus;
    data['ems_medical'] = this.emsMedical;
    data['ems_motor'] = this.emsMotor;
    data['ems_injury'] = this.emsInjury;
    data['ems_sec'] = this.emsSec;
    data['eType'] = this.eType;
    return data;
  }
}
