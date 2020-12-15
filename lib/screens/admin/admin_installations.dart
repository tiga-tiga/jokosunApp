import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jokosun/constants/app_api.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/models/installations_model.dart';
import 'package:jokosun/models/response_model.dart';
import 'package:jokosun/screens/admin/admin_installation_detail_screen.dart';
import 'package:jokosun/utils/app_format.dart';
import 'package:jokosun/widgets/installation_timaline.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_tile/timeline_tile.dart';

class AdminInstallations extends StatefulWidget {
  static const routeName = '/adminInstallations';

  @override
  _AdminInstallationsState createState() => _AdminInstallationsState();
}

Future<Installations> _future;

class _AdminInstallationsState extends State<AdminInstallations> {
  List<Installation> items = [];
  bool loading = false;

  Future<Installations> getInstallations() async {
    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    print(token);
    final response = await http.get(
      "$baseUrl/installations",
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      ResponseModel responseModel = responseModelFromJson(response.body);

      items =
          Installations.fromJson(responseModel.data).installations;
      items.sort((a,b) {
        DateTime aDateTime = DateFormat("dd/MM/yy hh:mm").parse(a.application.offer.commissioningDate);
        DateTime bDateTime = DateFormat("dd/MM/yy hh:mm").parse(b.application.offer.commissioningDate);
        return aDateTime.compareTo(bDateTime);
      });
      print('offers ${response.body}');
      setState(() {
        loading = false;
      });

      return Installations.fromJson(responseModel.data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      setState(() {
        loading = false;
      });
      throw Exception('Failed to load projects');
    }
  }

  @override
  void initState() {
    _future = getInstallations();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(body: loadingLayout())
        : Scaffold(
            appBar: mainAppBar('Mes installations'),
            body: FutureBuilder<Installations>(
                future: _future,
                builder: (context, snapchot) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {

                          print(items[index].status);
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: GestureDetector(
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
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                    color: AppColors.PRIMARY_COLOR,
                                    width: 1.0,
                                  ),
                                ),
                                elevation: 4.0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor: items[index]
                                                    .application
                                                    .offer
                                                    .kit
                                                    .category
                                                    .id ==
                                                1
                                            ? Colors.red
                                            : Colors.green,
                                        radius: 12,
                                        child: Padding(
                                            padding: EdgeInsets.all(2),
                                            child: Icon(
                                              items[index]
                                                          .application
                                                          .offer
                                                          .kit
                                                          .category
                                                          .id ==
                                                      1
                                                  ? Icons.lightbulb_outline
                                                  : Icons.tv,
                                              color: Colors.white,
                                              size: 16,
                                            )),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Le ${items[index].application.offer.commissioningDate} ',
                                        style: mediumLightTextStyle(
                                            AppColors.PRIMARY_COLOR),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Kit ${items[index].application.offer.kit.name}',
                                        style: mediumLightTextStyle(
                                            AppColors.PRIMARY_COLOR),
                                      ),
                                      Text(
                                        'Categorie: ${items[index].application.offer.kit.category.id} ',
                                        style: mediumLightTextStyle(
                                            AppColors.PRIMARY_COLOR),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Ville: ${items[index].application.offer.city} ',
                                        style: mediumLightTextStyle(
                                            AppColors.PRIMARY_COLOR),
                                      ),
                                      Text(
                                        'Client: ${items[index].application.offer.customerName}',
                                        style: mediumLightTextStyle(
                                            AppColors.PRIMARY_COLOR),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Rémunération: ${formatCurrency(int.parse(items[index].application.offer.flatRate))} Fcfa / ${items[index].application.offer.kit.category.coefficient} points',
                                        style: mediumLightTextStyle(
                                            AppColors.PRIMARY_COLOR),
                                      ),
                                      Text(
                                        'Equipe nécessaire: ${items[index].application.offer.technicians} personne${items[index].application.offer.technicians > 1 ? 's' : ''}',
                                        style: mediumLightTextStyle(
                                            AppColors.PRIMARY_COLOR),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      InstallationTimeLine(item: items[index])
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                }));
  }
}

