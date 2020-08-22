import 'package:common/model/address.dart';
import 'package:common/model/message.dart';
import 'package:common/model/party.dart';
import 'package:courtfilechat_flutter/util/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:courtfilechat_flutter/screen/party/party_editor_screen.dart';
import './message.dart';

const kListHeight = 140.0;
const kListItemWidth = 140.0;

class PartyMessage extends MessageViewModel {
  PartyMessage({Message message}) : super(message: message);

  var _casePartyList = <Party>[];
  @override
  Widget build() {
    var parties = content['parties'];
    _casePartyList = <Party>[];
    parties = parties.map((snapShot) => Party.fromMap(snapShot)).toList();

    for (Party p in parties) {
      _casePartyList.add(p);
    }
    return _ActionList(
      partyList: _casePartyList,
    );
  }
}

class _ActionList extends StatefulWidget {
  final List<Party> partyList;

  const _ActionList({Key key, this.partyList}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ActionListState();
  }
}

class _ActionListState extends State<_ActionList> {
  @override
  Widget build(BuildContext context) {
    var partyList = widget.partyList ?? <Party>[];
    return Container(
      decoration: new BoxDecoration(
          border: new Border.all(color: CustomColors.grayColor),
          borderRadius: BorderRadius.circular(8.0)),
      margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      child: new Column(
        children: <Widget>[
          Container(
            child: GestureDetector(
              child: _getPartyHeading(),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => PartyEditorScreen(
                        party: partyList.length > 0 ? partyList[0] : Party(),
                      ))),
            ),
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 1.0),
            decoration: BoxDecoration(
                color: Colors.orange, borderRadius: BorderRadius.circular(8.0)),
          ),
          PartyList(
            partyList: partyList,
          ),
        ],
      ),
    );
  }

  Widget _getPartyHeading() {
    var title = 'Parties';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 25.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: _getTextStyle()
                  .merge(TextStyle(color: CustomColors.whiteColor)),
            ),
          ),
          // RaisedButton(
          //   elevation: 4.0,
          //   shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.all(Radius.circular(25.0))),
          //   color: Colors.blue,
          //   onPressed: () {},
          //   child: Container(
          //       child: Text(
          //     'Add Party',
          //     style: TextStyle(color: Colors.white, fontSize: 12.0),
          //   )),
          // ),
        ],
      ),
    );
  }
}

class PartyList extends StatefulWidget {
  final List<Party> partyList;
  final ValueChanged<int> posActiveChange;
  const PartyList({Key key, this.partyList, this.posActiveChange})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _PartyListState();
  }
}

class _PartyListState extends State<PartyList> {
  int _activePost = -1;

  @override
  Widget build(BuildContext context) {
    var partyList = widget.partyList ?? [];
    return Container(
      height: kListHeight,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: partyList.length,
          itemBuilder: (BuildContext ctxt, int index) =>
              _partyListItemDisplay(index, partyList[index])),
    );
  }

  Widget _partyListItemDisplay(int pos, Party party) {
    String partyName;
    if (party.asCompany) {
      partyName = party.companyName;
    } else {
      partyName = party.firstName + " " + party.lastName;
    }

    String addressString = "";
    String state = "";
    String city = "";
    String zip = "";
    if (party.addresses.length > 0) {
      Address address = party.addresses[0];

      addressString = address.line1;

      if (address.line2 != null && address.line2.isNotEmpty) {
        addressString += address.line2;
      }
      state = address.state;
      city = address.city;
      zip = address.zip;
    }

    var infoHeight = 15.0;
    var isActive = pos == _activePost;
    return Container(
      width: kListItemWidth,
      margin: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
      padding: const EdgeInsets.all(3.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: CustomColors.grayColor)),
      child: new Container(
        width: kListItemWidth,
        padding: const EdgeInsets.all(3.0),
        color: isActive ? CustomColors.grayColor : CustomColors.whiteColor,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              child: Text(
                "$partyName",
                style: _getTextStyle(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              height: infoHeight,
            ),
            new Text(
              "$addressString",
              textAlign: TextAlign.start,
              style: _getTextStyle(),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            new Text(
              "$city $state $zip",
              textAlign: TextAlign.start,
              style: _getTextStyle(),
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
            ),
            Expanded(
              child: Text(
                "${party.partyCodeDesc}",
                style: _getTextStyle().merge(TextStyle(
                  fontWeight: FontWeight.w600,
                )),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

TextStyle _getTextStyle() {
  return TextStyle(
      fontSize: 12.0,
      color: CustomColors.blackColor,
      fontWeight: FontWeight.w500,
      fontFamily: "Roboto");
}
