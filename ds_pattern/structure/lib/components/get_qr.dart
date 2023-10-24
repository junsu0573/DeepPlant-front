import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class GetQr extends StatefulWidget {
  const GetQr({
    super.key,
  });

  @override
  State<GetQr> createState() => _GetQrState();
}

class _GetQrState extends State<GetQr> {
  // 아래의 두 변수는 최종적인 결과를 저장한다. Barcode 클래스는 code와 format으로 이루어진다.
  // format은 QR or barcode의 구분을 결정하며, code에는 정보가 담긴다. result는 클래스의 모든 정보를 담으며, result.code가 data에 저장된다.
  Barcode? result;
  String? data;
  // 카메라 작동 컨트롤러.
  QRViewController? controller;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    // 페이지가 작동할 때, 카메라를 초기화 한다.
    super.reassemble();
    controller!.pauseCamera();
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(
              title: const Text(
                'QR 스캔',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.black,
              centerTitle: true,
              elevation: 0.0,
              actions: [
                ElevatedButton(
                  onPressed: () {
                    controller!.pauseCamera();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 40.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Stack(children: [
        // 화면에 텍스트를 표현하기 위해 사용되었다.
        Column(
          children: <Widget>[
            Expanded(flex: 5, child: _buildQrView(context)),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(left: 10.0, right: 5.0),
                          child: Row(
                            children: [
                              (result != null)
                                  ? Text('${result!.code}')
                                  : const Text(
                                      'waiting to QRcode',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                      ),
                                    ),
                              const Spacer(
                                flex: 1,
                              ),
                              ElevatedButton.icon(
                                onPressed: (result != null)
                                    ? () {
                                        Navigator.pop(context, result!.code);
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                ),
                                icon: const Icon(Icons.add),
                                label: const Center(
                                  child: Text(
                                    '확인',
                                    style: TextStyle(
                                      fontSize: 11.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
        // 카메라 위에 내용을 올리기 위해 사용
        Positioned(
          bottom: (MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top) *
              0.24,
          right: (MediaQuery.of(context).size.width) * 0.29,
          child: const Text(
            '저장된 데이터 불러오기',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
        Positioned(
          bottom: (MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top) *
              0.19,
          right: (MediaQuery.of(context).size.width) * 0.22,
          child: const Text(
            'QR코드를 스캔하세요.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // var scanArea = (MediaQuery.of(context).size.width < 400 ||
    // MediaQuery.of(context).size.height < 400) ? 150.0 : 300.0;
    return QRView(
      // qr 화면 구성.
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        // 이는 qr을 스캔하는 화면 overlay를 구성한다.
        borderColor: Colors.white,
        // 경계의 둥근 정도
        borderRadius: 15,
        // 경계가 채워질 정도의 길이 -> cutOutSize의 절반보다 작으면 경계가 없는 부분이 존재.
        borderLength: 140,
        // 두께
        borderWidth: 3,
        // 전반적인 layout 크기
        cutOutSize: 280,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    // 실질적으로 정보를 인지하여 조정, 저장한다.
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      // dataStream을 listen하여, provider의 기능을 이용한다.
      // 이곳에 오는 scanData는 Barcode 클래스이다.
      setState(() {
        result = scanData;
        data = result!.code;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
