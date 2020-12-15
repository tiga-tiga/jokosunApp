import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';

class MyContracts extends StatelessWidget {
  static const routeName = '/myContracts';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar('Mes contrats'),

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
                        height: double.infinity, child: Icon(Icons.insert_drive_file, color: AppColors.ACCENT_COLOR,)),
                    title: Text('Catégorie 1', style:regularLightTextStyle(AppColors.PRIMARY_COLOR)),
                    trailing: Container(
                      height: double.infinity,
                      child: FlatButton(
                        child: Text("Télecharger", style: smallLightTextStyle(AppColors.PRIMARY_COLOR)),
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
                        height: double.infinity, child: Icon(Icons.insert_drive_file, color: AppColors.ACCENT_COLOR,)),
                    title: Text('Catégorie 2', style:regularLightTextStyle(AppColors.PRIMARY_COLOR)),
                    trailing: Container(
                      height: double.infinity,
                      child: FlatButton(
                        child: Text("Télécharger", style: smallLightTextStyle(AppColors.PRIMARY_COLOR)),
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
