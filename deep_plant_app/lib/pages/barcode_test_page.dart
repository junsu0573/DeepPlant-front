import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarcodeTest extends StatefulWidget {
  const BarcodeTest({super.key});

  @override
  State<BarcodeTest> createState() => _BarcodeTestState();
}

class _BarcodeTestState extends State<BarcodeTest> {
  EventChannel? _eventChannel;
  StreamSubscription<dynamic>? _eventSubscription;
  String _barcodeData = 'No Data';

  @override
  void initState() {
    super.initState();
    super.initState();
    _eventChannel = EventChannel('com.example.deep_plant_app/barcode');
    _eventSubscription =
        _eventChannel!.receiveBroadcastStream().listen((dynamic event) {
      setState(() {
        _barcodeData = event.toString();
      });
    });
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('barcode')),
      body: Center(
        child: Text(_barcodeData),
      ),
    );
  }
}
