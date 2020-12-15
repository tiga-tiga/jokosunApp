import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/screens/client_suggest.dart';
import 'package:jokosun/screens/history_screen.dart';
import 'package:jokosun/screens/news_screen.dart';
import 'package:jokosun/screens/pending_installs.dart';
import 'package:jokosun/screens/profile/profile.dart';
import 'package:jokosun/screens/search_install.dart';
import 'package:jokosun/screens/shop_screen.dart';
import 'package:jokosun/widgets/app_drawer.dart';

import '../constants/app_colors.dart';
import 'installation/installation_screen.dart';

class DashBoard extends StatefulWidget {
  static const routeName = '/dashboard';

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool floatingOpened = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Dashboard',
            style: mediumBoldTextStyle(AppColors.ACCENT_COLOR),
          ),
          backgroundColor: AppColors.PRIMARY_COLOR,
          iconTheme: IconThemeData(color: AppColors.ACCENT_COLOR),
          actions: [
            Badge(
                position: BadgePosition.topEnd(top: 0, end: 3),
                animationDuration: Duration(milliseconds: 300),
                animationType: BadgeAnimationType.slide,
                badgeContent: Text(
                  '4', style: TextStyle(color: Colors.white),),
                child: IconButton(
                  icon: Icon(Icons.notifications_none, size: 28,),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(NewsScreen.routeName);
                  },
                )),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Profile.routeName);
              },
              icon: Icon(
                Icons.person,
                size: 28,
                color: AppColors.ACCENT_COLOR,
              ),
            )
          ],
        ),
        drawer: Appdrawer(),
        floatingActionButton: buildSpeedDial(context),
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical:4.0),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(HistoryScreen.routeName);
                          },
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [

                                  Text(
                                    'Expérience',
                                      style: regularBoldTextStyle(AppColors.ACCENT_COLOR)
                                  ),
                                  SizedBox(width: 8,),
                                  RatingBarIndicator(
                                    rating: 4.1,
                                    itemBuilder: (context, index) =>
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                    itemCount: 5,
                                    itemSize: 16.0,
                                    unratedColor: Colors.amber.withAlpha(50),
                                    direction: Axis.horizontal,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8,),
                              Text('Installations réalisées',
                                  style: mediumLightTextStyle(AppColors.PRIMARY_COLOR)),
                              Text('10 ',
                                  style: mediumLightTextStyle(AppColors
                                      .PRIMARY_COLOR)),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[

                                  Text('Tout voir',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          color: AppColors.PRIMARY_COLOR)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                  Card(
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:4.0),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Encaissements',
                                style: regularBoldTextStyle(AppColors.ACCENT_COLOR)
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text('À encaisser en Octobre', style: mediumLightTextStyle(AppColors.PRIMARY_COLOR),),
                            Text('300.000 Fcfa ', style: mediumLightTextStyle(AppColors.PRIMARY_COLOR),),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[

                                Text(
                                  'Tout voir',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.PRIMARY_COLOR),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:4.0),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Avantages',
                              style: regularBoldTextStyle(AppColors.ACCENT_COLOR),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Points bonus restants',
                              style: mediumLightTextStyle(AppColors.PRIMARY_COLOR),
                            ),
                            Text('280 points', style: mediumLightTextStyle(AppColors.PRIMARY_COLOR),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'Tout voir',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.PRIMARY_COLOR),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.orange,
                        width: 1.5,
                      ),
                    ),
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Prochaine installation',
                            style: regularBoldTextStyle(AppColors.ACCENT_COLOR),
                          ),
                          SizedBox(height: 8,),
                          Text(
                            'N°11',
                            style: mediumLightTextStyle(AppColors.PRIMARY_COLOR),
                          ),Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'le 16/10/2020 à 16h30',
                                style: mediumLightTextStyle(AppColors.PRIMARY_COLOR),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                                padding: EdgeInsets.all(2),
                                child: Text(
                                  'Aujourd\'hui',
                                  style: smallBoldTextStyle(Colors.white),
                                ),
                              ),
                            ],
                          ),


                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Kit 4 rémunéré 200 000 Fcfa / 80 points',
                            style: mediumLightTextStyle(AppColors.PRIMARY_COLOR),
                          ),

                          Text(
                            'Mr Diouf, Fatick, Loul-Séséne',
                            style: mediumLightTextStyle(AppColors.PRIMARY_COLOR),
                          ),
                          SizedBox(
                            height: 12,
                          ),


                          Center(
                            child: Text(
                              'Préparation terminée',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          ),
                          Center(
                            child: RaisedButton.icon(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.green)),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(InstallationScreen.routeName);
                                },
                                icon: Icon(Icons.play_circle_filled,
                                    color: Colors.green),
                                label: Text(
                                  'Démarrer l\'instalation',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              GestureDetector(
                                child: Text('Tout voir',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12,
                                        color: AppColors.PRIMARY_COLOR)),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(PendingInstalls.routeName);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ));
  }

  SpeedDial buildSpeedDial(BuildContext context) {
    return SpeedDial(
      //animatedIcon: AnimatedIcons.list_view,
      child: Icon(
        floatingOpened ? Icons.close : Icons.add,
        color: AppColors.ACCENT_COLOR,
      ),

      animatedIconTheme: IconThemeData(size: 22.0),
      backgroundColor: AppColors.PRIMARY_COLOR,
      // child: Icon(Icons.add),
      onOpen: () {
        setState(() {
          floatingOpened = true;
        });
      },
      onClose: () {
        setState(() {
          floatingOpened = false;
        });
      },
      visible: true,
      curve: Curves.bounceIn,
      children: [

        SpeedDialChild(
          child: Icon(Icons.shopping_cart, color: AppColors.ACCENT_COLOR),
          backgroundColor: AppColors.PRIMARY_COLOR,
          onTap: () {
            Navigator.of(context)
              ..pushNamed(ShopScreen.routeName);
          },
          label: 'Boutique',
          labelStyle:
          TextStyle(fontWeight: FontWeight.w300, color: AppColors.ACCENT_COLOR),
          labelBackgroundColor: AppColors.PRIMARY_COLOR,
        ),
        SpeedDialChild(
          child: Icon(Icons.person_add, color: AppColors.ACCENT_COLOR),
          backgroundColor: AppColors.PRIMARY_COLOR,
          onTap: () {
            Navigator.of(context).pushNamed(ClientSuggest.routeName);
          },
          label: 'Proposer un client',
          labelStyle:
          TextStyle(fontWeight: FontWeight.w300, color: AppColors.ACCENT_COLOR),
          labelBackgroundColor: AppColors.PRIMARY_COLOR,
        ),
        SpeedDialChild(
          child: Icon(Icons.search, color: AppColors.ACCENT_COLOR),
          backgroundColor: AppColors.PRIMARY_COLOR,
          onTap: () {
            Navigator.of(context).pushNamed(SearchInstall.routeName);
          },
          label: 'Chercher une installation',
          labelStyle:
          TextStyle(fontWeight: FontWeight.w300, color: AppColors.ACCENT_COLOR),
          labelBackgroundColor: AppColors.PRIMARY_COLOR,
        ),
      ],
    );
  }
}
