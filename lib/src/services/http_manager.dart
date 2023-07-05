import 'package:dio/dio.dart';

abstract class HttpMethods {
  static const String get = 'GET';
  static const String put = 'PUT';
  static const String post = 'POST';
  static const String patch = 'PATCH';
  static const String delete = 'DELETE';
}

class HttpManager {
  Future<Map> restRequest(
    String url,
    String method,
    Map? headers,
    Map? body,
  ) async {
    //Headers da requisicao  --> ?? verificar se tem valor null
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-Parse-Application-Id': 'wK7GcEjr2V4br5q5mlR1kybQ5dvxMFDX0qtE1d6Y',
        'X-Parse-REST-API-Key': '2kahi62fkWePLWAwC7k8aMrtQkobogcgkruMxbeB',
      });

    Dio dio = Dio();

    try {
      Response response = await dio.request(
        url,
        options: Options(
          headers: defaultHeaders,
          method: method,
        ),
        data: body,
      );

      //Retorno do resultado do backend
      return response.data;
    } on DioException catch (error) {
      //Retorno do erro do dio request
      return error.response?.data ?? {};
    } catch (e) {
      // Retorno de map vazio para error generalizado
      return {};
    }
  }
}
