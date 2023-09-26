import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:test_project/presentation/event/wallet/wallet_event.dart';
import 'package:test_project/presentation/vm/wallet_view_model.dart';

class WalletPage extends StatefulWidget {
  final String userIdx;

  const WalletPage({Key? key, required this.userIdx}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState(userIdx: userIdx);
}

class _WalletPageState extends State<WalletPage>{
  final String userIdx;

  _WalletPageState({required this.userIdx});

  @override
  Widget build(BuildContext context) {
    final WalletViewModel viewModel = context.watch<WalletViewModel>();
    final walletState = viewModel.walletState;

    return Scaffold(
      appBar: AppBar(
        title: const Text('충전/사용내역'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [Text('보유 예치금'), Text('${walletState.wallet?.deposit ?? 0}원')],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [Text('보유 수익금'), Text('${walletState.wallet?.income ?? 0}원')],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ],
              ),
            ),
          ),
          // CustomScrollView(
          //   physics: BouncingScrollPhysics(),
          // ),
        ],
      ),
    );
  }
}
