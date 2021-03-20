import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart' as http;
import 'package:jokosun/constants/app_api.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/models/dashboard_model.dart';
import 'package:jokosun/models/response_model.dart';
import 'package:jokosun/screens/client_suggest.dart';
import 'package:jokosun/screens/history_screen.dart';
import 'package:jokosun/screens/news_screen.dart';
import 'package:jokosun/screens/pending_installs.dart';
import 'package:jokosun/screens/profile/profile.dart';
import 'package:jokosun/screens/search_install.dart';
import 'package:jokosun/screens/shop_screen.dart';
import 'package:jokosun/screens/technical_sheet_screen.dart';
import 'package:jokosun/utils/app_format.dart';
import 'package:jokosun/widgets/app_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_colors.dart';
import 'installation/installation_timeline.dart';

class DashBoard extends StatefulWidget {
  static const routeName = '/dashboard';

  @override
  _DashBoardState createState() => _DashBoardState();
}

Future<ResponseModel> _future;

class _DashBoardState extends State<DashBoard> {
  bool floatingOpened = false;
  bool loading = false;
  DashboardModel dashboard;

  Future<ResponseModel> getDashboard() async {
    // items.clear();
    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    print(token);

    final response = await http.get(
      '$baseUrl/dashboard',
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    ResponseModel responseModel = responseModelFromJson(response.body);
    print('dashboard ok');
    print(responseModel.data);
    dashboard = DashboardModel.fromJson(responseModel.data);

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    _future = getDashboard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(body: loadingLayout())
        : Scaffold(
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
                      dashboard.unreadNotifications.count.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.notifications_none,
                        size: 28,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(NewsScreen.routeName);
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
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
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
                                      Text('Expérience',
                                          style: regularBoldTextStyle(
                                              AppColors.ACCENT_COLOR)),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      RatingBarIndicator(
                                        rating: 4.1,
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: 16.0,
                                        unratedColor:
                                            Colors.amber.withAlpha(50),
                                        direction: Axis.horizontal,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text('Installations réalisées',
                                      style: mediumLightTextStyle(
                                          AppColors.PRIMARY_COLOR)),
                                  Text(
                                      dashboard.finishedInstallations
                                          .toString(),
                                      style: mediumLightTextStyle(
                                          AppColors.PRIMARY_COLOR)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text('Tout voir',
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
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
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Encaissements',
                                    style: regularBoldTextStyle(
                                        AppColors.ACCENT_COLOR)),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'À encaisser en Octobre',
                                  style: mediumLightTextStyle(
                                      AppColors.PRIMARY_COLOR),
                                ),
                                Text(
                                  dashboard.balance
                                      .toString() + ' Fcfa',
                                  style: mediumLightTextStyle(
                                      AppColors.PRIMARY_COLOR),
                                ),
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
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Avantages',
                                  style: regularBoldTextStyle(
                                      AppColors.ACCENT_COLOR),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Points bonus restants',
                                  style: mediumLightTextStyle(
                                      AppColors.PRIMARY_COLOR),
                                ),
                                Text(
                                  '${dashboard.bonus} points',
                                  style: mediumLightTextStyle(
                                      AppColors.PRIMARY_COLOR),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                      dashboard.nextInstallation != null ?
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Prochaine installation',
                                style: regularBoldTextStyle(
                                    AppColors.ACCENT_COLOR),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'N°${dashboard.nextInstallation.id}',
                                style: mediumLightTextStyle(
                                    AppColors.PRIMARY_COLOR),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '${dashboard.nextInstallation.application.offer.commissioningDate}',
                                    style: mediumLightTextStyle(
                                        AppColors.PRIMARY_COLOR),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  dayDifference(dashboard
                                              .nextInstallation
                                              .application
                                              .offer
                                              .commissioningDate) >
                                          0
                                      ? Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 4),
                                          child: Text(
                                            'Dans ${dayDifference(dashboard.nextInstallation.application.offer.commissioningDate)}  jours',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 4),
                                          child: Text(
                                            'Aujourd\'hui',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Kit ${dashboard.nextInstallation.application.offer.kit.name} rémunéré ${formatCurrency(int.parse(dashboard.nextInstallation.application.offer.flatRate))}Fcfa / bonus ${dashboard.nextInstallation.application.offer.kit.category.coefficient} points',
                                style: mediumLightTextStyle(
                                    AppColors.PRIMARY_COLOR),
                              ),
                              Text(
                                '${dashboard.nextInstallation.application.offer.customerName}',
                                style: mediumLightTextStyle(
                                    AppColors.PRIMARY_COLOR),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              dashboard.nextInstallation.status == 'PENDING'
                                  ? Center(
                                      child: Text(
                                        'Préparation non terminé',
                                        style: smallBoldTextStyle(Colors.red),
                                      ),
                                    )
                                  : dashboard.nextInstallation.status ==
                                          'FINISHED'
                                      ? Center(
                                          child: Text(
                                            'Installation terminée',
                                            style: smallBoldTextStyle(
                                                Colors.green),
                                          ),
                                        )
                                      : dashboard.nextInstallation.status ==
                                              'CHECKLIST'
                                          ? Center(
                                              child: Text(
                                                'Préparation terminée',
                                                style: smallBoldTextStyle(
                                                    Colors.green),
                                              ),
                                            )
                                          : SizedBox(),
                              dashboard.nextInstallation.status == 'PENDING'
                                  ? Center(
                                      child: RaisedButton.icon(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: Colors.orange)),
                                          color: Colors.white,
                                          onPressed: () async {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        TechnicalSheetScreen(
                                                          installationId: dashboard
                                                              .nextInstallation
                                                              .id,
                                                        )))
                                                .then((value) {
                                              if (value != null && value) {
                                                getDashboard();
                                              }
                                            });
                                          },
                                          icon: Icon(Icons.warning,
                                              color: Colors.orange),
                                          label: Text(
                                            ' Finir la préparation',
                                            style: smallBoldTextStyle(
                                                Colors.orange),
                                          )),
                                    )
                                  : dashboard.nextInstallation.status ==
                                          'FINISHED'
                                      ? SizedBox()
                                      : Center(
                                          child: RaisedButton.icon(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                  side: BorderSide(
                                                      color: Colors.green)),
                                              color: Colors.white,
                                              onPressed: () async {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                        builder: (context) =>
                                                            InstallationTimeline(
                                                              installation:
                                                                  dashboard
                                                                      .nextInstallation,
                                                            )))
                                                    .then((value) {
                                                  getDashboard();
                                                });
                                              },
                                              icon: Icon(
                                                  Icons.play_circle_filled,
                                                  color: Colors.green),
                                              label: Text(
                                                dashboard.nextInstallation
                                                            .status ==
                                                        'CHECKLIST'
                                                    ? "Démarrer l'installation"
                                                    : "Continuer l'installation",
                                                style: smallBoldTextStyle(
                                                    Colors.green),
                                              )),
                                        ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  GestureDetector(
                                    child: Text('Tout voir',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
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
                      ): SizedBox(),
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
            Navigator.of(context)..pushNamed(ShopScreen.routeName);
          },
          label: 'Boutique',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w300, color: AppColors.ACCENT_COLOR),
          labelBackgroundColor: AppColors.PRIMARY_COLOR,
        ),
        SpeedDialChild(
          child: Icon(Icons.person_add, color: AppColors.ACCENT_COLOR),
          backgroundColor: AppColors.PRIMARY_COLOR,
          onTap: () {
            Navigator.of(context).pushNamed(ClientSuggest.routeName);
          },
          label: 'Proposer un client',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w300, color: AppColors.ACCENT_COLOR),
          labelBackgroundColor: AppColors.PRIMARY_COLOR,
        ),
        SpeedDialChild(
          child: Icon(Icons.search, color: AppColors.ACCENT_COLOR),
          backgroundColor: AppColors.PRIMARY_COLOR,
          onTap: () {
            Navigator.of(context).pushNamed(SearchInstall.routeName);
          },
          label: 'Chercher une installation',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w300, color: AppColors.ACCENT_COLOR),
          labelBackgroundColor: AppColors.PRIMARY_COLOR,
        ),
      ],
    );
  }
}
