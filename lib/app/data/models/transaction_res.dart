class transactionRes {
  bool? success;
  String? message;
  Data? data;

  transactionRes({this.success, this.message, this.data});

  transactionRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? transCode;
  String? date;
  List<Detail>? detail;

  Data({this.id, this.transCode, this.date, this.detail});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transCode = json['trans_code'];
    date = json['date'];
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail!.add(new Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trans_code'] = this.transCode;
    data['date'] = this.date;
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  int? id;
  String? name;
  String? photo;
  String? description;
  int? price;
  int? qty;

  Detail(
      {this.id, this.name, this.photo, this.description, this.price, this.qty});

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    description = json['description'];
    price = json['price'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['description'] = this.description;
    data['price'] = this.price;
    data['qty'] = this.qty;
    return data;
  }
}
