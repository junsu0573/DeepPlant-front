import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:structure/model/meat_model.dart';
import 'package:structure/model/user_model.dart';
import 'package:structure/screen/data_management/normal/edit_meat_data_screen.dart';
import 'package:structure/screen/data_management/normal/not_editable/freshmeat_eval_not_editable_sceen.dart';
import 'package:structure/screen/data_management/normal/not_editable/insertion_meat_image_not_editable_screen.dart';
import 'package:structure/screen/data_management/normal/not_editable/insertion_meat_info_not_editable_screen.dart';
import 'package:structure/screen/data_management/normal/not_editable/insertion_trace_num_not_editable_screen.dart';
import 'package:structure/screen/data_management/researcher/add_processed_meat_main_screen.dart';
import 'package:structure/screen/data_management/researcher/add_raw_meat_main_screen.dart';
import 'package:structure/screen/data_management/researcher/data_add_home_screen.dart';
import 'package:structure/screen/data_management/researcher/data_management_home_researcher_screen.dart';
import 'package:structure/screen/data_management/normal/data_management_home_screen.dart';
import 'package:structure/screen/data_management/researcher/heatedmeat_eval_screen.dart';
import 'package:structure/screen/data_management/researcher/insertion_lab_data_screen.dart';
import 'package:structure/screen/data_management/researcher/insertion_tongue_data_screen.dart';
import 'package:structure/screen/home_screen.dart';
import 'package:structure/screen/meat_registration/creation_management_num_researcher_screen.dart';
import 'package:structure/screen/meat_registration/creation_management_num_screen.dart';
import 'package:structure/screen/meat_registration/insertion_meat_info_screen.dart';
import 'package:structure/screen/meat_registration/insertion_trace_num_screen.dart';
import 'package:structure/screen/meat_registration/registration_meat_image_screen.dart';
import 'package:structure/screen/my_page/change_password_screen.dart';
import 'package:structure/screen/my_page/success_change_pw_screen.dart';
import 'package:structure/screen/my_page/user_detail_screen.dart';
import 'package:structure/screen/my_page/user_info_screen.dart';
import 'package:structure/screen/sign_up/complete_sign_up_screen.dart';
import 'package:structure/screen/meat_registration/freshmeat_eval_screen.dart';
import 'package:structure/screen/sign_up/insertion_user_detail_screen.dart';
import 'package:structure/screen/sign_up/insertion_user_info_screen.dart';
import 'package:structure/screen/meat_registration/meat_registration_screen.dart';
import 'package:structure/screen/sign_in/sign_in_screen.dart';
import 'package:structure/screen/ui_update_screen.dart';
import 'package:structure/viewModel/data_management/researcher/add_processed_meat_view_model.dart';
import 'package:structure/viewModel/data_management/researcher/add_raw_meat_view_model.dart';
import 'package:structure/viewModel/data_management/researcher/data_add_home_view_model.dart';
import 'package:structure/viewModel/data_management/normal/data_management_view_model.dart';
import 'package:structure/viewModel/data_management/normal/edit_meat_data_view_model.dart';
import 'package:structure/viewModel/data_management/normal/not_editable/freshmeat_eval_not_editable_view_model.dart';
import 'package:structure/viewModel/data_management/normal/not_editable/insertion_meat_image_not_editable_view_model.dart';
import 'package:structure/viewModel/data_management/normal/not_editable/insertion_meat_info_not_editable_view_model.dart';
import 'package:structure/viewModel/data_management/normal/not_editable/insertion_trace_num_not_editable_view_model.dart';
import 'package:structure/viewModel/data_management/researcher/data_management_researcher_view_model.dart';
import 'package:structure/viewModel/data_management/researcher/heatedmeat_eval_view_model.dart';
import 'package:structure/viewModel/data_management/researcher/insertion_lab_data_view_model.dart';
import 'package:structure/viewModel/data_management/researcher/insertion_tongue_data_view_model.dart';
import 'package:structure/viewModel/home_view_model.dart';
import 'package:structure/viewModel/meat_registration/creation_management_num_researcher_view_model.dart';
import 'package:structure/viewModel/meat_registration/creation_management_num_view_model.dart.dart';
import 'package:structure/viewModel/meat_registration/freshmeat_eval_view_model.dart';
import 'package:structure/viewModel/meat_registration/insertion_meat_info_view_model.dart';
import 'package:structure/viewModel/meat_registration/insertion_trace_num_view_model.dart';
import 'package:structure/viewModel/meat_registration/registration_meat_image_view_model.dart';
import 'package:structure/viewModel/my_page/change_password_view_model.dart';
import 'package:structure/viewModel/my_page/user_detail_view_model.dart';
import 'package:structure/viewModel/my_page/user_info_view_model.dart';
import 'package:structure/viewModel/sign_up/insertion_user_detail_view_model.dart';
import 'package:structure/viewModel/sign_up/insertion_user_info_view_model.dart';
import 'package:structure/viewModel/meat_registration/meat_registration_view_model.dart';
import 'package:structure/viewModel/sign_in/sign_in_view_model.dart';
import 'package:structure/viewModel/ui_update_view_model.dart';

