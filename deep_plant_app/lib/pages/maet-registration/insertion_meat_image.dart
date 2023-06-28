import 'dart:io';

import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class InsertionMeatImage extends StatefulWidget {
  final MeatData meatData;
  const InsertionMeatImage({
    super.key,
    required this.meatData,
  });

  @override
  State<InsertionMeatImage> createState() => _InsertionMeatImageState();
}

class _InsertionMeatImageState extends State<InsertionMeatImage> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  File? pickedImage;
  bool isLoading = false;
  bool isFinal = false;
  bool isImageAssigned = false;
  late DateTime now;
  String year = '';
  String month = '';
  String day = '';

  // user 정보 가져오기
  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  // 이미지 촬영을 위한 메소드
  void _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );

    setState(() {
      isLoading = true; // 로딩 활성화

      if (pickedImageFile != null) {
        // pickedImage에 촬영한 이미지를 달아놓는다.
        pickedImage = File(pickedImageFile.path);
        now = DateTime.now();
        year = now.year.toString();
        month = now.month.toString();
        day = now.day.toString();
        isImageAssigned = true;
      }
    });

    setState(() {
      isLoading = false; // 로딩 비활성화
    });
  }

  // 이미지를 firebase storage에 저장하는 비동기 함수
  Future<void> saveImage() async {
    setState(() {
      isLoading = true;
    });
    try {
      // 이미지를 firbaseStorage에 userid/시간.png 형식으로 저장

      // 이미지 이름 생성!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      final refImage =
          FirebaseStorage.instance.ref().child('${loggedUser!.uid}.png');

      await refImage.putFile(pickedImage!);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  void saveDate(
      MeatData meatData, File? image, String year, String month, String day) {
    meatData.imageFile = image;
    meatData.date = '{$year}-{$month}-{$day}';
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        backButton: false,
        closeButton: true,
      ),
      body: Column(
        children: [
          Text(
            '육류 단면 촬영',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: 20.0,
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.info_outline,
                    color: Colors.grey[600],
                    size: 25.0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '촬영날짜',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color:
                          isImageAssigned ? Colors.grey[800] : Colors.grey[400],
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                    height: 40.0,
                    child: Text(
                      isImageAssigned ? '$month월' : '월',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color:
                          isImageAssigned ? Colors.grey[800] : Colors.grey[400],
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                    height: 40.0,
                    child: Text(
                      isImageAssigned ? '$day일' : '일',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color:
                          isImageAssigned ? Colors.grey[800] : Colors.grey[400],
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                    height: 40.0,
                    child: Text(
                      isImageAssigned ? year : '년도',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '촬영자',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                SizedBox(
                  width: isImageAssigned
                      ? (MediaQuery.of(context).size.width - 150.0)
                      : 5.0,
                  child: isImageAssigned
                      ? Text('홍길동(HKD***@naver.com)')
                      : Divider(
                          color: Colors.black,
                          thickness: 1.5,
                        ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8 - 100,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: pickedImage != null
                      ? Image.file(
                          pickedImage!,
                          fit: BoxFit.cover,
                        )
                      : ElevatedButton(
                          onPressed: () {
                            _pickImage();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Colors.grey,
                          ),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 80.0,
                            color: Colors.grey,
                          ),
                        ),
                ),
                if (pickedImage != null)
                  Positioned(
                    top: 10,
                    right: 40,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          pickedImage = null;
                          isImageAssigned = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.black87,
                          size: 28.0,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          isLoading ? const CircularProgressIndicator() : Container(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Transform.translate(
              offset: Offset(0, 0),
              child: SizedBox(
                height: 55,
                width: 350,
                child: ElevatedButton(
                  onPressed: pickedImage != null
                      ? () async {
                          //await saveImage();
                          saveDate(
                              widget.meatData, pickedImage, year, month, day);
                          context.go('/option/show-step');
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    disabledBackgroundColor: Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    '저장',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
