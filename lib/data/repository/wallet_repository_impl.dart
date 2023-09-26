import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:test_project/data/source/remote/wallet_api.dart';
import 'package:test_project/domain/model/wallet/wallet.dart';
import 'package:test_project/domain/repository/wallet_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  WalletApi api;

  WalletRepositoryImpl(this.api);

  @override
  Future myWallet(String idx) async {
    // TODO: implement myWallet
    final response = await api.myWallet(idx);
    Logger().d("id : $idx, myWallet:${response.body}");
    final Iterable json = jsonDecode(response.body);
    Logger().d('json: ${json.first}');
    Wallet wallet = Wallet.fromJson(json.first);
    return wallet;
  }
}
