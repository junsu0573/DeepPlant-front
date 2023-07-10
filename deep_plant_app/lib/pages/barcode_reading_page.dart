import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';

class BarcodeDecodingEvent {
  final int symbology;
  final String decodedData;

  BarcodeDecodingEvent(this.symbology, this.decodedData);
}

class BarcodeDisplayPage extends StatefulWidget {
  const BarcodeDisplayPage({super.key});

  @override
  _BarcodeDisplayPageState createState() => _BarcodeDisplayPageState();
}

class _BarcodeDisplayPageState extends State<BarcodeDisplayPage> {
  String barcodeData = 'NOT READ';
  EventBus eventBus = EventBus();

  @override
  void initState() {
    super.initState();
    eventBus.on<BarcodeDecodingEvent>().listen((event) {
      setState(() {
        if (event.symbology != -1) {
          barcodeData = "[${event.symbology}] ${event.decodedData}";
        } else {
          barcodeData = 'NOT READ';
        }
      });
    });
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
