sealed class WalletEvent<T> {
  factory WalletEvent.myWallet(String idx) = MyWallet;

  factory WalletEvent.getIncomeHistory(String idx, String month) = GetIncomeHistory;

  factory WalletEvent.getDepositHistory(String idx, String month) = GetDepositHistory;
}

class MyWallet<T> implements WalletEvent<T> {
  final String idx;

  MyWallet(this.idx);
}

class GetIncomeHistory<T> implements WalletEvent<T> {
  final String idx;
  final String month;

  GetIncomeHistory(this.idx, this.month);
}

class GetDepositHistory<T> implements WalletEvent<T> {
  final String idx;
  final String month;

  GetDepositHistory(this.idx, this.month);
}
