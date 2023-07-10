import 'package:barcode_scanner_plugin/barcode_scanner_plugin.dart';
import 'package:flutter/material.dart';

class BarcodeReading extends StatefulWidget {
  const BarcodeReading({super.key});

  @override
  State<BarcodeReading> createState() => _BarcodeReadingState();
}

class _BarcodeReadingState extends State<BarcodeReading> {
  final Stream<String> _barcodeDataStream =
      BarcodeScannerPlugin.barcodeDataStream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Reader'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(Icons.restore))
        ],
      ),
      body: Center(
        child: StreamBuilder<String>(
          stream: _barcodeDataStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Text(
                snapshot.data!,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              );
            } else {
              return Text(
                'No barcode data',
                style: TextStyle(fontSize: 18),
              );
            }
          },
        ),
      ),
    );
  }
}
