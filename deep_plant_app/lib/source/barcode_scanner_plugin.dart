// barcode_scanner_plugin.dart
import 'package:flutter/services.dart';

class BarcodeScannerPlugin {
  static const MethodChannel _methodChannel =
      MethodChannel('barcode_scanner_plugin/method');
  static const EventChannel _eventChannel =
      EventChannel('barcode_scanner_plugin/event');

  static Future<void> startBarcodeScanning() async {
    await _methodChannel.invokeMethod('startBarcodeScanning');
  }

  static Stream<String> get barcodeDataStream {
    return _eventChannel.receiveBroadcastStream().map<String>((dynamic event) {
      return event.toString();
    });
  }
}

// barcode_scanner_plugin_impl.dart
class BarcodeScannerPluginImpl {
  static const MethodChannel _methodChannel =
      MethodChannel('barcode_scanner_plugin/method');
  static const EventChannel _eventChannel =
      EventChannel('barcode_scanner_plugin/event');

  static void initialize() {
    _eventChannel.receiveBroadcastStream().listen((dynamic event) {
      // 바코드 결과를 전달받은 경우, 이벤트를 처리하는 로직 작성
      String barcodeData = event.toString();
      // 처리된 바코드 데이터를 활용하여 필요한 동작 수행
    });
  }

  static Future<void> startBarcodeScanning() async {
    await _methodChannel.invokeMethod('startBarcodeScanning');
  }
}
