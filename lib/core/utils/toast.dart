import 'package:fluttertoast/fluttertoast.dart';
import 'package:search_task/core/design/colors_catalog.dart';

void showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: ColorsCatalog().APP_WHITE,
      textColor: ColorsCatalog().APP_BLUE,
      fontSize: 16.0);
}
