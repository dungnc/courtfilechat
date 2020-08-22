import 'package:common/model/message.dart';
import 'package:courtfilechat_flutter/util/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './message.dart';

class CustomerMessage extends MessageViewModel {
  CustomerMessage({Message message}) : super(message: message);

  @override
  Widget build() {
    return Builder(
      builder: (BuildContext context) => Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Expanded(child: Container()),
                    GestureDetector(
                      child: Container(
                        child: Text(
                          content.toString(),
                          style: TextStyle(color: CustomColors.blueColor),
                        ),
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        width: 200.0,
                        decoration: BoxDecoration(
                            color: CustomColors.lightGrayColor,
                            borderRadius: BorderRadius.circular(8.0)),
                        margin: EdgeInsets.only(right: 10.0),
                      ),
                      onLongPress: () {
                        showLongPressAction(context, copy: content.toString());
                      },
                    ),
                  ],
                ),
                Container(
                  child: Text(
                    DateFormat('dd MMM kk:mm').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            int.parse(timestamp))),
                    style: TextStyle(
                        color: CustomColors.grayColor,
                        fontSize: 12.0,
                        fontStyle: FontStyle.italic),
                  ),
                  margin: EdgeInsets.only(right: 50.0, top: 5.0, bottom: 5.0),
                ),
              ],
            ),
          ),
    );
  }
}
