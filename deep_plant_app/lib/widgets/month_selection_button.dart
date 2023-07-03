import 'package:flutter/material.dart';

class MonthSelectionButton extends StatelessWidget {
  final List<String> months;
  final ValueChanged<String> onMonthSelected;

  MonthSelectionButton({required this.months, required this.onMonthSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: months.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.5,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      itemBuilder: (context, index) {
        return ElevatedButton(
          onPressed: () {
            String result = months[index].substring(0, months[index].length - 1);
            onMonthSelected(result);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          child: Text(
            months[index],
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        );
      },
    );
  }
}
