import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:structure/config/user_router.dart';
import 'package:structure/dataSource/local_data_source.dart';
import 'package:structure/dataSource/remote_data_source.dart';
import 'package:structure/model/meat_model.dart';
import 'package:structure/model/user_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await checkAutoLogin();
  runApp(const DeepPlantApp());
}

Future<void> checkAutoLogin() async {
  dynamic response = await LocalDataSource.getLocalData('auto.json');
  if (response != null) {
    Map<String, dynamic> data = response;
    if (data['auto'] != null) {
      // 로그인 진행
      if (await saveUserInfo(data['auto'])) {
        userModel.auto = true;
      }
    }
  }
}

// 유저 정보 저장
Future<bool> saveUserInfo(String userId) async {
  // 로그인 API 호출
  try {
    // 유저 정보 가져오기 시도
    dynamic userInfo = await RemoteDataSource.signIn(userId)
        .timeout(const Duration(seconds: 10));
    if (userInfo == null) {
      // 가져오기 실패
      return false;
    } else {
      // 가져오기 성공
      // 데이터 fetch
      userModel.fromJson(userInfo);
      print(userModel);
      // 육류 정보 생성자 id 저장
      meatModel.userId = userModel.userId;
      return true;
    }
  } catch (e) {
    return false;
  }
}

MeatModel meatModel = MeatModel();
UserModel userModel = UserModel();

// 라우팅
final _router = UserRouter.getRouter(meatModel, userModel);

class DeepPlantApp extends StatelessWidget {
  const DeepPlantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(720, 1280),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'DeepPlant-demo',
        routerConfig: _router,
      ),
    );
  }
}
