import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AlertComponent {
  var alertStyle = AlertStyle(
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    titleStyle: const TextStyle(color: Colors.black),
    animationDuration: const Duration(milliseconds: 400),
    alertBorder:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    overlayColor: Colors.black54,
    backgroundColor: Colors.white,
  );

  error(BuildContext context, String text) {
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.error,
      title: text,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          width: 120,
          color: Colors.orange.shade100,
          child: const Text(
            "Retour",
            style: TextStyle(color: Colors.orange, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  success(BuildContext context, String text) {
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.success,
      title: text,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.of(context).pop(),
          width: 120,
          child: const Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  confirm(BuildContext context, String text, void Function() action) {
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.info,
      title: text,
      buttons: [
        DialogButton(
          onPressed: () async {
            Navigator.of(context).pop();
            action();
          },
          width: 120,
          color: Colors.orange,
          child: const Text(
            "Confirmer",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        DialogButton(
          onPressed: () => Navigator.of(context).pop(),
          width: 120,
          color: Colors.orange.shade500,
          child: const Text(
            "Retour",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  textAlert(String text, Color color) {
    Fluttertoast.showToast(
      msg: '$text.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16,
    );
  }

  loading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..loadingStyle = EasyLoadingStyle.light
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..userInteractions = false
      ..dismissOnTap = false;

    EasyLoading.show(
      status: 'Vérification...',
      dismissOnTap: false,
    );
  }

  endLoading() {
    EasyLoading.dismiss();
  }
}
