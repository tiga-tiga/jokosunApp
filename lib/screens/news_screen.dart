import 'package:flutter/material.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';

class NewsScreen extends StatelessWidget {
  static const routeName = '/newsScreen';
  var items = List<String>();

  @override
  Widget build(BuildContext context) {
    items = ['test1', 'test 2', 'test' ];
    return Scaffold(
        appBar: mainAppBar('Actualités'),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Container(
                      child: Card(
                          child: ListTile(
                    leading: Text(
                      '12/11/2020 à 20h',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: AppColors.PRIMARY_COLOR,
                          fontSize: 12),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Vous avez été séléctionné pour l\'installation 29',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: AppColors.PRIMARY_COLOR,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  )));
                })));
  }
}
