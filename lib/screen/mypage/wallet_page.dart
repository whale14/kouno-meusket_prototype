import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/presentation/vm/user_view_model.dart';

class WalletPage extends StatelessWidget {

  const WalletPage({super.key,});



  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UserViewModel>();
    final walletState = viewModel.walletState;


    return Scaffold(
      appBar: AppBar(
        title: Text('내지갑'),
      ),
      body: Center(
        child: Text('포인트 : ${walletState.wallet!.money}'),
      ),
    );
  }
}
