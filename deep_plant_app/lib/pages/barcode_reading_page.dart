import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:android_intent/android_intent.dart';

class BarcodeDisplayPage extends StatefulWidget {
  const BarcodeDisplayPage({Key? key}) : super(key: key);

  @override
  _BarcodeDisplayPageState createState() => _BarcodeDisplayPageState();
}

class _BarcodeDisplayPageState extends State<BarcodeDisplayPage> {
  String barcodeData = 'NOT READ';
  late MethodChannel _methodChannel;

  @override
  void initState() {
    super.initState();
    _methodChannel = const MethodChannel('barcode_intent_channel');
    _methodChannel.setMethodCallHandler((call) async {
      if (call.method == 'onBarcodeDecoded') {
        setState(() {
          barcodeData = call.arguments as String;
        });
      }
    });
    handleBarcodeDecoded();
  }

  Future<void> handleBarcodeDecoded() async {
    final intent = AndroidIntent(
      action: 'app.dsic.barcodetray.BARCODE_BR_DECODING_DATA',
    );
    await intent.launch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode Display'),
      ),
      body: Center(
        child: Text(
          barcodeData,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
