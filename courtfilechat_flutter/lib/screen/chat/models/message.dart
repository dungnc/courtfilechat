import 'package:flutter/material.dart';
import 'package:common/model/message.dart';
import 'package:flutter/services.dart';

class MessageViewModel extends Message {
  MessageViewModel({Message message}) {
    assert(message != null, 'message object cannot null');
    content = message.content;
    idFrom = message.idFrom;
    idTo = message.idTo;
    timestamp = message.timestamp;
    type = message.type;
    featureType = message.featureType;
  }

  BoxDecoration boxDecoration = BoxDecoration(
    border: Border.all(),
    borderRadius: BorderRadius.all(
      Radius.circular(4.0),
    ),
  );

  Widget build() {
    return Container(
      decoration: boxDecoration,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(10.0),
      child: Text(content ?? ""),
    );
  }
}

showLongPressAction(BuildContext context, {String copy: ''}) {
  final RenderBox button = context.findRenderObject();
  final RenderBox overlay = Overlay.of(context).context.findRenderObject();
  final RelativeRect position = new RelativeRect.fromRect(
    //button.size.center(Offset.zero).dx / 2
    new Rect.fromPoints(
      button.localToGlobal(Offset(button.size.center(Offset.zero).dx / 2, button.size.height - 25.0), ancestor: overlay),
      button.localToGlobal(button.size.bottomCenter(Offset.zero),
          ancestor: overlay),
    ),
    Offset.zero & overlay.size,
  );
  showMenu(context: context, position: position, items: [
    PopupMenuItem(
      child: Text('Copy'),
      value: 'copy',
    ),
  ]).then((value) {
    if (value != null && value == 'copy') {
      Clipboard.setData(new ClipboardData(text: copy));
    }
  });
}
