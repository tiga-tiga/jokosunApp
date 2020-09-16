import 'package:flutter/material.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/widgets/app_drawer.dart';
class SearchInstall extends StatefulWidget {
  static const routeName =  '/searchInstall';
  @override
  _SearchInstallState createState() => _SearchInstallState();
}

class _SearchInstallState extends State<SearchInstall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar('Rechercher une installation'),
      drawer: Appdrawer(),
    );
  }
}
