// barcode_reader_page.dart
import 'package:deep_plant_app/source/barcode_scanner_plugin.dart';
import 'package:flutter/material.dart';

class BarcodeReaderPage extends StatefulWidget {
  const BarcodeReaderPage({super.key});

  @override
  _BarcodeReaderPageState createState() => _BarcodeReaderPageState();
}

class _BarcodeReaderPageState extends State<BarcodeReaderPage> {
  final Stream<String> _barcodeDataStream =
      BarcodeScannerPlugin.barcodeDataStream;

  @override
  void initState() {
    super.initState();
    BarcodeScannerPluginImpl.initialize();
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
            StreamBuilder<String>(
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BarcodeScannerPlugin.startBarcodeScanning();
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}
