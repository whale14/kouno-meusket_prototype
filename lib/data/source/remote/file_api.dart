import 'dart:typed_data';

import 'package:dio/dio.dart';

class FileApi {
  final _dio = Dio();
  static const baseUrl = 'http://192.168.100.100:8080/upload';

  Future<Response> uploadImage(Uint8List image, String fileName) async{
    _dio.options.contentType = 'multipart/form-data';
    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(image, filename: fileName),
        });
    final response = await _dio.post(baseUrl, data: formData);

    return response;
  }
}