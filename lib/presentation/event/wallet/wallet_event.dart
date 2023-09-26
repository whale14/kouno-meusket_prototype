sealed class WalletEvent<T> {
  factory WalletEvent.myWallet(String idx) = MyWallet;

  factory WalletEvent.getIncomeHistory(String idx, String month, String type) = GetIncomeHistory;

  factory WalletEvent.getDepositHistory(String idx, String month, String type) = GetDepositHistory;
}

class MyWallet<T> implements WalletEvent<T> {
  final String idx;

  MyWallet(this.idx);
}

class GetIncomeHistory<T> implements WalletEvent<T> {
  final String idx;
  final String month;
  final String type;

  GetIncomeHistory(this.idx, this.month, this.type);
}

class GetDepositHistory<T> implements WalletEvent<T> {
  final String idx;
  final String month;
  final String type;

  GetDepositHistory(this.idx, this.month, this.type);
}
