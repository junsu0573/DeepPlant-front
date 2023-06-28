import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:deep_plant_app/source/widget_source.dart';

class GetQrPage extends StatefulWidget {
  const GetQrPage({super.key});

  @override
  State<GetQrPage> createState() => _GetQrPageState();
}

class _GetQrPageState extends State<GetQrPage> {
  // 이는 최종적인 결과를 저장한다. Barcode 클래스는 code와 format으로 이루어진다.
  // 당연히 format은 QR or barcode로 구분되며, code에는 결과, 즉 담긴 정보가 지정된다. (우리는 String, 일반적으로 url)
  Barcode? result;
  String? data;
  // 이는 카메라 작동을 제어한다.
  QRViewController? controller;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    // 이는 페이지가 시작될 때 기본적으로 카메라를 멈춘다. 이후 재시작한다.
    super.reassemble();
    controller!.pauseCamera();
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(
              leadingWidth: 170,
              title: Text(
                'QR 스캔',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.black,
              centerTitle: true,
              elevation: 0.0,
              actions: [
                // ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.black,
                //     ),
                //     onPressed: () async {
                //       await controller?.pauseCamera();
                //     },
                //     child: Icon(
                //       Icons.last_page,
                //       color: Colors.white,
                //       size: 40.0,
                //     )),
                // ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.black,
                //     ),
                //     onPressed: () async {
                //       await controller?.resumeCamera();
                //     },
                //     child: Icon(
                //       Icons.start,
                //       color: Colors.white,
                //       size: 40.0,
                //     )),
                elevated(
                  icon: Icons.close,
                  colorb: Colors.black,
                  colori: Colors.white,
                  size: 40.0,
                ),
              ],
            ),
          ],
        ),
      ),
      body: Stack(children: [
        Column(
          children: <Widget>[
            Expanded(flex: 5, child: _buildQrView(context)),
            Expanded(
              flex: 1,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // 'Barcode Type: ${describeEnum(result!.format)} -> 이는 enum 클래스 고유 기능으로,
                    // enum 클래스를 통해 얻은 정보는 클래스 명 까지 나오기에, 이를 제거해준다. 우린 필요없는 기능이다.
                    if (result != null) Text('Data: ${result!.code}') else Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(4),
                          height: 25.0,
                          width: 50.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              await controller?.pauseCamera();
                            },
                            child: const Text('pause',
                                style: TextStyle(
                                  fontSize: 5,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(4),
                          height: 25.0,
                          width: 50.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              await controller?.resumeCamera();
                            },
                            child: const Text('resume',
                                style: TextStyle(
                                  fontSize: 5,
                                  color: Colors.black,
                                )),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        // 카메라 위에 내용을 올리기 위해 사용
        Positioned(
          bottom: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 0.24,
          right: (MediaQuery.of(context).size.width) * 0.29,
          child: Text(
            '저장된 데이터 불러오기',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
        Positioned(
          bottom: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 0.19,
          right: (MediaQuery.of(context).size.width) * 0.22,
          child: Text(
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
      // 이는 qr 화면을 구성한다.
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
