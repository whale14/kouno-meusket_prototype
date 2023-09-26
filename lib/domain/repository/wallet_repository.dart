abstract class WalletRepository {
  Future myWallet(String idx);

  Future getIncomeHistory(String idx, String month, String type);

  Future getDepositHistory(String idx, String month, String type);
}
