sealed class WalletEvent<T> {
  factory WalletEvent.myWallet(String idx) = MyWallet;

  factory WalletEvent.getIncomeHistory(String idx) = GetIncomeHistory;

  factory WalletEvent.getDepositHistory(String idx) = GetDepositHistory;
}

class MyWallet<T> implements WalletEvent<T> {
  final String idx;

  MyWallet(this.idx);
}

class GetIncomeHistory<T> implements WalletEvent<T> {
  final String idx;

  GetIncomeHistory(this.idx);
}

class GetDepositHistory<T> implements WalletEvent<T> {
  final String idx;

  GetDepositHistory(this.idx);
}
