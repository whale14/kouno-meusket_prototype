import 'package:test_project/domain/model/test/test.dart';

//추상클래스 함수 선언
abstract class TestRepository {
  Future<List<Test>> getTests();
}