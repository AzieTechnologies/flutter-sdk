class PaymentIntent {
  late String accountId;
  late int amount;
  late int amountCapturable;
  late int amountReceived;

  String getAccountId() {
    return accountId;
  }

  int getAmount() {
    return amount;
  }

  int getAmountCapturable() {
    return amountCapturable;
  }

  int getAmountReceived() {
    return amountReceived;
  }

  String getCaptureMethod() {
    return captureMethod;
  }

  String getClientSecret() {
    return clientSecret;
  }

  String getCurrency() {
    return currency;
  }

  String getId() {
    return id;
  }

  String getStatus() {
    return status;
  }

  late String captureMethod;
  late String clientSecret;
  late String currency;
  late String id;
  late String status;

  static PaymentIntent buildFromJson(Map<String, dynamic> map) {
    PaymentIntent paymentIntent = new PaymentIntent();
    paymentIntent.accountId = map["account_id"];
    paymentIntent.amount = map["amount"];
    paymentIntent.amountCapturable = map["amount_capturable"];
    paymentIntent.amountReceived = map["amount_received"];
    paymentIntent.captureMethod = map["capture_method"];
    paymentIntent.clientSecret = map["client_secret"];
    paymentIntent.currency = map["currency"];
    paymentIntent.id = map["id"];
    paymentIntent.status = map["status"];
    return paymentIntent;
  }
}
