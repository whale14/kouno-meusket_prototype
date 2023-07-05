import 'package:http/http.dart' as http;

class ChatApi {
  final http.Client _client;

  // static const baseUrl = 'http://10.0.2.2:9001/chat';  //로컬 호스트
  // static const baseUrl = 'http://192.168.33.7:9001/chat';  //작업실
  // static const baseUrl = 'http://172.30.1.69:9001/chat';  //집
  // static const baseUrl = 'http://192.168.101.2:9001/chat'; //기기 사용 3층
  static const baseUrl = 'http://192.168.100.42:9001/chat'; //기기 사용 5층

  ChatApi({http.Client? client}) : _client = (client ?? http.Client());

  Future<http.Response> getChatContents(String roomIdx) async{
    String url = '$baseUrl/get_chat_contents.php';
    Map<String, dynamic> data = {
      'roomIdx':roomIdx,
    };
    final response = await _client.post(Uri.parse(url), body: data);
    return response;
  }

  Future<http.Response> getChatRooms(String idx) async{
    String url = '$baseUrl/get_chat_rooms.php';
    Map<String, dynamic> data = {
      'idx':idx,
    };
    final response = await _client.post(Uri.parse(url), body: data);
    return response;
  }

  Future updateChatRead(String chatIdx) async{
    String url = '$baseUrl/update_chat_read.php';
    Map<String, dynamic> data = {
      'idx':chatIdx,
    };
    await _client.post(Uri.parse(url), body: data);
  }
}