import 'dart:async';

import 'package:common/bloc/login_bloc.dart';
import 'package:courtfilechat_flutter/api/login_service.dart';
import 'package:courtfilechat_flutter/bloc_provider/login_provider.dart';
import 'package:courtfilechat_flutter/screen/home/home.dart';
import 'package:courtfilechat_flutter/screen/login/login.dart';
import 'package:courtfilechat_flutter/util/memory_management.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  SplashPage();

  @override
  State<StatefulWidget> createState() {
    return new SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  SplashPageState() {}

  @override
  void initState() {
  }

  void checkUserLogin() async {
    await MemoryManagement.init();
    String sid = MemoryManagement.getSid();
    if(sid != null && sid.isNotEmpty){
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
        builder: (context) => HomePage()));
    }else {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (context) => LoginProvider(
            child: new LoginPage(), loginBloc: LoginBloc(LoginServiceApi()),
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () => checkUserLogin());

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Image.asset("images/app_icon.png"),
      ),
    );
  }
}
