import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/models/installations_model.dart';
import 'package:jokosun/models/response_model.dart';
import 'package:jokosun/providers/user.dart';
import 'package:jokosun/screens/add_invoce.dart';
import 'package:jokosun/utils/app_format.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin/admin_installation_detail_screen.dart';

class HistoryScreen extends StatefulWidget {
  static const routeName = '/historyScreen';

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

Future<ResponseModel> _future;

class _HistoryScreenState extends State<HistoryScreen> {
  var items = List<Installation>();
  bool loading = false;
  int companyId;
  var _value = "all";

  Future<ResponseModel> getInstallations(int companyId) async {
    // items.clear();
    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    print(token);

    var queryParameters = {
      'status': 'FINISHED',
    };
    var uri = Uri.https(
        'jokosun.dohappit.com', '/api/installations/$companyId', queryParameters);

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
    _future = getInstallations(companyId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(body: loadingLayout())
        : Scaffold(
            appBar: mainAppBar('Historique des installations'),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: FutureBuilder<ResponseModel>(
                    future: _future,
                    builder: (context, snapchot) {
                      return Column(
                        children: [
                          ListView.builder(
                              itemCount: items.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    if(items[index].status == 'FINISHED'){
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) =>
                                              InstallationDetail(
                                                  installation: items[index]
                                              )));
                                    }

                                  },
                                  child: Card(
                                    elevation: 4.0,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  'N° ${items[index].id}',
                                                  style: regularLightTextStyle(
                                                      AppColors.PRIMARY_COLOR),
                                                ),
                                                Text(
                                                  '${items[index].application.offer.commissioningDate}',
                                                  style: mediumLightTextStyle(
                                                      AppColors.PRIMARY_COLOR),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  '${items[index].application.offer.customerName} | Kit ${items[index].application.offer.kit.name}',
                                                  style: mediumLightTextStyle(
                                                      AppColors.PRIMARY_COLOR),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  '${formatCurrency(int.parse(items[index].application.offer.flatRate))}Fcfa',
                                                  style: mediumBoldTextStyle(
                                                      AppColors.ACCENT_COLOR),
                                                ),

                                              ],
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Row(
                                                  children: [
                                                    Text(
                                                      '4.1',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: AppColors
                                                              .PRIMARY_COLOR,
                                                          fontSize: 12),
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    RatingBarIndicator(
                                                      rating: 4.1,
                                                      itemBuilder:
                                                          (context, index) =>
                                                              Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      itemCount: 5,
                                                      itemSize: 16.0,
                                                      unratedColor: Colors.amber
                                                          .withAlpha(50),
                                                      direction: Axis.horizontal,
                                                    ),
                                                  ],
                                                ),
                                                items[index].invoice_status == 'APPROVED'? Text(
                                                  'Facture validé',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight
                                                          .w300,
                                                      color:
                                                      Colors.green),
                                                ): items[index].invoice_status == 'PENDING' ?
                                                Text(
                                                  'Validation en cours',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight
                                                          .w300,
                                                      color:
                                                      Colors.grey)):
                                                GestureDetector(
                                                  child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment.end,
                                                          children: <Widget>[
                                                            Text(
                                                              'Envoyer la facture',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color:
                                                                      Colors.red),
                                                            ),
                                                            Icon(
                                                              Icons.warning,
                                                              color: Colors.red,
                                                              size: 16,
                                                            )
                                                          ],
                                                        ),
                                                  onTap: () {
                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddInvoice(installationId: items[index].id)));

                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        )),
                                  ),
                                );
                              }),
                        ],
                      );
                    }),
              ),
            ),
          );
  }
}
