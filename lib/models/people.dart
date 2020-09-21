import 'package:http/http.dart' as http;
import 'dart:convert';
class People {
  List<Data> data;
  People({this.data});
// convert object json from api
  People.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }
// use for push to create data
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Data {
  int id;
  String firstName;
  String lastName;
  String age;
  String active_date;

  Data({this.id,
    this.firstName,
    this.lastName,
    this.age,
    this.active_date
  });
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    age = json['age'];
    active_date = json['active_date'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['age'] = this.age;
    data['active_date'] = this.active_date;

    return data;
  }
}
