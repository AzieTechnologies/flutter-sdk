import 'package:dev_pay/dev_pay.dart';
import 'package:dev_pay/models/payment_method.dart';
import 'package:dev_pay/rest_client.dart';

import 'models/payment_detail.dart';
import 'models/payment_intent.dart';

class PaymentManager {
  late RestClient client;
  late Config config;

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
    Map<String, dynamic> paymentMethodInfo() => {
          "payment_token": paymentToken,
          "type": "card",
          "amount": paymentDetail.amount,
          "currency": _StringifiedCurrency(paymentDetail.currency),
          "address": paymentDetail.billingAddress.toJSON()
        };


    Map<String, dynamic> jsonReqData() => {
      "PaymentMethodInfo": paymentMethodInfo(),
      "RequestDetails": _requestDetails()
    };

    var response = await client.post("/v1/paymentmethods/create", jsonReqData());
    PaymentMethod method = PaymentMethod.buildFromJson(response["PaymentMethodResponse"]);
    return method;
  }

  Future<PaymentIntent> createIntent(
      PaymentMethod method, PaymentDetail paymentDetail) async {
    Map<String, dynamic> paymentIntentsInfo() => {
          "capture_method": "automatic",
          "payment_method_types": ["card"],
          "amount": paymentDetail.amount,
          "currency": _StringifiedCurrency(paymentDetail.currency),
          "payment_method_id": method.getId(),
          "confirm": true,
          "metadata": paymentDetail.metaData
        };

    Map<String, dynamic> jsonReqData() => {
      "PaymentIntentsInfo": paymentIntentsInfo(),
      "RequestDetails": _requestDetails()
    };

    Map<String, String> headers = new Map();

    var response = await client.post("/v1/general/paymentintent", jsonReqData(),headers: headers);
    PaymentIntent intent = PaymentIntent.buildFromJson(response["PaymentIntentsResponse"]);
    return intent;
  }

  Map<String, dynamic> _requestDetails(){
    Map<String, dynamic> requestDetails = new Map();
    requestDetails["DevpayId"] = this.config.accountId;
    if (this.config.sandbox) {
      requestDetails["env"] = "sandbox";
    }
    requestDetails["token"] = this.config.accessKey;
    return requestDetails;
  }

  Future<String> paysafeAPIKey() async {
    Map<String, dynamic> jsonReqData() => {
      "RequestDetails": _requestDetails()
    };
    var response = await client.post("/v1/general.svc/paysafe/api-key", jsonReqData(),headers: new Map());
    var apiKey = response["provider_api_key"];
    return apiKey;
  }

  String _StringifiedCurrency(Currency currency) {
    String currencyPath = currency.toString().toLowerCase();
    return currencyPath.replaceAll("currency.","");
  }
}
