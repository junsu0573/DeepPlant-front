package com.example.deep_plant_app
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class BarcodeBroadcastReceiver : BroadcastReceiver() {
    companion object {
        private const val BARCODE_ACTION = "app.dsic.barcodetray.BARCODE_BR_DECODING_DATA"
    }

    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent?.action == BARCODE_ACTION) {
            val symbologyIdent = intent.getStringExtra("EXTRA_BARCODE_DECODED_SYMBOLE")
            val decodedData = intent.getStringExtra("EXTRA_BARCODE_DECODED_DATA")

            // 바코드 데이터를 Flutter로 전달하는 코드를 작성합니다.
            val flutterIntent = Intent("barcode_intent_channel")
            flutterIntent.putExtra("barcodeData", decodedData)
            context?.sendBroadcast(flutterIntent)
        }
    }
}
