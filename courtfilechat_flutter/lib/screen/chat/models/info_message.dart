import 'package:common/model/message.dart';
import 'package:common/model/party.dart';
import 'package:courtfilechat_flutter/util/custom_colors.dart';
import 'package:flutter/material.dart';

import './message.dart';

class InfoMessage extends MessageViewModel {
  final ValueChanged<String> eventValueChange;
  InfoMessage({Message message, this.eventValueChange}) : super(message: message);

  @override
  Widget build() {
    var judge = content['judge'];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Card(
        elevation: 4.0,
        child: Container(
          padding: const EdgeInsets.all(5.0),
          color: CustomColors.whiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                content['caseNumber'] ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    TextStyle(color: CustomColors.blackColor, fontSize: 16.0),
              ),
              Text(
                content['caseCodeDesc'] ?? '',
                maxLines: 1,
                style:
                    TextStyle(color: CustomColors.blackColor, fontSize: 16.0),
              ),
              Text(
                content['caseCaption'] ?? _getCaseCaption(content),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style:
                    TextStyle(color: CustomColors.blackColor, fontSize: 16.0),
              ),
              judge != null ? 
              Text(
                "Judge : ${judge['firstName']} ${judge['middleInitial']} ${judge['lastName']}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    TextStyle(color: CustomColors.blackColor, fontSize: 16.0),
              ) : Container(),
              SizedBox(height: 10.0,),
              judge != null ? _buildShowPartyButton() : Container(),
            ],
          ),
        ),
      ),
    );
  }

  _buildShowPartyButton() {
    return Center(
      child: RaisedButton(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25.0)) ),
        color: Colors.blue,
        onPressed: () {
          if (eventValueChange != null){
            eventValueChange('List Party');
          }
        },
        child: Container(
            child: Text(
              'List Party',
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            )),
      ),
    );
  }

  String _getCaseCaption(dynamic content) {
    var parties = content['parties'];
    parties = parties.map((snapShot) => Party.fromMap(snapShot)).toList();

    String caseCaption = "";
    for (int i = 0; i < parties.length; i++) {
      Party party = parties[i];

      if (caseCaption.isNotEmpty) {
        caseCaption += " VS ";
      }

      if (party.asCompany) {
        caseCaption += party.companyName;
      } else {
        caseCaption += party.firstName + " " + party.lastName;
      }
    }

    return caseCaption;
  }
}
