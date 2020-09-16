import 'package:flutter/material.dart';
import 'package:jokosun/widgets/app_drawer.dart';
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Appdrawer(),
    );
  }
}
