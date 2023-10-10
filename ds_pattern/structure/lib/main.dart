import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:structure/config/user_router.dart';
import 'package:structure/model/meat_model.dart';
import 'package:structure/model/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting();

  runApp(const DeepPlantApp());
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
