import 'package:airsoftmarket/app/data/models/register_model.dart';
import 'package:get/get.dart';

class AuthProvider extends GetConnect {
  String url = "https://openapi.mrstein.web.id/";

  Future<registerMember> register(String email, name, pass) async {
    final response = await post(
      "$url" + 'auth/register',
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
      "$url" + 'auth/login',
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

  // Future<MovieRes> getTopRatedMovie(int page) async {
  //   final response = await get(
  //     '/movie/top_rated',
  //     query: {
  //       'page':'$page',
  //       'api_key':FlavorConfig.instance.apiKey
  //     },
  //   );

  //   try {
  //     return MovieRes.fromJson(response.body);
  //   } catch (e, s) {
  //     logger.e('getMoviePopular', e, s);
  //     if(response.hasError){
  //       if(GetStorage().hasData(response.request!.url.toString())){
  //         Map<String,dynamic> responseCache=GetStorage().read(response.request!.url.toString());
  //         return MovieRes.fromJson(responseCache);
  //       }
  //       return Future.error(ErrorHandling(response));
  //     }else{
  //       return Future.error(ErrorHandling(e.toString()));
  //     }
  //   }
  // }

}
