import 'package:flutter/services.dart';

class BarcodeScannerPlugin {
  static const EventChannel _eventChannel =
      EventChannel('app.dsic.barcodetray.BARCODE_BR_DECODING_DATA');

  static Stream<String> get barcodeDataStream {
    return _eventChannel.receiveBroadcastStream().map<String>((event) {
      final Map<String, dynamic> eventData = event as Map<String, dynamic>;
      final barcodeData = eventData['EXTRA_BARCODE_DECODED_DATA'] as String?;
      return barcodeData ?? '';
    });
  }
}
