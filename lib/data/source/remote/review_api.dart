import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
class ReviewApi {
  final http.Client _client;

  // static const baseUrl = 'http://10.0.2.2:9001/review';  //로컬 호스트
  // static const baseUrl = 'http://192.168.33.7:9001/review';  //작업실
  // static const baseUrl = 'http://172.30.1.69:9001/review';  //집
  // static const baseUrl = 'http://192.168.101.2:9001/review'; //기기 사용 3층
  // static const baseUrl = 'http://192.168.100.42:9001/review'; //기기 사용 5층
  static const baseUrl = 'http://203.229.171.79:84/review'; //기기 사용 5층
  // static const baseUrl = 'http://192.168.0.168:9001/review'; //5층 소셜캠퍼스

  ReviewApi({http.Client? client}) : _client = (client ?? http.Client());

  Future<http.Response> getReviews(String toIdx) async{
    String url = '$baseUrl/get_reviews.php';
    Map<String, dynamic> data = {
      'toIdx' : toIdx,
    };

    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${response.body}');

    return response;
  }
}