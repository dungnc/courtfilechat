import 'package:common/bloc/login_bloc.dart';
import 'package:courtfilechat_flutter/api/login_service.dart';
import 'package:courtfilechat_flutter/bloc_provider/login_provider.dart';
import 'package:courtfilechat_flutter/screen/splash/splash.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(new MaterialApp(
    theme: new ThemeData(
      primarySwatch: Colors.blue,
      backgroundColor: Colors.grey,
    ),
    home: SplashPage(),//_defaultSplashScreen,
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.

    },
  ));
}
