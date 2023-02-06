



class AttendanceModel {
  String? date;
  String? timeIn;
  String? timeOut;

  AttendanceModel({this.date, this.timeIn, this.timeOut});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    date = json['Date'] ?? '';
    timeIn = json['Time_In'] ?? '';
    timeOut = json['Time_Out'] ?? '';
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Date'] = this.date;
    data['Time_In'] = this.timeIn;
    data['Time_Out'] = this.timeOut;
    return data;
  }
}