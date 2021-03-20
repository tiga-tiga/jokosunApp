import 'package:flutter/material.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/models/user_model.dart';
import 'package:jokosun/providers/user.dart';
import 'package:jokosun/screens/admin/admin_screen.dart';
import 'package:jokosun/screens/client_suggest.dart';
import 'package:jokosun/screens/dash_board.dart';
import 'package:jokosun/screens/pending_installs.dart';
import 'package:jokosun/screens/search_install.dart';
import 'package:jokosun/screens/shop_screen.dart';
import 'package:provider/provider.dart';

class Appdrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    UserModel userModel = Provider.of<UserProvider>(context).user;
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
              child: UserAccountsDrawerHeader(

                decoration: BoxDecoration(color: AppColors.PRIMARY_COLOR),
                accountName: Text('Installateur'),
                accountEmail: Text('gmtsarr@gmail.com'),
                currentAccountPicture: new CircleAvatar(
                  radius: 50.0,
                  backgroundColor: const Color(0xFF778899),
                  backgroundImage:
                  NetworkImage("https://tineye.com/images/widgets/mona.jpg"),
                ),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.description, color: Colors.orange,),
                        SizedBox(width: 5,),
                        Text(
                          'Tableau de bord',
                          style: TextStyle(color: AppColors.PRIMARY_COLOR),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacementNamed(DashBoard.routeName);
                    },
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.lock_clock, color: Colors.red.shade500,),
                        SizedBox(width: 5,),
                        Text(
                          'Mes Installations',
                          style: TextStyle(color: AppColors.PRIMARY_COLOR),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed(PendingInstalls.routeName);
                    },
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey,),
                        SizedBox(width: 5,),
                        Text(
                          'Chercher une installation',
                          style: TextStyle(color: AppColors.PRIMARY_COLOR),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context)
                          .pushNamed(SearchInstall.routeName);
                    },
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.add, color: Colors.green.shade300,),
                        SizedBox(width: 5,),
                        Text(
                          'Proposer un client',
                          style: TextStyle(color: AppColors.PRIMARY_COLOR),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context)
                          .pushNamed(ClientSuggest.routeName);
                    },
                  ),


                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.shopping_cart, color: Colors.orange,),
                        SizedBox(width: 5,),
                        Text(
                          'Aller à la boutique',
                          style: TextStyle(color: AppColors.PRIMARY_COLOR),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context)
                          .pushNamed(ShopScreen.routeName);
                    },
                  ),
                  userModel.role.id ==  1 ?ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.person, color: Colors.cyan,),
                        SizedBox(width: 5,),
                        Text(
                          'Admin',
                          style: TextStyle(color: AppColors.PRIMARY_COLOR),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context)
                          .pushNamed(AdminScreen.routeName);
                    },
                  ): SizedBox() ,

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
