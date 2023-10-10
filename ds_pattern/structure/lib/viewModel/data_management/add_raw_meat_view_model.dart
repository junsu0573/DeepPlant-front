import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AddRawMeatViewModel with ChangeNotifier {
  void clickedHeated(BuildContext context) {
    context.go('/home/data-manage-researcher/add/raw-meat/heated-meat');
  }

  void clickedTongue(BuildContext context) {
    context.go('/home/data-manage-researcher/add/raw-meat/tongue');
  }

  void clickedLab(BuildContext context) {
    context.go('/home/data-manage-researcher/add/raw-meat/lab');
  }
}
