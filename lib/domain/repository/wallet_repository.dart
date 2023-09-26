abstract class WalletRepository {
  Future myWallet(String idx);

  Future getIncomeHistory(String idx);

  Future getDepositHistory(String idx);
}
