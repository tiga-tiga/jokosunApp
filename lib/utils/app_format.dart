

import 'package:intl/intl.dart';
import 'package:jokosun/models/installations_model.dart';



String formatCurrency(int amount) {
  var f = new NumberFormat.currency(locale: "fr-FR",symbol: "", decimalDigits: 0);
  return '${f.format(amount)} ';
}
