import 'package:common/bloc/filing_bloc.dart';
import 'package:flutter/material.dart';
import 'package:courtfilechat_flutter/util/custom_colors.dart';
import 'package:courtfilechat_flutter/bloc_provider/filing_provider.dart';
import 'package:common/model/filing.dart';
import 'package:common/util/format_util.dart';
import 'package:intl/intl.dart';

class FilePage extends StatefulWidget {
  FilePage() {}

  @override
  State<StatefulWidget> createState() {
    return new FilePageState();
  }
}

class FilePageState extends State<FilePage> {
  String _searchTxt = "";

  final _searchBox = TextEditingController();

  FilePageState() {}

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    FilingBloc filingBloc = FilingProvider.of(context);

    return new Scaffold(
        appBar: AppBar(
          bottomOpacity: 20.0,
          title: new TextField(
              onChanged: (text) {
                print("Searched Value is: $text");
              },
              controller: _searchBox,
              decoration: new InputDecoration(
                  contentPadding: const EdgeInsets.all(0.0),
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                        const Radius.circular(5.0),
                        ),
                    borderSide: new BorderSide(
                        color: Colors.black,
                        width: 1.0,
                        ),
                    ),
                  hintText: '',
                  filled: true,
                  prefixIcon: Icon(
                      Icons.search,
                      size: 28.0,
                      ),
                  suffixIcon: IconButton(
                      icon: Icon(Icons.mic),
                      onPressed: () {
                        _searchBox.clear();
                        setState(() {
                          _searchTxt = "";
                        });
                      }),
                  ),
              ),
        ),
        body: new StreamBuilder<List<Filing>>(
            stream: filingBloc.getFilingList("sessionId"),
            builder: (context, AsyncSnapshot<List<Filing>> filingList) {
            if (!filingList.hasData) return const Text('Loading...');

            List<Widget> itemWidgetList = new List<Widget>();
            filingList.data.forEach((Filing filing) {
              itemWidgetList.add(_buildListItem(filing));
            });

            return new SingleChildScrollView(
                child: new Column(
                    children: itemWidgetList
                    ),
                );
            }
        )


    );
  }

  Widget _newCaseCard(Filing filing) {

    String filingDate = Utils.singleton.getFormattedTime(filing.filingDate);
    String caseNumber = getCaseNumber(filing);

    return new Container(
        padding: const EdgeInsets.only(top: 10.0),
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new  Icon(
                            Icons.mail,
                            size: 28.0,
                            ),
                      ],
                      )),
              new Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                                "(" + caseNumber + ") " + filing.caseCaption,
                                style: new TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Roboto"),
                                ),
                            new Text(
                                filingDate,
                                style: new TextStyle(
                                    fontSize: 12.0,
                                    color: Color(0xff8a8a8a),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Roboto"),
                                ),
                          ],
                          ),
                      )),
              new Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new  Icon(
                            Icons.menu,
                            size: 28.0,
                            ),
                      ],
                      ))
            ],
            ),
        );
  }

  Widget _newFilingCard(Filing filing) {

    String filingDate = Utils.singleton.getFormattedTime(filing.filingDate);
    String caseNumber = getCaseNumber(filing);

    return new Container(
        padding: const EdgeInsets.only(top: 10.0),
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new  Icon(
                            Icons.mail_outline,
                            size: 28.0,
                            ),
                      ],
                      )),
              new Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                                filing.caseCaption,
                                style: new TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Roboto"),
                                ),
                            new Text(
                                filingDate,
                                style: new TextStyle(
                                    fontSize: 12.0,
                                    color: Color(0xff8a8a8a),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Roboto"),
                                ),
                            new Text(
                                caseNumber,
                                style: new TextStyle(
                                    fontSize: 13.5,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Roboto"),
                                ),
                          ],
                          ),
                      )),
              new Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new  Icon(
                            Icons.menu,
                            size: 28.0,
                            ),
                      ],
                      ))
            ],
            ),
        );
  }

  Widget _serveFilingCard(Filing filing) {

    String filingDate = Utils.singleton.getFormattedTime(filing.filingDate);
    String caseNumber = getCaseNumber(filing);

    return new Container(
        padding: const EdgeInsets.only(top: 10.0),
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new  Icon(
                            Icons.markunread_mailbox,
                            size: 28.0,
                            ),
                      ],
                      )),
              new Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                                filing.caseCaption,
                                style: new TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Roboto"),
                                ),
                            new Text(
                                filingDate,
                                style: new TextStyle(
                                    fontSize: 12.0,
                                    color: Color(0xff8a8a8a),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Roboto"),
                                ),
                            new Text(
                                caseNumber,
                                style: new TextStyle(
                                    fontSize: 13.5,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Roboto"),
                                ),
                          ],
                          ),
                      )),
              new Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new  Icon(
                            Icons.menu,
                            size: 28.0,
                            ),
                      ],
                      ))
            ],
            ),
        );
  }

  String getCaseNumber(Filing filing){
    String caseNumber = "";
    if(filing.caseNumber != null){
      if(filing.caseNumber.caseNumber != null && filing.caseNumber.caseNumber != ""){
        caseNumber = filing.caseNumber.caseNumber;
      }
      else{
        caseNumber = filing.pendingCaseNumber;
      }
    }
    else{
      caseNumber = filing.pendingCaseNumber;
    }
    return caseNumber;
  }

  Widget _buildListItem(Filing filing) {
    Widget currentWidget;
    if(filing.filingType == "NewCase"){
      currentWidget = _newCaseCard(filing);
    }
    else if(filing.filingType == "NewFiling"){
      currentWidget = _newFilingCard(filing);
    }
    else if(filing.filingType == "ServeFiling"){
      currentWidget = _serveFilingCard(filing);
    }

    return new ListTile(
        key: new ValueKey(filing.pendingCaseNumber),
        title: currentWidget,
        contentPadding: EdgeInsets.all(0.0),
        onTap: () {
//                _openPODetail(order.poNumber);
        },
        );
  }
}
