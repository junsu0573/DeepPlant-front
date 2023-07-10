import 'package:flutter/material.dart';
import 'package:barcode_scanner_plugin/barcode_scanner_plugin.dart';

class BarcodeReaderPage extends StatefulWidget {
  const BarcodeReaderPage({super.key});

  @override
  _BarcodeReaderPageState createState() => _BarcodeReaderPageState();
}

class _BarcodeReaderPageState extends State<BarcodeReaderPage> {
  final Stream<String> _barcodeDataStream =
      BarcodeScannerPlugin.barcodeDataStream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Reader'),
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
