import 'package:dio/dio.dart';

class dioHelper
{
  static Dio? dio;

  static init()
  {
      dio = Dio(BaseOptions(baseUrl: "https://api.openweathermap.org", receiveDataWhenStatusError: true));
  }

  static Future<Response?> getData(String method, Map<String, dynamic> query) async
  {
    try {
      return await dio?.get(method, queryParameters: query);
    } on Exception catch(e) {

      print("this is error");
    } catch(e) {
    }
    return null;

  }
}