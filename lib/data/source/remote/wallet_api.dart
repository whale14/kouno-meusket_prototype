import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:test_project/domain/model/work_category.dart';

class WalletApi {
  final http.Client _client;

  static const baseUrl = 'http://203.229.171.79:84/wallet'; //기기 사용 5층

  WalletApi({http.Client? client}) : _client = (client ?? http.Client());

  //내 지갑 불러오기 -> look_around에서 이용?
  Future<http.Response> myWallet(String idx) async {
    String url = '$baseUrl/my_wallet.php';
    Map<String, dynamic> data = {'idx': idx};
    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d('#########myWalletApi : ${response.body}');
    return response;
  }

  Future<http.Response> getIncomeHistory(String idx, String month) async {
    String url = '$baseUrl/income_history.php';
    Map<String, dynamic> data = {'idx': idx, 'incomeAt': month};
    final response = await _client.post(Uri.parse(url), body: data);
    return response;
  }

  Future<http.Response> getDepositHistory(String idx, String month) async {
    String url = '$baseUrl/deposit_history.php';
    Map<String, dynamic> data = {'idx': idx, 'depositAt': month};
    final response = await _client.post(Uri.parse(url), body: data);
    return response;
  }
}
