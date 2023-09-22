import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:structure/model/meat_model.dart';
import 'package:structure/model/user_model.dart';
import 'package:structure/screen/complete_sign_up_screen.dart';
import 'package:structure/screen/insertion_user_info_screen.dart';
import 'package:structure/screen/sign_in_screen.dart';
import 'package:structure/viewModel/insertion_user_info_view_model.dart';
import 'package:structure/viewModel/sign_in_view_model.dart';

MeatModel meatModel = MeatModel();
UserModel userModel = UserModel();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const DeepPlantApp());
}

// 라우팅
final _router = GoRouter(
  initialLocation: '/complete-sign-up',
  routes: [
    GoRoute(
      path: '/sign-in',
      builder: (context, state) => ChangeNotifierProvider(
        create: (context) => SignInViewModel(userModel: userModel),
        child: const SignInScreen(),
      ),
    ),
    GoRoute(
      path: '/sign-up',
      builder: (context, state) => ChangeNotifierProvider(
        create: (context) => InsertionUserInfoViewModel(userModel: userModel),
        child: const InsertionUserInfoScreen(),
      ),
    ),
    GoRoute(
      path: '/complete-sign-up',
      builder: (context, state) => const CompleteSignUpScreen(),
    ),
  ],
);

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
