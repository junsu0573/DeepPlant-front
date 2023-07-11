import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

public class BarcodeBroadcastReceiver extends BroadcastReceiver {
    private static final String BARCODE_ACTION = "app.dsic.barcodetray.BARCODE_BR_DECODING_DATA";

    @Override
    public void onReceive(Context context, Intent intent) {
        if (intent.getAction().equals(BARCODE_ACTION)) {
            String symbologyIdent = intent.getStringExtra("EXTRA_BARCODE_DECODED_SYMBOLE");
            String decodedData = intent.getStringExtra("EXTRA_BARCODE_DECODED_DATA");

            // 바코드 데이터를 Flutter로 전달하는 코드를 작성합니다.
            Intent flutterIntent = new Intent("barcode_intent_channel");
            flutterIntent.putExtra("barcodeData", decodedData);
            context.sendBroadcast(flutterIntent);
        }
    }
}
