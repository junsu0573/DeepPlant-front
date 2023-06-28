import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '마이페이지',
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Icon(
              Icons.person_outline_rounded,
              size: 70,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      '이름',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      '아이디',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      '권한',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      '가입날짜',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(
                      'test',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'example@example.com',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      '사용자 2',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      '2023.06.26',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                context.go('/option/my-page/edit-info');
              },
              child: Text('수정'),
            ),
          ],
        ),
      ),
    );
  }
}