class UserRouter {
  final MeatModel meatModel;
  final UserModel userModel;
  UserRouter({required this.meatModel, required this.userModel});

  static GoRouter getRouter(MeatModel meatModel, UserModel userModel) {
    return GoRouter(
      initialLocation: '/sign-in',
      routes: [
        // UI Update
        GoRoute(
          path: '/ui-update',
          builder: (context, state) => ChangeNotifierProvider(
              create: (context) => UIUpdateViewModel(),
              child: const UIUpdate()),
        ),
        // 로그인
        GoRoute(
          path: '/sign-in',
          builder: (context, state) => ChangeNotifierProvider(
            create: (context) =>
                SignInViewModel(userModel: userModel, meatModel: meatModel),
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
          path: '/home',
          builder: (context, state) => ChangeNotifierProvider(
              create: (context) => HomeViewModel(userModel: userModel),
              child: const HomeScreen()),
          routes: [
            // 육류 등록 페이지
            GoRoute(
              path: 'registration',
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => MeatRegistrationViewModel(
                    meatModel: meatModel, userModel: userModel),
                child: MeatRegistrationScreen(meatModel: meatModel),
              ),
              routes: [
                // 관리번호 검색
                GoRoute(
                  path: 'trace-num',
                  builder: (context, state) => ChangeNotifierProvider(
                    create: (context) => InsertionTraceNumViewModel(meatModel),
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
                GoRoute(
                  path: 'image',
                  builder: (context, state) => ChangeNotifierProvider(
                    create: (context) =>
                        RegistrationMeatImageViewModel(meatModel),
                    child: const RegistrationMeatImageScreen(),
                  ),
                ),
                // 신선육 관능평가
                GoRoute(
                  path: 'freshmeat',
                  builder: (context, state) => ChangeNotifierProvider(
                    create: (context) => FreshMeatEvalViewModel(meatModel),
                    child: const FreshMeatEvalScreen(),
                  ),
                ),
              ],
            ),
            // 육류 등록 완료 페이지 - Normal User
            GoRoute(
              path: 'success-registration-normal',
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => CreationManagementNumViewModel(meatModel),
                child: const CreationManagementNumScreen(),
              ),
            ),
            // 육류 등록 완료 페이지 - Researcher User
            GoRoute(
              path: 'success-registration-researcher',
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) =>
                    CreationManagementNumResearcherViewModel(meatModel),
                child: const CreationManagementNumResearcherNumScreen(),
              ),
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
                        create: (context) =>
                            ChangePasswordViewModel(userModel: userModel),
                        builder: (context, child) =>
                            const ChangePasswordScreen(),
                      ),
                    ),
                    GoRoute(
                      path: 'success-change',
                      builder: (context, state) =>
                          const SuccessChangePWScreen(),
                    ),
                  ],
                ),
              ],
            ),
            // 데이터 관리 페이지 - Normal User
            GoRoute(
              path: 'data-manage-normal',
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => DataManagementHomeViewModel(userModel),
                child: const DataManagementHomeScreen(),
              ),
              routes: [
                // 데이터 수정
                GoRoute(
                  path: 'edit',
                  builder: (context, state) => ChangeNotifierProvider(
                      create: (context) => EditMeatDataViewModel(meatModel),
                      child: const EditMeatDataScreen()),
                  routes: [
                    // 수정불가
                    GoRoute(
                      path: 'trace',
                      builder: (context, state) => ChangeNotifierProvider(
                        create: (context) =>
                            InsertionTraceNumNotEditableViewModel(meatModel),
                        child: const InsertionTraceNumNotEditableScreen(),
                      ),
                      routes: [
                        GoRoute(
                          path: 'info',
                          builder: (context, state) => ChangeNotifierProvider(
                            create: (context) =>
                                InsertionMeatInfoNotEditableViewModel(
                                    meatModel),
                            child: const InsertionMeatInfoNotEditableScreen(),
                          ),
                        ),
                      ],
                    ),
                    GoRoute(
                      path: 'image',
                      builder: (context, state) => ChangeNotifierProvider(
                        create: (context) =>
                            InsertionMeatImageNotEditableViewModel(
                                meatModel, userModel, 0),
                        child: const InsertionMeatImageNotEditableScreen(),
                      ),
                    ),
                    GoRoute(
                      path: 'freshmeat',
                      builder: (context, state) => ChangeNotifierProvider(
                        create: (context) =>
                            FreshMeatEvalNotEditableViewModel(meatModel, false),
                        child: const FreshMeatEvalNotEditableScreen(),
                      ),
                    ),
                    // 수정 가능
                    GoRoute(
                      path: 'trace-editable',
                      builder: (context, state) => ChangeNotifierProvider(
                        create: (context) =>
                            InsertionTraceNumViewModel(meatModel),
                        child: const InsertionTraceNumScreen(),
                      ),
                      routes: [
                        GoRoute(
                          path: 'info-editable',
                          builder: (context, state) => ChangeNotifierProvider(
                            create: (context) => InsertionMeatInfoViewModel(
                                meatModel: meatModel),
                            child: const InsertionMeatInfoScreen(),
                          ),
                        ),
                      ],
                    ),
                    GoRoute(
                      path: 'image-editable',
                      builder: (context, state) => ChangeNotifierProvider(
                        create: (context) =>
                            RegistrationMeatImageViewModel(meatModel),
                        child: const RegistrationMeatImageScreen(),
                      ),
                    ),
                    GoRoute(
                      path: 'freshmeat-editable',
                      builder: (context, state) => ChangeNotifierProvider(
                        create: (context) => FreshMeatEvalViewModel(meatModel),
                        child: const FreshMeatEvalScreen(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // 데이터 관리 페이지 - Researcher User
            GoRoute(
              path: 'data-manage-researcher',
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) =>
                    DataManagementHomeResearcherViewModel(meatModel),
                child: const DataManagementHomeResearcherScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'add',
                  builder: (context, state) => ChangeNotifierProvider(
                      create: (context) => DataAddHomeViewModel(meatModel),
                      child: const DataAddHome()),
                  routes: [
                    GoRoute(
                      path: 'raw-meat',
                      builder: (context, state) => ChangeNotifierProvider(
                          create: (context) => AddRawMeatViewModel(),
                          child: StepFreshMeat(
                            meatModel: meatModel,
                          )),
                      routes: [
                        GoRoute(
                          path: 'heated-meat',
                          builder: (context, state) => ChangeNotifierProvider(
                              create: (context) =>
                                  HeatedMeatEvalViewModel(meatModel),
                              child: const HeatedMeatEvaluation()),
                        ),
                        GoRoute(
                          path: 'tongue',
                          builder: (context, state) => ChangeNotifierProvider(
                            create: (context) =>
                                InsertionTongueDataViewModel(meatModel),
                            child: const InsertionTongueDataScreen(),
                          ),
                        ),
                        GoRoute(
                          path: 'lab',
                          builder: (context, state) => ChangeNotifierProvider(
                            create: (context) =>
                                InsertionLabDataViewModel(meatModel),
                            child: const InsertionLabDataScreen(),
                          ),
                        ),
                      ],
                    ),
                    GoRoute(
                      path: 'processed-meat',
                      builder: (context, state) => ChangeNotifierProvider(
                          create: (context) => AddProcessedMeatViewModel(),
                          child:
                              AddProcessedMeatMainScreen(meatModel: meatModel)),
                      routes: [
                        GoRoute(
                            path: 'image',
                            builder: (context, state) => ChangeNotifierProvider(
                                  create: (context) =>
                                      RegistrationMeatImageViewModel(meatModel),
                                  child: const RegistrationMeatImageScreen(),
                                )),
                        GoRoute(
                          path: 'eval',
                          builder: (context, state) => ChangeNotifierProvider(
                            create: (context) =>
                                FreshMeatEvalViewModel(meatModel),
                            child: const FreshMeatEvalScreen(),
                          ),
                        ),
                        GoRoute(
                          path: 'heated-meat',
                          builder: (context, state) => ChangeNotifierProvider(
                              create: (context) =>
                                  HeatedMeatEvalViewModel(meatModel),
                              child: const HeatedMeatEvaluation()),
                        ),
                        GoRoute(
                          path: 'tongue',
                          builder: (context, state) => ChangeNotifierProvider(
                            create: (context) =>
                                InsertionTongueDataViewModel(meatModel),
                            child: const InsertionTongueDataScreen(),
                          ),
                        ),
                        GoRoute(
                          path: 'lab',
                          builder: (context, state) => ChangeNotifierProvider(
                            create: (context) =>
                                InsertionLabDataViewModel(meatModel),
                            child: const InsertionLabDataScreen(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
