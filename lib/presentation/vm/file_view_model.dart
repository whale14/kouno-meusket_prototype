import 'dart:io';
import 'dart:typed_data';

import 'package:logger/logger.dart';
import 'package:test_project/data/source/remote/file_api.dart';

class FileViewModel {
  final _repository = FileRepository();

  var isLoading = false;

  Future uploadImage(String image, String fileName) async {
    File imageFile = File(image);
    Uint8List imageRaw = await imageFile.readAsBytes();
    await _repository.uploadImage(imageRaw, fileName);
  }
}

class FileRepository {
  final _fileApi = FileApi();

  Future<bool> uploadImage(Uint8List image, String fileName) async{
    try {
      final response = await _fileApi.uploadImage(image, fileName);
      Logger().d("response: $response");
      return true;
    } catch(e) {
      Logger().d(e.toString());
      return false;
    }
  }

}