import '../models/people.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RestAPI {
  final String baseUrl = "https://peopleinfoapi.herokuapp.com/api";

  Future<People> getPeople() async {
    final response = await http.get("$baseUrl/people");
    if (response.statusCode == 200) {
      return People.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<bool> createPeople(Data people) async {
    var bodyData = json.encode(people);

    final response = await http.post("$baseUrl/people",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: bodyData);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updatePeople(Data people) async {
    var bodyData = json.encode(people);
    print(bodyData);

    final response = await http.put("$baseUrl/people/${people.id}",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: bodyData);
    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.statusCode);
      return false;
    }
  }
  Future<bool> deletePeople(int id) async {
    print(id);



    final response = await http.delete("$baseUrl/people/${id}",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        );
    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.statusCode);
      return false;
    }
  }

}
