import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';

class BankDetails extends StatelessWidget {

  static const routeName = '/bankDetails';


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: mainAppBar('Mes coordonnées'),

        backgroundColor: Color.fromRGBO(255, 255, 255, .9),
        body: SafeArea(
          top: true,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Column(
              children: <Widget>[
                Card(
                  elevation: 4.0,
                  child: ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    leading: Container(
                        height: double.infinity, child: Icon(Icons.dialpad, color: AppColors.ACCENT_COLOR,)),
                    title: Text('RIB', style: smallLightTextStyle(AppColors.PRIMARY_COLOR)),
                    subtitle: Text('HDG3647ZKSFDKKSKDKKSSS...', style: mediumLightTextStyle(AppColors.PRIMARY_COLOR)),
                    trailing: Container(
                      height: double.infinity,
                      child: FlatButton(
                        child: Text("Modifier", style: smallLightTextStyle(AppColors.PRIMARY_COLOR)),
                      ),
                    ),
                    onTap: () {

                    },
                  ),
                ),
                Card(
                  elevation: 4.0,
                  child: ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    leading: Container(
                        height: double.infinity, child: Icon(Icons.dialpad, color: AppColors.ACCENT_COLOR,)),
                    title: Text('Compte n°', style: smallLightTextStyle(AppColors.PRIMARY_COLOR)),
                    subtitle: Text('HDG3647Z...', style: mediumLightTextStyle(AppColors.PRIMARY_COLOR)),
                    trailing: Container(
                      height: double.infinity,
                      child: FlatButton(
                        child: Text("Modifier", style: smallLightTextStyle(AppColors.PRIMARY_COLOR)),
                      ),
                    ),
                    onTap: () {

                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
