class ScreenResultRequest {
  String? firstName;
  String? middleName;
  String? nationality;

  ScreenResultRequest({this.firstName, this.middleName, this.nationality});

  ScreenResultRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['fname'];
    middleName = json['mname'];
    nationality = json['nat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fname'] = firstName;
    data['mname'] = middleName;
    data['nat'] = nationality;
    return data;
  }
}
