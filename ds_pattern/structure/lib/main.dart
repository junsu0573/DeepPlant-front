import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/model/meat_model.dart';
import 'package:structure/model/user_model.dart';
import 'package:structure/screen/sign_in_screen.dart';
import 'package:structure/viewModel/sign_in_view_model.dart';

MeatModel meatModel = MeatModel();
UserModel userModel = UserModel();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DeepPlantApp(
    meatModel: meatModel,
    userModel: userModel,
  ));
}

class DeepPlantApp extends StatelessWidget {
  final MeatModel meatModel;
  final UserModel userModel;
  const DeepPlantApp({
    super.key,
    required this.meatModel,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(720, 1280),
      builder: (context, child) => MaterialApp(
          home: ChangeNotifierProvider(
        create: (context) => SignInViewModel(userModel: userModel),
        child: SignInScreen(userMdoel: userModel),
      )),
    );
  }
}
