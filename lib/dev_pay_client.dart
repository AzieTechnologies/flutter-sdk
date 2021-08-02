import 'package:dev_pay/models/payment_detail.dart';
import 'package:dev_pay/payment_manager.dart';
import 'package:dev_pay/paysafe.dart';
import 'package:dev_pay/rest_client.dart';

import 'models/payment_intent.dart';

class Config {
  late String accountId;
  late String accessKey;
  late String shareableKey;
  late bool sandbox = false;
  late bool debug = false;

  Config(String accountId, String shareableKey, String accessKey) {
    this.accountId = accountId;
    this.shareableKey = shareableKey;
    this.accessKey = accessKey;
  }
}

class DevPayClient {
  late Config config;

  late PaymentManager manager;
  late Paysafe paysafeAPI;

  DevPayClient(Config config) {
    this.config = config;
    RestClient client = paymentManagerRestClient();
    manager = PaymentManager(client);
    manager.config = config;
  }

  Future<PaymentIntent> confirmPayment(PaymentDetail paymentDetail) async {
    String apiKey = await manager.paysafeAPIKey();

    paysafeAPI = Paysafe(paysafeRestClient(apiKey));
    String token = await paysafeAPI.tokenize(paymentDetail);
    return manager.confirmPayment(token, paymentDetail);
  }

  RestClient paymentManagerRestClient(){
    Map<String, String> headers = new Map();
    headers["Content-Type"] = "application/json";

    String baseURL = "https://api.devpay.io";
    RestClient client = new RestClient(baseURL, headers, config.debug);
    client.debug = config.debug;
    return client;
  }

  RestClient paysafeRestClient(String key){

    String baseURL = "https://hosted.paysafe.com";
    if (config.sandbox) {
      baseURL = "https://hosted.test.paysafe.com";
    }

    Map<String, String> headers = new Map();
    headers["X-Paysafe-Credentials"] = "Basic " + key;
    headers["Content-Type"] = "application/json";

    RestClient client = new RestClient(baseURL, headers,config.debug);
    client.debug = config.debug;
    return client;
  }
}
