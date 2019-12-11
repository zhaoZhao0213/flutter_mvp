class BillDetails {
  int billId;
  String payType;

  ///支付类型  微信  支付宝
  String exchengeMoney;

  ///交易金额
  int billType;

  ///账单类型  收款：0  退款：1
  String ordernumber;

  ///订单编号
  String exchangeTime;

  ///交易时间

  BillDetails(int billId, String payType, int billType, String ordernumber,
      String exchengeMoney, String exchangeTime) {
    this.billId = billId;
    this.payType = payType;
    this.exchengeMoney = exchengeMoney;
    this.billType = billType;
    this.ordernumber = ordernumber;
    this.exchangeTime = exchangeTime;
  }
}
