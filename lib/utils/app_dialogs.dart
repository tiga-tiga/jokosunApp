
import 'package:flutter/material.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_text.dart';

class AppDialogs {

  Future<void> showResponseDialog(BuildContext context, String message, bool success) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text('Message',
                style: TextStyle(
                    fontSize: 18.0,
                    color: AppColors.PRIMARY_COLOR_DARK,
                    fontWeight: FontWeight.w300,
                    decoration: TextDecoration.underline)),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            success
                ? FlatButton(
              child: Text('Ok',  style: mediumBoldTextStyle(AppColors.PRIMARY_COLOR)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
                : FlatButton(
              child: Text('Reessayer', style: mediumBoldTextStyle(AppColors.PRIMARY_COLOR)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
Future<bool> showConfirmationDialog(BuildContext context, String message) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text('Message',
                style: TextStyle(
                    fontSize: 18.0,
                    color: AppColors.PRIMARY_COLOR_DARK,
                    fontWeight: FontWeight.w300,
                    decoration: TextDecoration.underline)),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
          FlatButton(
              child: Text('Ok', style: mediumBoldTextStyle(AppColors.PRIMARY_COLOR),),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
             FlatButton(
              child: Text('Annuler', style: mediumBoldTextStyle(AppColors.PRIMARY_COLOR)),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> showMainErrorDialog(BuildContext context, String message) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:Center(
            child: Text('Message', style: TextStyle(
                fontSize: 18.0,
                color: AppColors.PRIMARY_COLOR_DARK,
                fontWeight: FontWeight.w300, decoration: TextDecoration.underline)),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Quitter'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text('Réessayer'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  Future<DateTime> showDatePickerDialod(BuildContext context, DateTime selectedDate){
    return showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(), // This will change to light theme.
          child: child,
        );
      },
    );
  }

 Future<TimeOfDay> showTimePickerDialog(BuildContext context, TimeOfDay selectedTime){
    return showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(), // This will change to light theme.
          child: child,
        );
      },
    );
  }


  /// This builds material date picker in Android
//  Future<DateTime> buildMaterialDatePicker(BuildContext context, DateTime selectedDate) async {
//    return  showDatePicker(
//      context: context,
//      initialDate: selectedDate,
//      firstDate: DateTime.now(),
//      lastDate: DateTime(2025),
//      builder: (context, child) {
//        return Theme(
//          data: ThemeData.light(),
//          child: child,
//        );
//      },
//    );
//
//  }
//  /// This builds cupertion date picker in iOS
//  Future<DateTime> buildCupertinoDatePicker(BuildContext context, DateTime selectedDate) {
//    return  showModalBottomSheet(
//        context: context,
//        builder: (BuildContext builder) {
//          return Container(
//            height: MediaQuery.of(context).copyWith().size.height / 3,
//            color: Colors.white,
//            child: CupertinoDatePicker(
//              mode: CupertinoDatePickerMode.date,
//
//              initialDateTime: selectedDate,
//              onDateTimeChanged: (date) {
//                selectedDate = date;
//                return selectedDate;
//              },
//              minimumYear: DateTime.now().year,
//              maximumYear: 2025,
//            ),
//          );
//        });
//
//  }
//
//  Future<DateTime> showDatePickerDialod(BuildContext context, DateTime selectedDate) {
//    final ThemeData theme = Theme.of(context);
//    assert(theme.platform != null);
//    switch (theme.platform) {
//      case TargetPlatform.android:
//      case TargetPlatform.fuchsia:
//      case TargetPlatform.linux:
//      case TargetPlatform.windows:
//        return buildMaterialDatePicker(context, selectedDate);
//      case TargetPlatform.iOS:
//      case TargetPlatform.macOS:
//        return buildCupertinoDatePicker(context, selectedDate);
//    }
//  }

}