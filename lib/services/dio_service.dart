import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio_service;

class DioService {
  Dio dio = Dio();

  Future<dynamic> getMethod(String url) async {
    dio.options.headers['content-Type'] = 'application/json';
    try {
      var response = await dio.get(
        url,
        options: Options(responseType: ResponseType.json, method: 'GET'),
      );
      return response;
    } on DioException catch (err) {
      return err.response ??
          Response(
            requestOptions: RequestOptions(path: url),
            statusCode: 500,
            statusMessage: 'DioException without response',
            data: {'error': err.toString()},
          );
    } catch (err) {
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 500,
        statusMessage: 'Unhandled exception',
        data: {'error': err.toString()},
      );
    }
  }

  Future<dynamic> postMethod(Map<String, dynamic> map, String url) async {
    dio.options.headers['content-Type'] = 'application/json';
    try {
      var response = await dio.post(
        url,
        data: dio_service.FormData.fromMap(map),
        options: Options(responseType: ResponseType.json, method: 'POST'),
      );
      return response;
    } on DioException catch (err) {
      return err.response ??
          Response(
            requestOptions: RequestOptions(path: url),
            statusCode: 500,
            statusMessage: 'DioException without response',
            data: {'error': err.toString()},
          );
    } catch (err) {
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 500,
        statusMessage: 'Unhandled exception',
        data: {'error': err.toString()},
      );
    }
  }
}
