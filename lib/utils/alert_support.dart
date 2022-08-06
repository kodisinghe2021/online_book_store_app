import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/widgets.dart';

class AlertSupprt {
 static Future<dynamic> showDialogBox(
    BuildContext context,
    CoolAlertType alertType,
    String title,
    String text,
    VoidCallback onConfirmBtnTap,
  ) async {
    return CoolAlert.show(
      context: context,
      type: alertType,
      title: title,
      text: text,
      animType: CoolAlertAnimType.rotate,
      borderRadius: 50,
      onConfirmBtnTap: onConfirmBtnTap,
    );
  }
}
