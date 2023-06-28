import 'package:deep_plant_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Certification extends StatefulWidget {
  final UserModel user;
  const Certification({
    super.key,
    required this.user,
  });

  @override
  State<Certification> createState() => _CertificationState();
}

class _CertificationState extends State<Certification> {
  bool? _isChecked1 = false;
  bool? _isChecked2 = false;
  bool? _isChecked3 = false;
  bool? _isChecked4 = false;

  Color buttonColor = const Color.fromRGBO(51, 51, 51, 1).withOpacity(0.5);

  void checkCheckBoxValues() {
    if (_isChecked1 == true && _isChecked2 == true && _isChecked3 == true) {
      setState(() {
        _isChecked4 = true;
      });
    } else {
      setState(() {
        _isChecked4 = false;
      });
    }
    if (_isChecked1 == true && _isChecked2 == true) {
      setState(() {
        buttonColor = Theme.of(context).primaryColor;
      });
    } else {
      setState(() {
        buttonColor = Theme.of(context).primaryColor.withOpacity(0.5);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '약관동의',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                '간단한 약관동의 후 회원가입이 진행됩니다.',
                style: TextStyle(fontSize: 17),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          value: _isChecked1,
                          onChanged: (value) {
                            setState(() {
                              _isChecked1 = value;
                            });
                            checkCheckBoxValues();
                          },
                        ),
                        const Text('개인정보 수집제공 동의 (필수)'),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            '보기',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          value: _isChecked2,
                          onChanged: (value) {
                            setState(() {
                              _isChecked2 = value;
                            });
                            checkCheckBoxValues();
                          },
                        ),
                        const Text('제 3자 정보제공 동의 (필수)'),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            '보기',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          value: _isChecked3,
                          onChanged: (value) {
                            setState(() {
                              _isChecked3 = value;
                            });
                            checkCheckBoxValues();
                          },
                        ),
                        const Text('알림받기 (선택)'),
                        const Spacer(),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          value: _isChecked4,
                          onChanged: (value) {
                            setState(() {
                              _isChecked1 = value;
                              _isChecked2 = value;
                              _isChecked3 = value;
                              _isChecked4 = value;
                            });
                            checkCheckBoxValues();
                          },
                        ),
                        const Text(
                          '모두 확인 및 동의합니다.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 350,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: buttonColor == Theme.of(context).primaryColor
                            ? () {
                                context
                                    .go('/sign-in/certification/insert-id-pw');
                                widget.user.isAlarmed = _isChecked3;
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          '다음',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
