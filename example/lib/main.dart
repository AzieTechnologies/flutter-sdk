import 'package:flutter/material.dart';
import 'package:dev_pay/dev_pay.dart' as devpay;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevpaySDK Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'DevpaySDK Sample'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final amountTfController = TextEditingController();


  void _pay(){

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
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(padding:EdgeInsets.all(30),  child:
            TextField(
              controller: amountTfController, decoration: const InputDecoration(
              hintText: 'Amount',
            ))),
            Padding(
              padding: EdgeInsets.all(30),
              child: ElevatedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  _pay();
                },
                child: const Text('Pay'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
