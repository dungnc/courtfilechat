import 'package:common/bloc/login_bloc.dart';
import 'package:courtfilechat_flutter/bloc_provider/login_provider.dart';
import 'package:courtfilechat_flutter/screen/home/home.dart';
import 'package:courtfilechat_flutter/util/memory_management.dart';
import 'package:courtfilechat_flutter/util/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toast_pk/flutter_toast_pk.dart';

class LoginPage extends StatefulWidget {
  LoginPage();

  @override
  State<StatefulWidget> createState() {
    return new LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  LoginBloc loginBloc;

  final TextEditingController userNameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  LoginPageState() {}

  @override
  void initState() {

  }

  void loginUser() async {
    await MemoryManagement.init();

    if(userNameController.text != null && userNameController.text.trim().isNotEmpty &&
        passwordController.text != null && passwordController.text.trim().isNotEmpty){
        showLoading(context, "");

        String encrytedPassword = await loginBloc.convertPlaintextToCipherText(passwordController.text);
        String sid = await loginBloc.authenticateWithEncryptedPassword(userNameController.text, encrytedPassword, "LawFirmStaff");
        if(sid!=null){
          hideLoading(context);
          MemoryManagement.setSid(sid);
          MemoryManagement.setEmail(userNameController.text);
          MemoryManagement.setUserId(userNameController.text);
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (context) => HomePage()));
        }else{
          hideLoading(context);
        }
    } else {
      FlutterToast.showToast("Username and password are required");
    }
  }


  @override
  Widget build(BuildContext context) {
    loginBloc = LoginProvider.of(context, 'loginBloc');

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: new SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(bottom: 10.0),
        child:
        new Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            FractionalTranslation(
              translation: Offset(0.0, ((MediaQuery.of(context).size.height * 10)/100)/1000),
              child: Center(
                widthFactor: 50.0,
                child: new Column(
                  children: <Widget>[
                    new Container(child: new Text(
                        "Login", style: new TextStyle(fontSize: 22.0, color: Colors.white)),
                      margin: EdgeInsets.only(bottom: 15.0),),
                    Card(
                      margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 5.0, bottom: 5.0),
                      child: Column(
                        children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child:
                               new Container(
                                constraints: new BoxConstraints.expand(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 4,
                                ),
                                decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                    image: new AssetImage(
                                        "images/login_background.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: null
                              )),

                          new Container(
                            /*margin: EdgeInsets.only(left: MediaQuery.of(context).size.height/20,
                                right: MediaQuery.of(context).size.height/20,
                                bottom: MediaQuery.of(context).size.height/35),*/
                            margin: EdgeInsets.only(left: 20.0,
                                right: 20.0,
                                bottom: 20.0),
                            child: new RaisedButton(
                              color: Colors.blue,
                              padding: EdgeInsets.only(left: 50.0),
                              child: new Row(
                                children: <Widget>[
                                  new Container(
//                                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 15),
                                      child: new Image.asset('images/google.png', height: MediaQuery.of(context)
                                          .size.height / 15, width: MediaQuery.of(context)
                                          .size.width / 15,
                                      )
                                  ),
                                  new Container(
                                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 18),
                                      child: new Text("Login with Google", style: new TextStyle(color: Colors.white),)
                                  ),
                                ],
                              ),
                              onPressed: (){},
                            ),
                          ),
                          new Container(
                            margin: EdgeInsets.only(
                                bottom: 10.0, top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              controller: userNameController,
                              keyboardType: TextInputType.emailAddress,
                              autofocus: false,
                              decoration: InputDecoration(
                                hintText: 'Username',
                                contentPadding: EdgeInsets.all(5.0),
                              ),
                            ),
                          ),
                          new Container(
                            margin: EdgeInsets.only(
                                bottom: 10.0, top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              controller: passwordController,
                              autofocus: false,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                contentPadding: EdgeInsets.all(5.0),
                              ),
                            ),
                          ),
                          new Container(
                            margin: EdgeInsets.only(
                                bottom: 30.0, top: 20.0, left: 20.0, right: 20.0),
                            child: new SizedBox(
                            width: double.infinity,
                            child: new RaisedButton(
                              textColor: Colors.white,
                              color: Colors.blue,
                              onPressed: () {
                                loginUser();
                              },
                              child: new Text("Login"),
                            ),
                          )
                          )
                           ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        )
      )
    );
  }
}
