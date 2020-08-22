import 'package:intl/intl.dart';

class Utils {
  static final Utils singleton = new Utils._internal();

  factory Utils() {
    return singleton;
  }

  Utils._internal();

  String getFormattedTime(DateTime dateTime){

    DateFormat dateFormat = new DateFormat("dd-MM-yyyy hh:mm a");
    return dateFormat.format(dateTime).toString();
  }

  String formatEmailToString(String email){
    return email.replaceAll("@", "").replaceAll(".", "").replaceAll("_", "");
  }

}