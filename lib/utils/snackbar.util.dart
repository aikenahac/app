import 'package:flutter/material.dart';
import 'package:coinseek/core/globals.dart';

double? _bottomMargin;

void showSnackbar(String message) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    if (snackbarKey.currentState?.context != null) {
      _bottomMargin =
          MediaQuery.of(snackbarKey.currentState!.context).size.height * 0.5;
      _bottomMargin = _bottomMargin! -
          MediaQuery.of(snackbarKey.currentState!.context).padding.vertical;
    }
    final SnackBar snackBar = SnackBar(
      content: Center(
        heightFactor: 1,
        child: Text(
          message,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: _bottomMargin ?? 0, left: 15, right: 15),
      dismissDirection: DismissDirection.none,
    );

    snackbarKey.currentState?.clearSnackBars();
    snackbarKey.currentState?.showSnackBar(snackBar);
  });
}
