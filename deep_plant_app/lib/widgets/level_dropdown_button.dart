import 'package:deep_plant_app/models/user_model.dart';
import 'package:flutter/material.dart';

class LevelDropdownButton extends StatefulWidget {
  final UserModel user;
  LevelDropdownButton({
    super.key,
    required this.user,
  });

  @override
  State<LevelDropdownButton> createState() => _LevelDropdownButtonState();
}

class _LevelDropdownButtonState extends State<LevelDropdownButton> {
  // dropdown 버튼 리스트
  List<String> dropdownList = ['사용자 1', '사용자 2', '사용자 3'];
  String selectedDropdown = '사용자 1';

  String fetchUserLevel(dynamic value) {
    // 유저 등급 설정
    String userLevel = '';
    if (value == '사용자 1') {
      userLevel = 'users_1';
    } else if (value == '사용자 2') {
      userLevel = 'users_2';
    } else if (value == '사용자 3') {
      userLevel = 'users_3';
    }

    return userLevel;
  }

  @override
  void initState() {
    super.initState();
    widget.user.level = '사용자 1';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade400,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(30)),
      child: DropdownButton(
        padding: const EdgeInsets.only(left: 40),
        value: selectedDropdown,
        items: dropdownList.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    item,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (dynamic value) {
          setState(() {
            selectedDropdown = value;
            widget.user.level = fetchUserLevel(value);
          });
        },
        isExpanded: true,
        borderRadius: BorderRadius.circular(30),
        underline: Container(
          decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.transparent, width: 0)),
          ),
        ),
        icon: const Icon(
          Icons.arrow_drop_down_sharp,
          size: 40,
        ),
      ),
    );
  }
}
