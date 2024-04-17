import 'package:auth/view_model/data/local/shared_helper.dart';
import 'package:auth/view_model/data/network/end_points.dart';
import 'package:dio/dio.dart';

import '../local/shared_keys.dart';

class DioHelper {
  static Dio? dio;

  static dioInit() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.BaseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
    dio?.interceptors.add(LogInterceptor(
      responseBody: true,
      error: true,
      requestHeader: false,
      responseHeader: false,
      requestBody: true,
      request: true,
    ));

  }

  static Future<Response> get({
    required String endPoint,
    Map<String,dynamic>? queryParameters,
    Map<String,dynamic>? body,
    Map<String,dynamic>? headers,
    bool? withToken=false,
  }) async {
    try {
      dio?.options.headers = headers;
      if(withToken!){
        dio?.options.headers ={
          'Authorization':'Bearer ${await SharedHelper.get(key: SharedKeys.token)}',
        };
      }
      return await dio!.get(
        endPoint,
        queryParameters:queryParameters,
        data: body,
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> post({
    required String endPoint,
    Map<String,dynamic>? queryParameters,
    Map<String,dynamic>? body,
    Map<String,dynamic>? headers,
    FormData? formData,
    bool? withToken=false,
  }) async {
    try {
      dio?.options.headers = headers;
      if(withToken!){
        dio?.options.headers ={
          'Authorization':'Bearer ${await SharedHelper.get(key: SharedKeys.token)}',
        };
      }
      return await dio!.post(
        endPoint,
        queryParameters:queryParameters,
        data: formData?? body,
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> put({
    required String endPoint,
    Map<String,dynamic>? queryParameters,
    Map<String,dynamic>? body,
    Map<String,dynamic>? headers,
    bool? withToken=false,

  }) async {
    try {
      dio?.options.headers = headers;
      if(withToken!){
        dio?.options.headers ={
          'Authorization':'Bearer ${await SharedHelper.get(key: SharedKeys.token)}',
        };
      }
      return await dio!.put(
        endPoint,
        queryParameters:queryParameters,
        data: body,
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> patch({
    required String endPoint,
    Map<String,dynamic>? queryParameters,
    Map<String,dynamic>? body,
    Map<String,dynamic>? headers,
    bool? withToken=false,

  }) async {
    try {
      dio?.options.headers = headers;
      if(withToken!){
        dio?.options.headers ={
          'Authorization':'Bearer ${await SharedHelper.get(key: SharedKeys.token)}',
        };
      }
      return await dio!.patch(
        endPoint,
        queryParameters:queryParameters,
        data: body,
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> delete({
    required String endPoint,
    Map<String,dynamic>? queryParameters,
    Map<String,dynamic>? body,
    Map<String,dynamic>? headers,
    bool? withToken=false,

  }) async {
    try {
      dio?.options.headers = headers;
      if(withToken!){
        dio?.options.headers ={
          'Authorization':'Bearer ${await SharedHelper.get(key: SharedKeys.token)}',
        };
      }
      return await dio!.delete(
        endPoint,
        queryParameters:queryParameters,
        data: body,
      );
    } catch (e) {
      rethrow;
    }
  }

}
