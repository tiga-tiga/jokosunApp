import 'package:flutter/material.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/screens/client_suggest.dart';
import 'package:jokosun/screens/dash_board.dart';
import 'package:jokosun/screens/pending_installs.dart';
import 'package:jokosun/screens/search_install.dart';

class Appdrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Container(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: AppColors.ACCENT_COLOR,
              child: DrawerHeader(

                child: Text('Drawer Header', style: TextStyle(color: AppColors.PRIMARY_COLOR, fontSize: 16),),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Tableau de bord',
                      style: TextStyle(color: AppColors.PRIMARY_COLOR),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacementNamed(DashBoard.routeName);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Installations en attentes',
                      style: TextStyle(color: AppColors.PRIMARY_COLOR),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacementNamed(PendingInstalls.routeName);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Chercher une install',
                      style: TextStyle(color: AppColors.PRIMARY_COLOR),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context)
                          .pushReplacementNamed(SearchInstall.routeName);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Proposer un client',
                      style: TextStyle(color: AppColors.PRIMARY_COLOR),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context)
                          .pushReplacementNamed(ClientSuggest.routeName);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Ressources humaine',
                      style: TextStyle(color: AppColors.PRIMARY_COLOR),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context)
                          .pushReplacementNamed(ClientSuggest.routeName);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.add),
                    title: Text(
                      'Equipe',
                      style: TextStyle(color: AppColors.PRIMARY_COLOR),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context)
                          .pushReplacementNamed(ClientSuggest.routeName);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.add),
                    title: Text(
                      'Se former',
                      style: TextStyle(color: AppColors.PRIMARY_COLOR),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context)
                          .pushReplacementNamed(ClientSuggest.routeName);
                    },
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
