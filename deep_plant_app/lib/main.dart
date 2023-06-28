import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/models/user_model.dart';
import 'package:deep_plant_app/pages/maet-registration/freshmeat_evaluation_page.dart';
import 'package:deep_plant_app/pages/maet-registration/insertion_meat_image.dart';
import 'package:deep_plant_app/pages/maet-registration/insertion_meat_info_page.dart';
import 'package:deep_plant_app/pages/maet-registration/show_step_page.dart';
import 'package:deep_plant_app/pages/my-page/edit_user_info_page.dart';
import 'package:deep_plant_app/pages/my-page/my_page.dart';
import 'package:deep_plant_app/pages/my-page/reset_pw_page.dart';
import 'package:deep_plant_app/pages/option_page.dart';
import 'package:deep_plant_app/pages/sign-up/certification_page.dart';
import 'package:deep_plant_app/pages/home_page.dart';
import 'package:deep_plant_app/pages/sign-up/email_verification.dart';
import 'package:deep_plant_app/pages/sign-up/insertion_idnpw.dart';
import 'package:deep_plant_app/pages/sign_in_page.dart';
import 'package:deep_plant_app/pages/sign-up/succeed_sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:deep_plant_app/pages/maet-registration/get_history_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

// 회원가입을 위한 유저 객체
UserModel newUser = UserModel();
MeatData newMeat = MeatData();

// 라우팅
final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'sign-in',
          builder: (context, state) => const SignIn(),
          routes: [
            GoRoute(
              path: ('certification'),
              builder: (context, state) => Certification(
                user: newUser,
              ),
              routes: [
                GoRoute(
                  path: ('insert-id-pw'),
                  builder: (context, state) => InsertionIdnPw(
                    user: newUser,
                  ),
                  routes: [
                    GoRoute(
                      path: ('email-verification'),
                      builder: (context, state) => EmailVerification(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: ('/succeed-sign-up'),
      builder: (context, state) => const SucceedSignUp(),
    ),
    GoRoute(
      path: '/option',
      builder: (context, state) => OptionPage(),
      routes: [
        GoRoute(
          path: 'my-page',
          builder: (context, state) => MyPage(),
          routes: [
            GoRoute(
              path: 'edit-info',
              builder: (context, state) => EditUserInfo(),
              routes: [
                GoRoute(
                  path: 'reset-pw',
                  builder: (context, state) => ResetPW(),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: 'show-step',
          builder: (context, state) => ShowStep(
            meat: newMeat,
          ),
          routes: [
            GoRoute(
              path: 'insert-his-num',
              builder: (context, state) => GetHistoryPage(
                meatData: newMeat,
              ),
            ),
            GoRoute(
              path: 'insert-meat-info',
              builder: (context, state) => InsertionMeatInfo(
                meatData: newMeat,
              ),
            ),
            GoRoute(
              path: 'insert-meat-image',
              builder: (context, state) => InsertionMeatImage(
                meatData: newMeat,
              ),
            ),
            GoRoute(
              path: 'insert-fresh-evaluation',
              builder: (context, state) => FreshmeatEvaluation(
                meatData: newMeat,
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'DeepPlant-demo',
      // 기본 색상
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(51, 51, 51, 1),
        buttonTheme:
            const ButtonThemeData(buttonColor: Color.fromRGBO(51, 51, 51, 1)),
      ),
      routerConfig: _router,
      builder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(720, 1280),
          builder: (context, _) {
            return child!;
          },
        );
      },
    );
  }
}
