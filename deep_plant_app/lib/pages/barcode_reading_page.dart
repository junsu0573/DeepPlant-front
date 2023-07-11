import 'dart:async';

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
  late StreamSubscription<dynamic> _streamSubscription;

  @override
  void initState() {
    super.initState();
    _registerBroadcastReceiver();
    _startListeningForBarcodeData();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  void _registerBroadcastReceiver() {
    final stream =
        const EventChannel('app.dsic.barcodetray.BARCODE_BR_DECODING_DATA')
            .receiveBroadcastStream();

    _streamSubscription = stream.listen((event) {
      setState(() {
        final decodedData = event['EXTRA_BARCODE_DECODED_DATA'] as String;
        barcodeData = decodedData.isNotEmpty ? decodedData : 'NOT READ';
      });
    });
  }

  Future<void> _startListeningForBarcodeData() async {
    final intent = AndroidIntent(
      action: 'app.dsic.barcodetray.START_LISTENING_FOR_BARCODE_DATA',
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
