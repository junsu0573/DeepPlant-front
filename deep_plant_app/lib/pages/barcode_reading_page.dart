import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarcodeDisplayPage extends StatefulWidget {
  const BarcodeDisplayPage({super.key});

  @override
  _BarcodeDisplayPageState createState() => _BarcodeDisplayPageState();
}

class _BarcodeDisplayPageState extends State<BarcodeDisplayPage> {
  String barcodeData = 'NOT READ';
  List<String> scannedBarcodes = []; // 바코드 데이터를 저장할 리스트

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
          scannedBarcodes.add(barcodeData); // 바코드 데이터를 리스트에 추가
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Display'),
      ),
      body: ListView.builder(
        itemCount: scannedBarcodes.length,
        itemBuilder: (context, index) {
          final barcode = scannedBarcodes[index];
          return ListTile(
            title: Text(barcode),
          );
        },
      ),
    );
  }
}
