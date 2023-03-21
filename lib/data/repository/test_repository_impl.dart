import 'dart:convert';

import 'package:test_project/data/source/remote/test_api.dart';
import 'package:test_project/domain/model/test/test.dart';
import 'package:test_project/domain/repository/test_repository.dart';

//API 연결
class TestRepositoryImpl implements TestRepository {
  MeusketApi api;

  TestRepositoryImpl(this.api);

  @override
  Future<List<Test>> getTests() async {
    // TODO: implement getTests
    final response = await api.getTest();
    final Iterable json = jsonDecode(response.body);
    return json.map((e) => Test.fromJson(e)).toList();
  }

}