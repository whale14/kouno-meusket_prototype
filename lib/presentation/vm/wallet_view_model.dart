import 'package:flutter/material.dart';
import 'package:test_project/domain/repository/wallet_repository.dart';
import 'package:test_project/presentation/event/wallet/wallet_event.dart';
import 'package:test_project/presentation/state/wallet/wallet_state.dart';

class WalletViewModel with ChangeNotifier {
  final WalletRepository _walletRepository;
  var _walletState = WalletState();

  WalletViewModel(this._walletRepository);

  WalletState get walletState => _walletState;

  Future onWalletEvent(WalletEvent event) async {

    switch(event){
      case MyWallet(): _myWallet(event.idx);
      case GetIncomeHistory(): _getIncomeHistory(event.idx, event.month);
      case GetDepositHistory(): _getDepositHistory(event.idx, event.month);
    }
  }

  Future _myWallet(String idx) async{
    final result = _walletRepository.myWallet(idx);
    _walletState = walletState.copyWith(wallet: await result);
    notifyListeners();
  }

  Future _getIncomeHistory(String idx, String month) async{
    final result = _walletRepository.getIncomeHistory(idx, month);
    _walletState = walletState.copyWith(incomes: await result);
    notifyListeners();
  }

  Future _getDepositHistory(String idx, String month) async{
    final result = _walletRepository.getDepositHistory(idx, month);
    _walletState = walletState.copyWith(deposits: await result);
    notifyListeners();
  }
}