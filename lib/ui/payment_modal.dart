import 'dart:async';

import '../dev_pay.dart' as devpay;
import '../models/billing_address.dart';
import '../models/payment_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class DevpayModal {
  DevpayModal({required this.config, required this.amount});

  // Card details controller
  final cardnameTfController = TextEditingController();
  final expiryTfController = TextEditingController();
  final cvvTfController = TextEditingController();

  // Customer details controller
  final nameTfController = TextEditingController();
  final streetTfController = TextEditingController();
  final zipTfController = TextEditingController();
  final cityTfController = TextEditingController();
  final stateTfController = TextEditingController();
  final countryTfController = TextEditingController();

  devpay.PaymentDetail _pay() {
    String name = nameTfController.text;
    String street = streetTfController.text;
    String city = cityTfController.text;
    String zip = zipTfController.text;
    String state = stateTfController.text;
    String country = countryTfController.text;

    String cardNum = cardnameTfController.text;
    String expiry = expiryTfController.text;
    String expiryMonth = expiry.split("/")[0];
    String expiryYear = expiry.split("/")[1];
    String cvv = cvvTfController.text;

    BillingAddress address =
        BillingAddress(street, city, zip, state, country);

    devpay.Card card =
        devpay.Card(cardNum, expiryMonth, expiryYear, cvv);

    devpay.PaymentDetail paymentDetail = new devpay.PaymentDetail(
        name,
        amount,
        devpay.Currency.USD,
        card,
        address);
    return paymentDetail;
  }

  late final Function(PaymentIntent?, Object?) onCompletion;

  String btnText = "Pay";
  late int amount = 0;
  late devpay.Config config;
  devpay.Currency currency = devpay.Currency.USD;

  void _showLoader(context){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void _hideLoader(context){
    Navigator.pop(context);
  }

  dismiss(context){
    Navigator.pop(context);
  }

  show(context) {
    if (amount == 0) {
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      AlertDialog alert = AlertDialog(
        title: Text("Simple Alert"),
        content: Text("This is an alert message."),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
      return;
    }

    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      // should dialog be dismissed when tapped outside
      barrierLabel: "Modal",
      // label for barrier
      transitionDuration: Duration(milliseconds: 100),
      // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation

        final expiryTf = TextFormField(
          controller: expiryTfController,
          decoration: const InputDecoration(
            hintText: 'Expiry - MM/YYYY',
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter correct value';
            }
            return null;
          },
        );
        final cardNumberTf = TextFormField(
          controller: cardnameTfController,
          decoration: const InputDecoration(
            hintText: 'Card Number',
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter correct value';
            }
            return null;
          },
        );

        final cvvTf = TextFormField(
          controller: cvvTfController,
          decoration: const InputDecoration(
            hintText: 'CVV',
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter correct value';
            }
            return null;
          },
        );

        final nameTf = TextFormField(
          controller: nameTfController,
          decoration: const InputDecoration(
            hintText: 'Name',
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter correct value';
            }
            return null;
          },
        );

        final streetTf = TextFormField(
          controller: streetTfController,
          decoration: const InputDecoration(
            hintText: 'Street',
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter correct value';
            }
            return null;
          },
        );

        final cityTf = TextFormField(
          controller: cityTfController,
          decoration: const InputDecoration(
            hintText: 'City',
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter correct value';
            }
            return null;
          },
        );

        final zipTf = TextFormField(
          controller: zipTfController,
          decoration: const InputDecoration(
            hintText: 'Zip',
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter correct value';
            }
            return null;
          },
        );

        final stateTf = TextFormField(
          controller: stateTfController,
          decoration: const InputDecoration(
            hintText: 'State',
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter correct value';
            }
            return null;
          },
        );
        final countryTf = TextFormField(
          controller: countryTfController,
          decoration: const InputDecoration(
            hintText: 'Country',
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter correct value';
            }
            return null;
          },
        );

        return Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                leading: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                title: Text(
                  "Payment Details",
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: 'Overpass',
                      fontSize: 20),
                ),
                elevation: 0.0),
            backgroundColor: Colors.white.withOpacity(0.96),
            body: SingleChildScrollView(

              child: Form(
                key: _formKey,
                child: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: const Color(0xfff8f8f8),
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image(
                        image:
                        AssetImage('assets/card.png', package: 'dev_pay')),
                    Wrap(
                      spacing: 20,
                      // to apply margin in the main axis of the wrap
                      runSpacing: 20,
                      // to apply margin in the cross axis of the wrap
                      children: [
                        cardNumberTf,
                        Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(child: expiryTf),
                              SizedBox(
                                width: 16,
                              ),
                              Flexible(child: cvvTf)
                            ]),
                        nameTf,
                        streetTf,
                        Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(child: cityTf),
                              SizedBox(
                                width: 16,
                              ),
                              Flexible(child: zipTf)
                            ]),
                        stateTf,
                        countryTf,
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                        child: SizedBox(
                            height: 42,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(24, 5, 244, 1.0)),
                              child: Text(btnText),
                              onPressed: () {

                                if (_formKey.currentState!.validate()) {
                                  devpay.PaymentDetail paymentDetail =_pay();
                                  devpay.Config config = this.config;
                                  devpay.DevPayClient client = new devpay.DevPayClient(config);

                                  _showLoader(context);
                                  client.confirmPayment(paymentDetail)
                                      .then((paymentIntent) => {
                                    _hideLoader(context),
                                    onCompletion(paymentIntent, null),
                                  })
                                      .onError((error, stackTrace) => {
                                    _hideLoader(context),
                                    onCompletion(null, error)

                                  });
                                }
                              },
                            ))),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Image(
                            image: AssetImage('assets/powerd_by.png',
                                package: 'dev_pay'))),
                  ],
                ),
              ),),
            ));
      },
    );
  }
}
