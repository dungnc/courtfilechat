import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<Null> showLoading(BuildContext context, String message) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    child: new Container(
      child: new AlertDialog(
        content: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CircularProgressIndicator(),
            new Padding(
              child: new Text(message),
              padding: const EdgeInsets.only(left: 10.0
              )
            ),
          ],
        ),
      ),
      width: 200.0,
    ),
  );
}

hideLoading(context){
  Navigator.of(context).pop();
}