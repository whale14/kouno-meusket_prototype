import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:test_project/presentation/event/wallet/wallet_event.dart';
import 'package:test_project/presentation/state/wallet/wallet_state.dart';
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
  String type = '2';
  final List<String> payList = ["전체내역", "충전내역", "사용내역"];

  _WalletPageState({required this.userIdx});

  String formattedDate(DateTime date) {
    return DateFormat('yyyy-MM').format(date);
  }

  void previousMonth(WalletViewModel viewModel) async {
    setState(() {
      curDate = DateTime(curDate.year, curDate.month - 1);
    });
    await viewModel.onWalletEvent(
        WalletEvent.getDepositHistory(userIdx, formattedDate(curDate), type));
  }

  void nextMonth(WalletViewModel viewModel) async {
    setState(() {
      curDate = DateTime(curDate.year, curDate.month + 1);
    });
    await viewModel.onWalletEvent(
        WalletEvent.getDepositHistory(userIdx, formattedDate(curDate), type));
  }

  @override
  Widget build(BuildContext context) {
    final WalletViewModel viewModel = context.watch<WalletViewModel>();
    final walletState = viewModel.walletState;

    return Scaffold(
      appBar: AppBar(
        title: const Text('충전/사용내역'),
      ),
      body: walletState.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    key: Key('Card${curDate.year}-${curDate.month}'),
                    child: Card(
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
                  ),
                  SliverToBoxAdapter(
                    key: Key('Tab${curDate.year}-${curDate.month}'),
                    child: ClipRRect(
                      borderRadius: BorderRadius.zero,
                      child: Container(
                        color: Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 1.0),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: (() => previousMonth(viewModel)),
                                icon: const Icon(Icons.chevron_left),
                              ),
                              Expanded(
                                  child: Center(
                                      child: Text(
                                          "${curDate.year}년 ${curDate.month}월"))),
                              IconButton(
                                onPressed:
                                    (curDate.month == DateTime.now().month)
                                        ? null
                                        : (() => nextMonth(viewModel)),
                                icon: const Icon(Icons.chevron_right),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ];
              },
              body: buildListView(walletState),
            ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(
          Icons.sort,
          color: Colors.white,
        ),
        label: Text(
          payList[0],
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('조회하기'),
                    ),
                    Divider(),
                  ]..addAll(payList.map((String value) {
                      return ListTile(
                        title: Text(value),
                      );
                    }).toList()),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildListView(WalletState state) {
    return Scrollbar(
      child: state.deposits.isEmpty
          ? const Center(
              // alignment: Alignment.bottomCenter,
              child: Text('충전/사용내역이 없습니다.'),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              separatorBuilder: (context, index) => Divider(),
              itemCount: state.deposits.length,
              itemBuilder: (context, index) {
                final deposit = state.deposits[index];
                return ListTile(
                  title: deposit.deposit > 0 ? Text('예치금 충전') : Text('심부름 결제'),
                  subtitle: Text(deposit.depositAt),
                  trailing: Text(
                    '${deposit.deposit}원',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: deposit.deposit < 0 ? Colors.red : Colors.green),
                  ),
                );
              },
            ),
    );
  }
}
