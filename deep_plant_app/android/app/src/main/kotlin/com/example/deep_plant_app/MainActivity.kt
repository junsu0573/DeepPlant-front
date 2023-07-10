package com.example.deep_plant_app

import io.flutter.embedding.android.FlutterActivity

import android.content.Intent
import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "barcode_intent_channel"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        handleBarcodeIntent(intent) // 앱이 이미 실행 중일 때 인텐트를 처리하기 위해 추가합니다.
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
            if (call.method == "handleBarcodeIntent") {
                handleBarcodeIntent(intent)
            }
        }
    }

    private fun handleBarcodeIntent(intent: Intent) {
        if (intent.action == "app.dsic.barcodetray.BARCODE_BR_DECODING_DATA") {
            // 바코드 인식 결과를 처리하는 코드를 작성합니다.
            val symbologyIdent = intent.getStringExtra("EXTRA_BARCODE_DECODED_SYMBOLE")
            val decodedData = intent.getStringExtra("EXTRA_BARCODE_DECODED_DATA")
            // 결과 데이터를 Flutter로 전달합니다.
            MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, CHANNEL).invokeMethod("onBarcodeDecoded", decodedData)
        }
    }
}

