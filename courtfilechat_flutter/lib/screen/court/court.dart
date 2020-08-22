import 'package:common/bloc/code_label_bloc.dart';
import 'package:common/bloc/court_bloc.dart';
import 'package:common/model/county.dart';
import 'package:common/model/localtion_code.dart';
import 'package:common/model/localtion_code_list.dart';
import 'package:courtfilechat_flutter/bloc_provider/court_provider.dart';
import 'package:courtfilechat_flutter/util/custom_colors.dart';
import 'package:flutter/material.dart';

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon);
}

class CourtScreen extends StatefulWidget {
  CourtScreen() {}

  @override
  State<StatefulWidget> createState() {
    return new CourtScreenState();
  }
}

class CountyItem extends StatelessWidget {
  CountyItem({this.locationCode, this.county});
  final LocationCode locationCode;
  final County county;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(top: 5.0, left: 10.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          new Column(
            children: [
//              new Text(locationCode.label, style: new TextStyle(color: Colors.black),)
              new Text(county.name, style: new TextStyle(color: Colors.black),)
            ],
          ),
          new Column(
            children: [
              new Padding(padding: EdgeInsets.only(
                right: 30.0,
              ),
              child: new IconButton(
                icon: new Icon(Icons.add_circle),
                tooltip: 'Chat',
                onPressed: (){},
                color: CustomColors.lightBlue,
              ))
            ],
          ),
        ],
      ),
    );
  }
}

class CourtScreenState extends State<CourtScreen> {
  bool initStateCall = false;
  CodeLabelBloc codeLabelBloc;
  CourtBloc courtBloc;
  List<CountyItem> countyItems = <CountyItem>[];

  CourtScreenState() {}

//  @override
//  void initState() {
//
//  }

  void initWidget() {
    print(initStateCall);
    if(initStateCall==false){
      getCountyCodeList();
      initStateCall=true;
    }
  }

  void getCountyCodeList() async {
    List<County> countyList = await courtBloc.getCountyList();
    for(County county in countyList){
      CountyItem countyItem = new CountyItem(county: county);
      setState(() {
        countyItems.add(countyItem);
      });
    }


//    LocationCodeList locationCodeList = await codeLabelBloc.getStateCodeList();
//    for(LocationCode locationCode in locationCodeList.locationCodeList){
//      CountyItem countyItem = new CountyItem(locationCode: locationCode);
//      setState(() {
//        countyItems.add(countyItem);
//      });
//    }
  }

  @override
  Widget build(BuildContext context) {
    codeLabelBloc = CourtProvider.of(context, 'codeLabelBloc');
    courtBloc = CourtProvider.of(context, 'courtBloc');
    if(initStateCall==false){
      initWidget();
    }

    return new ListView.builder(                              //new
      padding: new EdgeInsets.all(8.0),                       //new
      itemBuilder: (_, int index) => countyItems[index],        //new
      itemCount: countyItems.length,                            //new
    );
  }
}

