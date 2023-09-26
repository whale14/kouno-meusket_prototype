import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:test_project/presentation/event/wallet/wallet_event.dart';
import 'package:test_project/presentation/vm/wallet_view_model.dart';

import '../../domain/model/wallet/deposit.dart';

class WalletPage extends StatefulWidget {
  final String userIdx;

  const WalletPage({Key? key, required this.userIdx}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState(userIdx: userIdx);
}

class _WalletPageState extends State<WalletPage> {
  final String userIdx;
  DateTime curDate = DateTime.now();

  _WalletPageState({required this.userIdx});

  void previousMonth() {
    setState(() {
      curDate = DateTime(curDate.year, curDate.month - 1);
    });
  }

  void nextMonth() {
    setState(() {
      curDate = DateTime(curDate.year, curDate.month + 1);
    });
  }

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('보유 예치금'),
                      Text('${walletState.wallet?.deposit ?? 0}원')
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('보유 수익금'),
                      Text('${walletState.wallet?.income ?? 0}원')
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.grey[200],
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 1.0),
              child: Row(children: [
                IconButton(
                  onPressed: (() => previousMonth()),
                  icon: const Icon(Icons.chevron_left),
                ),
                Expanded(
                    child: Center(
                        child: Text("${curDate.year}년 ${curDate.month}월"))),
                IconButton(
                  onPressed: (() => nextMonth()),
                  icon: const Icon(Icons.chevron_right),
                ),
              ]),
            ),
          )
          // CustomScrollView(
          //   physics: BouncingScrollPhysics(),
          // ),
        ],
      ),
    );
  }
  Widget buildListView(List<Deposit> deposits) {
    return SafeArea(child: Text('text'));
  }
}
