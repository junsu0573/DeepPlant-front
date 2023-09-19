import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:structure/home_page.dart';
import 'package:structure/model/meat_model.dart';
import 'package:structure/model/user_model.dart';
import 'package:structure/viewModel/test_view_model.dart';

MeatModel meatModel = MeatModel();
UserModel userModel = UserModel();

void main() async {
  runApp(MyApp(
    meatModel: meatModel,
    userModel: userModel,
  ));
}

class MyApp extends StatelessWidget {
  final MeatModel meatModel;
  final UserModel userModel;
  const MyApp({
    super.key,
    required this.meatModel,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => TestViewModel(meatModel: meatModel),
        child: const HomePage(),
      ),
    );
  }
}
