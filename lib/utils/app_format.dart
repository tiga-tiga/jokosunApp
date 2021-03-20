

import 'package:intl/intl.dart';
import 'package:jokosun/models/installations_model.dart';



String formatCurrency(int amount) {
  var f = new NumberFormat.currency(locale: "fr-FR",symbol: "", decimalDigits: 0);
  return '${f.format(amount)} ';
}

int dayDifference(String date) {
  DateTime aDateTime = DateFormat("dd/MM/yy hh:mm").parse(date);
  DateTime now = DateTime.now();
  return aDateTime.difference(now).inDays;
}
