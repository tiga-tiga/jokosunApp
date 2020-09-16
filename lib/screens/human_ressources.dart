import 'package:flutter/material.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/widgets/app_drawer.dart';

class HumanResources extends StatelessWidget {
  static const routeName =  '/humanResources';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar('Ressources humaines'),
      drawer: Appdrawer(),
    );
  }
}
