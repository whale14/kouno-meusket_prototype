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
    }
  }

  Future _myWallet(String idx) async{
    final result = _walletRepository.myWallet(idx);
    _walletState = walletState.copyWith(wallet: await result);
    notifyListeners();
  }
}