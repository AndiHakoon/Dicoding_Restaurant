import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant2/commons/navigation.dart';

customDialog(BuildContext context) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Coming Soon!'),
        content: const Text('This feature will be coming soon!'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Ok'),
            onPressed: () => Navigation.back(),
          ),
        ],
      ),
    );
  } else {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text('Coming Soon!'),
              content: const Text('This feature will be coming soon!'),
              actions: [
                TextButton(
                  child: const Text('Ok!'),
                  onPressed: () => Navigation.back(),
                ),
              ],
            ));
  }
}
