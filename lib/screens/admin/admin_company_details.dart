import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/models/installations_model.dart';
import 'package:jokosun/models/response_model.dart';
import 'package:jokosun/providers/user.dart';
import 'package:jokosun/screens/admin/admin_installation_invoices.dart';
import 'package:jokosun/screens/installation/installation_timeline.dart';
import 'package:jokosun/screens/technical_sheet_screen.dart';
import 'package:jokosun/utils/app_format.dart';
import 'package:jokosun/widgets/installation_timaline.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin_installation_detail_screen.dart';

class AdminCompanyDetails extends StatefulWidget {
  final companyId;

  const AdminCompanyDetails({this.companyId});

  @override
  _AdminCompanyDetailsState createState() => _AdminCompanyDetailsState();
}

Future<ResponseModel> _future;

class _AdminCompanyDetailsState extends State<AdminCompanyDetails> {
  var items = List<Installation>();
  bool loading = false;
  var _value = "all";

  Future<ResponseModel> getInstallations(String status) async {
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
          'jokosun.dohappit.com', '/api/installations/${widget.companyId}', queryParameters);
    } else {
      uri = Uri.https('jokosun.dohappit.com', '/api/installations/${widget.companyId}');
    }
    print(widget.companyId);

    final response = await http.get(
      uri,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    ResponseModel responseModel = responseModelFromJson(response.body);
    print(responseModel.data);

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
    _future = getInstallations(null,);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(body: loadingLayout())
        : Scaffold(
        appBar: mainAppBar('Installations'),
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
                              getInstallations(value);
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
                                         Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[

                                            items[index].invoice_status != null ? GestureDetector(
                                              child: Text(
                                                items[index].invoice_status == 'PENDING' ? 'Facture envoyée':
                                                !items[index].invoiceable && items[index].invoice_status == 'APPROVED' ? 'Facture validé': 'Facture rejetée',
                                                style: TextStyle(
                                                    decoration: TextDecoration.underline,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w300,
                                                    color:
                                                    items[index].invoice_status ==  'PENDING' ? Colors.red:
                                                    !items[index].invoiceable && items[index].invoice_status == 'APPROVED' ?  Colors.green :Colors.red),
                                              ),
                                              onTap: () {
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminInstallationInvoices(installationId: items[index].id)));
                                              },
                                            ): Text('Facture non envoyée', style: TextStyle(
                                                decoration: TextDecoration.underline,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300,
                                                color:Colors.red)),
                                          ],
                                        )

                                      ],
                                    ),
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
