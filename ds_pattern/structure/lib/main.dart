import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:structure/model/meat_model.dart';
import 'package:structure/model/user_model.dart';
import 'package:structure/screen/complete_sign_up_screen.dart';
import 'package:structure/screen/freshmeat_eval_screen.dart';
import 'package:structure/screen/insertion_user_info_screen.dart';
import 'package:structure/screen/main_screen.dart';
import 'package:structure/screen/meat_registration_screen.dart';
import 'package:structure/screen/sign_in_screen.dart';
import 'package:structure/viewModel/freshmeat_eval_view_model.dart';
import 'package:structure/viewModel/insertion_user_info_view_model.dart';
import 'package:structure/viewModel/meat_registration_view_model.dart';
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
  initialLocation: '/main/registration/freshmeat',
  routes: [
    // 로그인
    GoRoute(
      path: '/sign-in',
      builder: (context, state) => ChangeNotifierProvider(
        create: (context) => SignInViewModel(userModel: userModel),
        child: const SignInScreen(),
      ),
    ),
    // 회원가입
    GoRoute(
      path: '/sign-up',
      builder: (context, state) => ChangeNotifierProvider(
        create: (context) => InsertionUserInfoViewModel(userModel: userModel),
        child: const InsertionUserInfoScreen(),
      ),
    ),
    // 회원가입 완료
    GoRoute(
      path: '/complete-sign-up',
      builder: (context, state) => const CompleteSignUpScreen(),
    ),
    // 메인 페이지
    GoRoute(
      path: '/main',
      builder: (context, state) => const MainScreen(),
      routes: [
        // 육류 등록 페이지
        GoRoute(
          path: 'registration',
          builder: (context, state) => ChangeNotifierProvider(
            create: (context) => MeatRegistrationViewModel(
                meatModel: meatModel, userModel: userModel),
            child: const MeatRegistrationScreen(),
          ),
          routes: [
            GoRoute(
              path: 'freshmeat',
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) =>
                    FreshMeatEvalViewModel(meatModel: meatModel),
                child: const FreshMeatEvalScreen(),
              ),
            ),
          ],
        ),
      ],
    )
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
