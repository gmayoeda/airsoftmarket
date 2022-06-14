class ErrorRes {
  bool? success;
  String? Message;

  ErrorRes({this.success, this.Message});

  ErrorRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    Message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.Message;
    return data;
  }
}
