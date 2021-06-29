import 'models/payment_detail.dart';
import 'rest_client.dart';

class Paysafe {
  late RestClient client;

  Paysafe(RestClient client) {
    this.client = client;
  }

  Future<String> tokenize(PaymentDetail paymentDetail) async {
    Map<String, dynamic> jsonObject = paymentDetail.toJSON();
    Map<String, dynamic> map =
        await client.post("/js/api/v1/tokenize", jsonObject);
    return map["paymentToken"];
  }
}
