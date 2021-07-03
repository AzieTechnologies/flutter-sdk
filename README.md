# Devpay flutter SDK
A Flutter SDK for Devpay Payment Gateway Get your API Keys at https://devpay.io

## Integration


```shell
flutter pub add dev_pay
```


## Make payment
### Using built-in UI
#### Showing the payment UI
Devpay SDK provided handy UI to get payment inputs, please refer below code.
```dart
devpay.Config config = new devpay.Config("ACC_ID",
    "SHEARABLE_KEY",
    "ACCESS_KEY");
config.debug = true;
config.sandbox = true;
devpay.DevpayModal devpayModal = devpay.DevpayModal(config: config, amount: 100);
devpayModal.btnText = "PAY "+amountTfController.text+" \$";
devpayModal.onCompletion = (intent,error) {

    if (error != null) {
    print("Err - "+error.toString());
    }

    if (intent != null) {
        print("intent - " + intent.status);
        devpayModal.dismiss(context);
    }
};
devpayModal.show(context);

```
> Amount & Currency are mandatory inputs, please make sure its provided correctly

#### Set Custom Pay title
By default inbuilt UI shows pay button text as 'PAY', you can change the text as required. Below snippets gives an example to do so. 
```java
devpayModal.btnText =  "PAY <AMOUNT> $";
```

### Using Devpay APIs with your own UI
In-case you want to use own UI to get payment details from the user, you are free to do so. Use below APIs to create payment details form your custom UI & confirm the payment.
```dart
BillingAddress address =
    BillingAddress("street",
    "city",
    "zipTf",
    "state",
    "country");

devpay.Card card =
    devpay.Card("XXXXYYYYXXXXYYYY",
            "MM", 
            "YYYY", 
            "123");

devpay.PaymentDetail paymentDetail = new devpay.PaymentDetail(
    "name",
    <amount>,
    devpay.Currency.USD,
    card,
    address);

devpay.Config config = ...;
devpay.DevPayClient client = new devpay.DevPayClient(config);

client.confirmPayment(paymentDetail)
    .then((paymentIntent) => {
        // Use paymentIntent 
    })
    .onError((error, stackTrace) => {
        // Read thee error
});
```
