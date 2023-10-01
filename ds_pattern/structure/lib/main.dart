import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:structure/model/meat_model.dart';
import 'package:structure/model/user_model.dart';
import 'package:structure/screen/meat_registration/insertion_meat_info_screen.dart';
import 'package:structure/screen/meat_registration/insertion_trace_num_screen.dart';
import 'package:structure/screen/my_page/change_password_screen.dart';
import 'package:structure/screen/my_page/user_detail_screen.dart';
import 'package:structure/screen/my_page/user_info_screen.dart';
import 'package:structure/screen/sign_up/complete_sign_up_screen.dart';
import 'package:structure/screen/meat_registration/freshmeat_eval_screen.dart';
import 'package:structure/screen/sign_up/insertion_user_detail_screen.dart';
import 'package:structure/screen/sign_up/insertion_user_info_screen.dart';
import 'package:structure/screen/main_screen.dart';
import 'package:structure/screen/meat_registration/meat_registration_screen.dart';
import 'package:structure/screen/sign_in/sign_in_screen.dart';
import 'package:structure/viewModel/meat_registration/freshmeat_eval_view_model.dart';
import 'package:structure/viewModel/meat_registration/insertion_meat_info_view_model.dart';
import 'package:structure/viewModel/meat_registration/insertion_trace_num_view_model.dart';
import 'package:structure/viewModel/my_page/change_password_view_model.dart';
import 'package:structure/viewModel/my_page/user_detail_view_model.dart';
import 'package:structure/viewModel/my_page/user_info_view_model.dart';
import 'package:structure/viewModel/sign_up/insertion_user_detail_view_model.dart';
import 'package:structure/viewModel/sign_up/insertion_user_info_view_model.dart';
import 'package:structure/viewModel/meat_registration/meat_registration_view_model.dart';
import 'package:structure/viewModel/sign_in/sign_in_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const DeepPlantApp());
}

MeatModel meatModel = MeatModel();
UserModel userModel = UserModel();

// 라우팅
final _router = GoRouter(
  initialLocation: '/sign-in',
  routes: [
    // 로그인
    GoRoute(
      path: '/sign-in',
      builder: (context, state) => ChangeNotifierProvider(
        create: (context) => SignInViewModel(userModel: userModel),
        child: const SignInScreen(),
      ),
      routes: [
        // 회원가입
        GoRoute(
          path: 'sign-up',
          builder: (context, state) => ChangeNotifierProvider(
            create: (context) => InsertionUserInfoViewModel(userModel),
            child: const InsertionUserInfoScreen(),
          ),
          routes: [
            GoRoute(
              path: 'user-detail',
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) =>
                    InsertionUserDetailViewModel(userModel: userModel),
                child: const InsertionUserDetailScreen(),
              ),
            ),
          ],
        ),
        // 회원가입 완료
        GoRoute(
          path: 'complete-sign-up',
          builder: (context, state) => const CompleteSignUpScreen(),
        ),
      ],
    ),
    // 메인 페이지
    GoRoute(
      path: '/main',
      builder: (context, state) => MainScreen(
        userModel: userModel,
      ),
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
            // 관리번호 검색
            GoRoute(
              path: 'trace-num',
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) =>
                    InsertionTraceNumViewModel(meatModel: meatModel),
                child: const InsertionTraceNumScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'meat-info',
                  builder: (context, state) => ChangeNotifierProvider(
                    create: (context) =>
                        InsertionMeatInfoViewModel(meatModel: meatModel),
                    child: const InsertionMeatInfoScreen(),
                  ),
                ),
              ],
            ),

            // 신선육 관능평가
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
        // 마이 페이지
        GoRoute(
          path: 'my-page',
          builder: (context, state) => ChangeNotifierProvider(
            create: (context) => UserInfoViewModel(userModel),
            builder: (context, child) => const UserInfoScreen(),
          ),
          routes: [
            // 유저 상세 정보
            GoRoute(
              path: 'user-detail',
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => UserDetailViewModel(userModel),
                builder: (context, child) => const UserDetailScreen(),
              ),
              routes: [
                // 비밀번호 변경
                GoRoute(
                  path: 'change-pw',
                  builder: (context, state) => ChangeNotifierProvider(
                    create: (context) => ChangePasswordViewModel(),
                    builder: (context, child) => const ChangePasswordScreen(),
                  ),
                ),
              ],
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
