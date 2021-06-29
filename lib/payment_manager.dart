import 'package:dev_pay/models/payment_method.dart';
import 'package:dev_pay/rest_client.dart';

import 'models/payment_detail.dart';
import 'models/payment_intent.dart';

class PaymentManager {
  late RestClient client;
  late String paymentIntentSecret;

  PaymentManager(RestClient client) {
    this.client = client;
  }

  Future<PaymentIntent> confirmPayment(
      String paymentToken, PaymentDetail paymentDetail) async {
    return createMethod(paymentToken, paymentDetail)
        .then((method) => createIntent(method, paymentDetail));
  }

  Future<PaymentMethod> createMethod(
      String paymentToken, PaymentDetail paymentDetail) async {
    Map<String, dynamic> jsonReqData() => {
          "payment_token": paymentToken,
          "type": "card",
          "amount": paymentDetail.amount,
          "currency": _StringifiedCurrency(paymentDetail.currency),
          "address": paymentDetail.billingAddress.toJSON()
        };

    var response = await client.post("/v1/payment-methods", jsonReqData());
    PaymentMethod method = PaymentMethod.buildFromJson(response);
    return method;
  }

  Future<PaymentIntent> createIntent(
      PaymentMethod method, PaymentDetail paymentDetail) async {
    Map<String, dynamic> jsonReqData() => {
          "capture_method": "automatic",
          "payment_method_types": ["card"],
          "amount": paymentDetail.amount,
          "currency": _StringifiedCurrency(paymentDetail.currency),
          "payment_method_id": method.getId(),
          "confirm": true,
          "metadata": paymentDetail.metaData
        };


    Map<String, String> headers = new Map();
    headers["Authorization"] = "Bearer " + paymentIntentSecret;

    var response = await client.post("/v1/payment-intents", jsonReqData(),headers: headers);
    PaymentIntent intent = PaymentIntent.buildFromJson(response);
    return intent;
  }

  Future<String> paysafeAPIKey() async {
    var response = await client.get("/v1/payment-providers/paysafe/api-key");
    var apiKey = response["provider_api_key"];
    return apiKey;
  }

  String _StringifiedCurrency(Currency currency) {
    String currencyPath = currency.toString().toLowerCase();
    return currencyPath.replaceAll("currency.","");
  }
}
