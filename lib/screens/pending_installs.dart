import 'package:flutter/material.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/widgets/app_drawer.dart';

class PendingInstalls extends StatelessWidget {

  static const routeName =  '/pendingInstalls';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar('Installations en attentes'),
      drawer: Appdrawer(),
    );
  }
}
