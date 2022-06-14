import 'package:get/get.dart';
import 'models/error_res.dart';

class ErrorHandling {
  int code = 0;
  String message = "";

  ErrorHandling(response) {
    if (response is Response) {
      code = response.statusCode!;
    }
    message = getErrorMessage(response);
  }

  static String getErrorMessage(response) {
    try {
      if (response is Response) {
        if (response.body != null) {
          return ErrorRes.fromJson(response.body).Message!;
        } else {
          switch (response.statusCode) {
            case 200:
            case 201:
            case 202:
              return "Success";
            case 400:
              return "You are not registered.";
            case 401:
              return "You are unauthenticated";
            case 404:
              return "The resource you are looking is temporarily unavailable.\nPlease try again later";
            case 405:
              return "Method not allowed";
            case 500:
              return "There is a problem with our server, it will be fixed soon.\nPlease try again later";
            default:
              if (response.statusText != null &&
                  response.statusText!.isNotEmpty) {
                return response.statusText!;
              }
              return 'Unknown error.';
          }
        }
      } else {
        return response.toString();
      }
    } catch (e) {
      return response.toString();
    }
  }

  @override
  String toString() {
    return message;
  }
}
