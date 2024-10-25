import 'package:dio/dio.dart';

abstract class IJsonRequest {
  Future get({required String url});
}

class DioRequest implements IJsonRequest {
  final Dio dio = Dio();

  @override
  Future get({required String url}) async {
    return await dio.get(url);
  }
}
