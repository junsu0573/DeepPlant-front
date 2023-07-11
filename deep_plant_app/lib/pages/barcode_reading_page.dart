import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:android_intent/android_intent.dart';

class BarcodeDisplayPage extends StatefulWidget {
  const BarcodeDisplayPage({super.key});

  @override
  _BarcodeDisplayPageState createState() => _BarcodeDisplayPageState();
}

class _BarcodeDisplayPageState extends State<BarcodeDisplayPage> {
  String barcodeData = 'NOT READ';

  @override
  void initState() {
    super.initState();
    handleBarcodeDecoded();
  }

  Future<void> handleBarcodeDecoded() async {
    const platform = MethodChannel('barcode_intent_channel');
    platform.setMethodCallHandler((call) async {
      if (call.method == 'onBarcodeDecoded') {
        setState(() {
          barcodeData = call.arguments;
        });
      }
    });

    // Android의 Broadcast Intent 수신
    AndroidIntent intent =
        AndroidIntent(action: 'app.dsic.barcodetray.BARCODE_BR_DECODING_DATA');
    intent.launch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Display'),
      ),
      body: Center(
        child: Text(
          barcodeData,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
