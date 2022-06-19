import 'package:airsoftmarket/app/data/models/register_model.dart';
import 'package:airsoftmarket/app/data/server.dart';
import 'package:get/get.dart';

class AuthProvider extends GetConnect {
  Future<registerMember> register(String email, name, pass) async {
    final response = await post(
      Server.url + 'auth/register',
      {
        'email': email,
        'name': name,
        'password': pass,
      },
      contentType: "application/json",
    );
    try {
      print("DATA RESPONSE REGISTER : ${response.body}");
      return registerMember.fromJson(response.body);
    } catch (e) {
      throw Exception();
    }
  }

  Future<registerMember> login(String email, pass) async {
    final response = await post(
      Server.url + 'auth/login',
      {
        'email': email,
        'password': pass,
      },
      contentType: "application/json",
    );
    try {
      print("DATA RESPONSE LOGIN : ${response.body}");
      return registerMember.fromJson(response.body);
    } catch (e) {
      throw Exception();
    }
  }
}
