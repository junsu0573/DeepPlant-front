package com.example.structure

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel

class MainActivity : FlutterActivity() {
    private val eventChannel = "com.example.structure/barcode"
    private var barcodeReceiver: BroadcastReceiver? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, eventChannel).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
                    registerBarcodeReceiver(events)
                }

                override fun onCancel(arguments: Any?) {
                    unregisterBarcodeReceiver()
                }
            }
        )
    }

    private fun registerBarcodeReceiver(eventSink: EventChannel.EventSink) {
        val filter = IntentFilter("app.dsic.barcodetray.BARCODE_BR_DECODING_DATA")
        barcodeReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                if (intent.action == "app.dsic.barcodetray.BARCODE_BR_DECODING_DATA") {
                    val symbologyIdent = BarcodeDeclaration.SYMBOLOGY_IDENT.fromInteger(
                        intent.getIntExtra("EXTRA_BARCODE_DECODED_SYMBOLE", -1)
                    )
                    val data =
                        if (symbologyIdent != BarcodeDeclaration.SYMBOLOGY_IDENT.NOT_READ) {
                            intent.getStringExtra("EXTRA_BARCODE_DECODED_DATA")
                        } else {
                            "NOT READ"
                        }
                    eventSink.success(data)
                }
            }
        }
        registerReceiver(barcodeReceiver, filter)
    }

    private fun unregisterBarcodeReceiver() {
        barcodeReceiver?.let { receiver ->
            unregisterReceiver(receiver)
            barcodeReceiver = null
        }
    }
}
