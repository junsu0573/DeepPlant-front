import 'dart:async';

import 'package:deep_plant_app/source/barcode_scanner_plugin.dart';
import 'package:flutter/material.dart';

class BarcodeReaderPage extends StatefulWidget {
  const BarcodeReaderPage({super.key});

  @override
  _BarcodeReaderPageState createState() => _BarcodeReaderPageState();
}

class _BarcodeReaderPageState extends State<BarcodeReaderPage> {
  final BarcodeScannerPlugin _barcodeScannerPlugin = BarcodeScannerPlugin();
  StreamSubscription<String>? _barcodeDataStreamSubscription;
  String _barcodeData = '';

  @override
  void initState() {
    super.initState();
    _barcodeDataStreamSubscription =
        _barcodeScannerPlugin.barcodeDataStream.listen((String barcodeData) {
      setState(() {
        _barcodeData = barcodeData;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _barcodeDataStreamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Reader'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Barcode Data:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              _barcodeData,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
