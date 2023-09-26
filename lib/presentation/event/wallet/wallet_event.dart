sealed class WalletEvent<T> {
  factory WalletEvent.myWallet(String idx) = MyWallet;
}

class MyWallet<T> implements WalletEvent<T> {
  final String idx;

  MyWallet(this.idx);
}