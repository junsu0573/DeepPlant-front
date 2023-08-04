import 'package:deep_plant_app/models/data_management_filter_model.dart';
import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/pages/data-management/data_management_page_2.dart';
import 'package:deep_plant_app/pages/data-management/reading_data_page.dart';
import 'package:deep_plant_app/pages/home_page.dart';
import 'package:deep_plant_app/pages/maet-registration/additional-data/complete_additional_registration_page.dart';
import 'package:deep_plant_app/pages/maet-registration/additional-data/data_add_home_page.dart';
import 'package:deep_plant_app/pages/maet-registration/basic-data/complete_registration_page.dart';
import 'package:deep_plant_app/pages/maet-registration/basic-data/complete_registration_page_2.dart';
import 'package:deep_plant_app/pages/maet-registration/basic-data/show_step_page.dart';
import 'package:deep_plant_app/pages/show_error_page.dart';
import 'package:deep_plant_app/pages/sign-up/add_user_info_page.dart';
import 'package:deep_plant_app/pages/my-page/my_page.dart';
import 'package:deep_plant_app/pages/my-page/reset_pw_page.dart';
import 'package:deep_plant_app/pages/my-page/succeed_pw_change_page.dart';
import 'package:deep_plant_app/pages/option_page.dart';
import 'package:deep_plant_app/pages/my-page/edit_user_info_page.dart';
import 'package:deep_plant_app/pages/sign-up/email_verification.dart';
import 'package:deep_plant_app/pages/sign-up/id_pw_insertion_page.dart';
import 'package:deep_plant_app/pages/sign_in_page.dart';
import 'package:deep_plant_app/pages/sign-up/succeed_sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:deep_plant_app/models/deep_aging_data_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting();
  runApp(const DeepPlatinApp());
}

// 회원가입 및 로그인을 위한 유저 객체
UserData newUser = UserData();

// 육류 입력 정보 저장을 위한 객체
MeatData newMeat = MeatData();

// 딥에이징 입력 정보를 위한 객체
DeepAgingData newAging = DeepAgingData();

// 데이터 관리 필터 저장을 위한 객체
FilterModel newFilter = FilterModel();

// 라우팅
final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
      routes: [
        GoRoute(
          path: 'sign-in',
          builder: (context, state) => SignIn(
            userData: newUser,
            meatData: newMeat,
          ),
          // 회원가입을 위한 라우팅
          routes: [
            GoRoute(
              path: ('sign-up'),
              builder: (context, state) => IdPwInsertion(
                userData: newUser,
              ),
              routes: [
                GoRoute(
                  path: 'add-user-info',
                  builder: (context, state) => AddUserInfo(
                    userData: newUser,
                  ),
                ),
              ],
            ),
            GoRoute(
              path: ('succeed-sign-up'),
              builder: (context, state) => EmailVerification(
                userData: newUser,
              ),
            ),
          ],
        ),
      ],
    ),
    // 회원가입 성공 창
    GoRoute(
      path: ('/succeed-sign-up'),
      builder: (context, state) => const SucceedSignUp(),
    ),
    // Home
    GoRoute(
      path: '/option',
      builder: (context, state) => OptionPage(
        userData: newUser,
      ),
      routes: [
        GoRoute(
          path: 'error',
          builder: (context, state) => ShowError(),
        ),
        // 마이페이지
        GoRoute(
          path: 'my-page',
          builder: (context, state) => MyPage(
            userData: newUser,
          ),
          routes: [
            GoRoute(
              path: 'edit-info',
              builder: (context, state) => EditUserInfo(
                user: newUser,
              ),
              routes: [
                GoRoute(
                  path: 'reset-pw',
                  builder: (context, state) => ResetPW(
                    userData: newUser,
                  ),
                ),
              ],
            ),
            GoRoute(
              path: 'success-pw-change',
              builder: (context, state) => SucceedPwChange(
                userData: newUser,
              ),
            ),
          ],
        ),
        // step-1
        GoRoute(
          path: 'show-step',
          builder: (context, state) => ShowStep(
            userData: newUser,
            meatData: newMeat,
            isEdited: false,
          ),
        ),
        // 육류 등록 성공
        GoRoute(
          path: 'complete-register',
          builder: (context, state) => CompleteResgistration(
            meatData: newMeat,
          ),
        ),
        GoRoute(
          path: 'complete-register-2',
          builder: (context, state) => CompleteResgistration2(
            userData: newUser,
            meatData: newMeat,
          ),
        ),
        // 육류 데이터 추가 성공
        GoRoute(
          path: 'complete-add-register',
          builder: (context, state) => CompleteAdditionalRegistration(
            meatData: newMeat,
          ),
        ),
        // 데이터 관리 페이지
        GoRoute(
          path: 'reading-data',
          builder: (context, state) => ReadingData(
            userData: newUser,
            meatData: newMeat,
          ),
        ),
        GoRoute(
          path: 'data-management',
          builder: (context, state) => DataManagement2(
            userData: newUser,
            meatData: newMeat,
            filter: newFilter,
          ),
        ),
        GoRoute(
          path: 'data-add-home',
          builder: (context, state) => DataAddHome(
            meatData: newMeat,
            userData: newUser,
          ),
        ),
      ],
    ),
  ],
);

class DeepPlatinApp extends StatelessWidget {
  const DeepPlatinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'DeepPlant-demo',
      // 기본 색상
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(51, 51, 51, 1),
        buttonTheme: const ButtonThemeData(buttonColor: Color.fromRGBO(51, 51, 51, 1)),
      ),
      routerConfig: _router,
      builder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(720, 1280),
          builder: (context, _) {
            return AppManager(child: child!);
          },
        );
      },
    );
  }
}

class AppManager extends StatefulWidget {
  final Widget child;

  const AppManager({required this.child, super.key});

  @override
  State<AppManager> createState() => _AppManagerState();
}

class _AppManagerState extends State<AppManager> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

// 앱 상태 변경시 호출
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        // 최초 앱 실행때는 발생하지 않음.
        print("resumed : 앱이 표시되고 사용자 입력에 응답합니다.");
        break;
      case AppLifecycleState.inactive:
        // inactive가 발생되고 얼마후 pasued가 발생 -> 앱이 'home'키를 눌러 백그라운드로 내려갈 때.
        print("inactive : 앱이 비활성화 상태이고 사용자의 입력을 받지 않습니다.");
        break;
      case AppLifecycleState.paused:
        // 이 상황에서 다시 앱을 호출하면 resume로 전환.
        print("paused : 앱이 현재 사용자에게 보이지 않고, 사용자의 입력을 받지 않으며, 백그라운드에서 동작 중입니다.");
        break;
      case AppLifecycleState.detached:
        print("detached : 앱이 host View에서 분리됩니다. 여전히 flutter 엔진에서 호스팅 됩니다. 곧 앱이 종료됩니다.");
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
