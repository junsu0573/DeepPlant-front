import 'dart:ui';
import 'dart:io';

import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class CreateQrcode extends StatefulWidget {
  const CreateQrcode({Key? key}) : super(key: key);

  @override
  State<CreateQrcode> createState() => _CreateQrcodeState();
}

class _CreateQrcodeState extends State<CreateQrcode> {
  final globalKey = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  Future<File> convert() async {
    // https://tkayyoo.tistory.com/85

    // globalkey를 이용하여, Render 대상의 객체를 찾게 된다. 이를 'RenderRepaintBoundary' 형식으로 지정한다.
    var boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    // boundary.toImage()를 이용하여 RenderRepaintBoundary로 지정된 위젯을 이미지로 캡쳐하게 된다. 이때 pixelRatio는 해상도의 정도이다.
    // pixelRatio는 픽셀 전환 비율로서, 현재 기기의 픽셀에 수치를 곱한 값으로 이미지의 픽셀이 결정된다.
    var image = await boundary.toImage(pixelRatio: 3);
    // 캡쳐된 이미지를 ByteData 형식으로 변환하게 되며, 대상은 png 형식의 바이트 데이터로 변환된다.
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    // 이후 ByteData 형식을 Uint8List 형식으로 추출하게 된다.
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    // 임시 파일의 경로를 지정하게 된다.
    final tempPath = (await getTemporaryDirectory()).path;
    // 경로 상에 'qr_code.png'로서 파일이 저장되게 된다. 또한 'imageFile' 변수에 할당된다.
    File imageFile = File('$tempPath/qr_code.png');
    // 이제 함수를 이용하여 'Uint8List' 형식의 이미지 데이터를 바이트 데이터를 이용하여 이미지 파일을 형성한다.
    await imageFile.writeAsBytes(pngBytes);
    // 변수를 반환시킨다.
    return imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            context.go('/qr');
          });
        },
        child: const Icon(Icons.qr_code),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              '관리번호',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              '000189843795-cattle-chuck-chuck',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '모든 등록이 완료되었습니다.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '데이터를 서버로 전송했습니다.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 40.0,
                right: 40.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        File ImageFile = await convert();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          RepaintBoundary(
                            key: globalKey,
                            child: QrImageView(
                              data: "000189843795-cattle-chuck-chuck",
                              version: QrVersions.auto,
                              size: 130,
                            ),
                          ),
                          Text(
                            'QR코드 인쇄',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: SaveButton(
                    onPressed: () {},
                    text: '홈으로 이동',
                    width: 305.w,
                    heigh: 104.h,
                    isWhite: false,
                  ),
                ),
                SizedBox(
                  width: 46.w,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: SaveButton(
                    onPressed: () {},
                    text: '추가정보 입력',
                    width: 305.w,
                    heigh: 104.h,
                    isWhite: false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
