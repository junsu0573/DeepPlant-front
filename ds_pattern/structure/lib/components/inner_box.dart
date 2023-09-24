import 'package:flutter/material.dart';

// 이 컴포넌트는 insertion_trace_num의 table을 구성하는 요소입니다.

class InnerBox extends StatelessWidget {
  const InnerBox({
    super.key,
    required this.text,
  });

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 0.25,
        ),
      ),
      child: Row(
        children: [
          RichText(
            text: TextSpan(children: [
              WidgetSpan(
                child: SizedBox(
                  width: 15,
                ),
              ),
              TextSpan(
                text: text,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
