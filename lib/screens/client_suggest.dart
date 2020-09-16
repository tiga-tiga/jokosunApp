import 'package:flutter/material.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/widgets/app_drawer.dart';


class ClientSuggest extends StatelessWidget {

  static const routeName =  '/clientSuggest';
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: mainAppBar('Proposer un client'),
      drawer: Appdrawer(),
    );
  }
}
