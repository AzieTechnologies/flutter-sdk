import 'billing_address.dart';
import 'card.dart';

enum Currency {
  USD,
  AUD,
  CAD,
  DKK,
  EUR,
  HKD,
  JPY,
  NZD,
  NOK,
  GBD,
  ZAR,
  SEK,
  XCHF
}


class PaymentDetail {
  late int amount;
  late Currency currency;
  late String name;
  late BillingAddress billingAddress;
  late Card card;
  Map metaData = new Map();

  PaymentDetail(String name, int amount, Currency currency, Card card,
      BillingAddress billingAddress) {
    this.amount = amount;
    this.currency = currency;
    this.name = name;
    this.billingAddress = billingAddress;
    this.card = card;
  }

  Map<String, dynamic> toJSON() => {
        'amount': amount,
        'currency': currency.toString(),
        'name': name,
        'card': card.toJSON(),
        'billingAddress': billingAddress.toJSON()
      };
}
