
import 'package:common/api_service/code_label_service_api.dart';
import 'package:common/bloc/code_label_bloc.dart';
import 'package:common/bloc/court_bloc.dart';
import 'package:common/bloc/filing_bloc.dart';
import 'package:courtfilechat_flutter/api/court_service_api.dart';
import 'package:courtfilechat_flutter/api/filing_service_api.dart';
import 'package:courtfilechat_flutter/bloc_provider/court_provider.dart';
import 'package:courtfilechat_flutter/bloc_provider/filing_provider.dart';
import 'package:courtfilechat_flutter/screen/chat/chat.dart';
import 'package:common/bloc/chat_bloc.dart';
import 'package:courtfilechat_flutter/api/chat_service_api.dart';
import 'package:courtfilechat_flutter/bloc_provider/chat_provider.dart';
import 'package:courtfilechat_flutter/screen/chat/chat_users.dart';
import 'package:courtfilechat_flutter/screen/court/court.dart';
import 'package:courtfilechat_flutter/screen/file/file.dart';
import 'package:courtfilechat_flutter/util/custom_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  int i = 0;
  var pages = [
    CourtProvider(
        child: new CourtScreen(), codeLabelBloc: CodeLabelBloc(CodeLabelServiceApi()),
        courtBloc: CourtBloc(CourtServiceApi()),
    ),
    FilingProvider(child: new FilePage(), filingBloc: FilingBloc(FilingServiceApi())),
    ChatProvider(
        child: new ChatUserScreen(), chatBloc: ChatBloc(ChatServiceApi())),
  ];

  HomePageState() {}

  @override
  void initState() {

  }


  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(70.0), // here the desired height
        child: new AppBar(
        titleSpacing: 50.0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30.0),
          child: new Text("HOEPPNER WAGNER & EVANS LLP",
            style: new TextStyle(
                fontSize: 16.0,
                color: CustomColors.whiteColor,
                fontWeight: FontWeight.w700,
                fontFamily: "Roboto"),
          ),
        ),
        centerTitle: true,
        flexibleSpace: new Container(
          child: Padding(padding: EdgeInsets.only(top: 20.0),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children : [
              new IconButton(
                icon: new Icon(Icons.settings),
                color: CustomColors.grayColor,
                tooltip: 'Setting',
                onPressed: (){
                },
              ),
              new IconButton(
                icon: new Icon(Icons.account_circle),
                color: CustomColors.grayColor,
                tooltip: 'Profile',
                alignment: AlignmentDirectional.center,
                onPressed: (){
                },
              ),
              new IconButton(
                icon: new Icon(Icons.filter_list),
                color: CustomColors.grayColor,
                tooltip: 'More',
                onPressed: (){
                },
              ),
            ],
          ),
          )
        )
      )),
      body: pages[i],
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.folder),
            title: new Text('Court'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.folder),
            title: new Text('File'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.folder),
            title: new Text('Chat'),
          )
        ],
        currentIndex: i,
        onTap: (index) {
          setState(() {
            i = index;
          });
        },
      ),
    );
  }
}
