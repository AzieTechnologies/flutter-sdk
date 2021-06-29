class PaymentMethod {
  String getId() {
    return id;
  }

  String getType() {
    return type;
  }

  late String id;
  late String type;

  static PaymentMethod buildFromJson(Map<String, dynamic> map) {
    PaymentMethod paymentMethod = new PaymentMethod();
    paymentMethod.id = map["id"];
    paymentMethod.type = map["type"];
    return paymentMethod;
  }
}
