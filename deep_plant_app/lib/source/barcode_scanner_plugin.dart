import 'package:flutter/services.dart';

class BarcodeScannerPlugin {
  static const EventChannel _barcodeEventChannel =
      EventChannel('app.dsic.barcodetray.BARCODE_BR_DECODING_DATA');

  Stream<String> get barcodeDataStream {
    return _barcodeEventChannel
        .receiveBroadcastStream()
        .map<String>((dynamic event) => event.toString());
  }
}
