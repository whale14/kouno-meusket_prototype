import 'package:http/http.dart' as http;
class MeusketApi {
  final http.Client _client;

  // static const baseUrl = 'http://10.0.2.2:9001'; //로컬 호스트
  static const baseUrl = 'http://192.168.101.2:9001'; //기기 사용

  MeusketApi({http.Client? client}) : _client = (client ?? http.Client());

  //test
  Future<http.Response> getTest() async {
    return await _client.get(Uri.parse('$baseUrl/get_tests.php'));
  }
}