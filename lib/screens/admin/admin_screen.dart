import 'package:flutter/material.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/screens/admin/admin_companies_screen.dart';
import 'package:jokosun/screens/admin/admin_installations.dart';
import 'package:jokosun/screens/admin/admin_offers_screen.dart';

class AdminScreen extends StatefulWidget {
  static const routeName = '/adminScreen';

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  bool floatingOpened = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Admin',
            style: mediumBoldTextStyle(AppColors.ACCENT_COLOR),
          ),
          backgroundColor: AppColors.PRIMARY_COLOR,
          iconTheme: IconThemeData(color: AppColors.ACCENT_COLOR),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 8,
                  ),
                  Card(
                      elevation: 2,
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AdminOffers.routeName);
                        },
                        leading: Icon(
                          Icons.description,
                          color: AppColors.PRIMARY_COLOR,
                        ),
                        title: Text('Les offres',
                            style:
                                regularLightTextStyle(AppColors.PRIMARY_COLOR)),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: AppColors.PRIMARY_COLOR,
                        ),
                      )),
                  Card(
                      elevation: 2,
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AdminInstallations.routeName);
                        },
                        leading: Icon(
                          Icons.timer,
                          color: AppColors.PRIMARY_COLOR,
                        ),
                        title: Text('Les installations',
                            style:
                                regularLightTextStyle(AppColors.PRIMARY_COLOR)),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: AppColors.PRIMARY_COLOR,
                        ),
                      )),
                  Card(
                      elevation: 2,
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AdminCompaniesScreen.routeName);
                        },
                        leading: Icon(
                          Icons.group,
                          color: AppColors.PRIMARY_COLOR,
                        ),
                        title: Text('Les installateurs',
                            style:
                                regularLightTextStyle(AppColors.PRIMARY_COLOR)),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: AppColors.PRIMARY_COLOR,
                        ),
                      )),
                  Card(
                      elevation: 2,
                      child: ListTile(
                        onTap: () {
                          // Navigator.of(context)                              .pushNamed(HistoryScreen.routeName);
                        },
                        leading: Icon(
                          Icons.list,
                          color: AppColors.PRIMARY_COLOR,
                        ),
                        title: Text('Les kits',
                            style:
                                regularLightTextStyle(AppColors.PRIMARY_COLOR)),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: AppColors.PRIMARY_COLOR,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
