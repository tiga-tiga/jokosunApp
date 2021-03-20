import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/models/installations_model.dart';
import 'package:jokosun/models/response_model.dart';
import 'package:jokosun/providers/user.dart';
import 'package:jokosun/screens/installation/installation_timeline.dart';
import 'package:jokosun/screens/technical_sheet_screen.dart';
import 'package:jokosun/utils/app_format.dart';
import 'package:jokosun/widgets/installation_timaline.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PendingInstalls extends StatefulWidget {
  static const routeName = '/pendingInstalls';

  @override
  _PendingInstallsState createState() => _PendingInstallsState();
}

Future<ResponseModel> _future;

class _PendingInstallsState extends State<PendingInstalls> {
  var items = List<Installation>();
  bool loading = false;
  int companyId;
  var _value = "all";

  Future<ResponseModel> getInstallations(String status, int companyId) async {
    // items.clear();
    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    print(token);

    var queryParameters;
    var uri;
    if (status != null && status != 'all') {
      queryParameters = {
        'status': status,
      };
      uri = Uri.https(
          'jokosun.dohappit.com', '/api/installations/$companyId', queryParameters);
    } else {
      uri = Uri.https('jokosun.dohappit.com', '/api/installations/$companyId');
    }

    final response = await http.get(
      uri,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    ResponseModel responseModel = responseModelFromJson(response.body);

    items = Installations.fromJson(responseModel.data).installations;
    items.sort((a, b) {
      DateTime aDateTime = DateFormat("dd/MM/yy hh:mm")
          .parse(a.application.offer.commissioningDate);
      DateTime bDateTime = DateFormat("dd/MM/yy hh:mm")
          .parse(b.application.offer.commissioningDate);
      return aDateTime.compareTo(bDateTime);
    });
    setState(() {
      loading = false;
    });
  }

  int dayDifference(String date) {
    DateTime aDateTime = DateFormat("dd/MM/yy hh:mm").parse(date);
    DateTime now = DateTime.now();
    return aDateTime.difference(now).inDays;
  }

  @override
  void initState() {
    companyId = Provider.of<UserProvider>(context, listen: false).user.company.id;
    _future = getInstallations(null, companyId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(body: loadingLayout())
        : Scaffold(
            appBar: mainAppBar('Installations en attentes'),
            body: FutureBuilder<ResponseModel>(
                future: _future,
                builder: (context, snapchot) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            DropdownButton<String>(
                              items: [
                                DropdownMenuItem(
                                  value: "all",
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      //Icon(Icons.build, size: 16,),
                                      SizedBox(width: 10),
                                      Text(
                                        "Toutes les installations",
                                      ),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "PENDING",
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      //Icon(Icons.build, size: 16,),
                                      SizedBox(width: 10),
                                      Text(
                                        "En attente",
                                      ),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "CHECKLIST",
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      //Icon(Icons.settings, size: 16,),
                                      SizedBox(width: 10),
                                      Text(
                                        "En cours",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _value = value;
                                  getInstallations(value, companyId);
                                });
                              },
                              value: _value,
                              isExpanded: true,
                              //value: 0,
                              elevation: 2,
                              style: regularLightTextStyle(
                                  AppColors.PRIMARY_COLOR),
                              isDense: true,
                              iconSize: 40.0,
                            ),
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: items.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 4.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'N° ${items[index].id}',
                                            style: mediumLightTextStyle(
                                                AppColors.PRIMARY_COLOR),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Le ${items[index].application.offer.commissioningDate}',
                                                style: mediumLightTextStyle(
                                                    AppColors.PRIMARY_COLOR),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              dayDifference(items[index]
                                                          .application
                                                          .offer
                                                          .commissioningDate) >
                                                      0
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          8))),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2,
                                                              horizontal: 4),
                                                      child: Text(
                                                        'Dans ${dayDifference(items[index].application.offer.commissioningDate)}  jours',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    )
                                                  : Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          8))),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2,
                                                              horizontal: 4),
                                                      child: Text(
                                                        'Aujourd\'hui',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            'Kit ${items[index].application.offer.kit.name} rémunéré ${formatCurrency(int.parse(items[index].application.offer.flatRate))}Fcfa / bonus ${items[index].application.offer.kit.category.coefficient} points',
                                            style: mediumLightTextStyle(
                                                AppColors.PRIMARY_COLOR),
                                          ),
                                          Text(
                                            '${items[index].application.offer.customerName}',
                                            style: mediumLightTextStyle(
                                                AppColors.PRIMARY_COLOR),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          InstallationTimeLine(
                                              item: items[index]),
                                          items[index].status == 'PENDING'
                                              ? Center(
                                                  child: Text(
                                                    'Préparation non terminé',
                                                    style: smallBoldTextStyle(
                                                        Colors.red),
                                                  ),
                                                )
                                              : items[index].status ==
                                                      'FINISHED'
                                                  ? Center(
                                                      child: Text(
                                                        'Installation terminée',
                                                        style:
                                                            smallBoldTextStyle(
                                                                Colors.green),
                                                      ),
                                                    )
                                                  : items[index].status ==
                                                          'CHECKLIST'
                                                      ? Center(
                                                          child: Text(
                                                            'Préparation terminée',
                                                            style:
                                                                smallBoldTextStyle(
                                                                    Colors
                                                                        .green),
                                                          ),
                                                        )
                                                      : SizedBox(),
                                          items[index].status == 'PENDING'
                                              ? Center(
                                                  child: RaisedButton.icon(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                              side: BorderSide(
                                                                  color: Colors
                                                                      .orange)),
                                                      color: Colors.white,
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .push(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            TechnicalSheetScreen(
                                                                              installationId: items[index].id,
                                                                            )))
                                                            .then((value) {
                                                          if (value != null &&
                                                              value) {
                                                            getInstallations(_value, companyId);
                                                          }
                                                        });
                                                      },
                                                      icon: Icon(Icons.warning,
                                                          color: Colors.orange),
                                                      label: Text(
                                                        ' Finir la préparation',
                                                        style:
                                                            smallBoldTextStyle(
                                                                Colors.orange),
                                                      )),
                                                )
                                              : items[index].status ==
                                                      'FINISHED'
                                                  ? SizedBox()
                                                  : Center(
                                                      child: RaisedButton.icon(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                              side: BorderSide(
                                                                  color: Colors
                                                                      .green)),
                                                          color: Colors.white,
                                                          onPressed: () async {
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            InstallationTimeline(
                                                                              installation: items[index],
                                                                            )))
                                                                .then((value) {
                                                              getInstallations(_value, companyId);
                                                            });
                                                          },
                                                          icon: Icon(
                                                              Icons
                                                                  .play_circle_filled,
                                                              color:
                                                                  Colors.green),
                                                          label: Text(
                                                            items[index].status ==
                                                                    'CHECKLIST'
                                                                ? "Démarrer l'installation"
                                                                : "Continuer l'installation",
                                                            style:
                                                                smallBoldTextStyle(
                                                                    Colors
                                                                        .green),
                                                          )),
                                                    ),
                                          Row()
                                        ],
                                      ),
                                    ),
                                  );
                                })
                          ],
                        ),
                      ));
                }));
  }
}
