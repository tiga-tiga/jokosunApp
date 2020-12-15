import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jokosun/constants/app_api.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/models/applications_model.dart';
import 'package:jokosun/models/offers_model.dart';
import 'package:jokosun/models/response_model.dart';
import 'package:jokosun/network/admin_api.dart';
import 'package:jokosun/screens/admin/admin_update_offer.dart';
import 'package:jokosun/utils/app_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminOfferDetail extends StatefulWidget {
  static const routeName = '/adminOfferDetail';
  final Offer offer;

  const AdminOfferDetail({Key key, this.offer}) : super(key: key);

  @override
  _AdminOfferDetailState createState() => _AdminOfferDetailState();
}

Future<Applications> _future;

class _AdminOfferDetailState extends State<AdminOfferDetail> {
  List<Application> applicationItem = [];
  bool loading = false;

  List<DropdownChoices> dropdownChoices = [
    DropdownChoices(title: 'Modifier', icon: Icons.edit),
    DropdownChoices(title: 'Supprimer', icon: Icons.delete)
  ];

  Future<Applications> getOffers() async {
    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    print(token);
    final response = await http.get(
      "$baseUrl/offers/${widget.offer.id}/applications",
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      ResponseModel responseModel = responseModelFromJson(response.body);

      applicationItem = Applications.fromJson(responseModel.data).applications;
      print('offers ${response.body}');
      setState(() {
        loading = false;
      });

      return Applications.fromJson(responseModel.data);
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
    _future = getOffers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BuildContext buildContext  = context;
    return loading
        ? Scaffold(body: loadingLayout())
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text( widget.offer.installationId ==null?
                'Postulants': 'Installateur séléctioné',
                style: regularLightTextStyle(AppColors.ACCENT_COLOR),
              ),
              backgroundColor: AppColors.PRIMARY_COLOR,
              iconTheme: IconThemeData(color: AppColors.ACCENT_COLOR),
              actions: [
                PopupMenuButton<DropdownChoices>(
                  onSelected: null,
                  elevation: 6,
                  icon: Icon(
                    Icons.more_vert,
                    size: 28,
                    color: AppColors.ACCENT_COLOR,
                  ),
                  itemBuilder: (BuildContext context) {
                    return dropdownChoices.map((DropdownChoices choice) {
                      return PopupMenuItem<DropdownChoices>(
                        value: choice,
                        child: GestureDetector(
                          onTap:  choice.title == 'Modifier'
                              ? ()  async {
                            if(widget.offer.applications > 0) {
                              AppDialogs().showMainErrorDialog(context, 'Vous ne pouvez supprimer cette offre');
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminUpdateOffer(widget.offer)));
                            }
                          }: ()  async {
                            await AppDialogs()
                                .showConfirmationDialog(buildContext,
                                'Voulez vous supprimer cette  offre?')
                                .then((value) {
                              if (value) {
                                setState(() {
                                  loading = true;
                                });
                                ResponseModel responseModel;
                                AdminApi()
                                    .deleteOffer(widget.offer.id)
                                    .then((value) {
                                  responseModel = value;
                                  AppDialogs().showResponseDialog(
                                      buildContext,
                                      responseModel.message,
                                      responseModel.success);
                                  print(responseModel.data);
                                  setState(() {
                                    loading = false;
                                  });
                                });
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Icon(
                                choice.title == 'Modifier'
                                    ? Icons.edit
                                    : Icons.delete,
                                size: 24,
                                color: choice.title == 'Modifier'
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                choice.title,
                                style:
                                    mediumLightTextStyle(AppColors.PRIMARY_COLOR),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
            body: FutureBuilder<Applications>(
                future: _future,
                builder: (context, snapchot) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: applicationItem.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child: GestureDetector(
                                  onTap: widget.offer.installationId ==null ? ()  async {
                                    await AppDialogs()
                                        .showConfirmationDialog(buildContext,
                                            'Voulez vous séléctionner ${applicationItem[index].company.name} pour cette installation?')
                                        .then((value) {
                                      if (value) {
                                        setState(() {
                                          loading = true;
                                        });
                                        ResponseModel responseModel;
                                        AdminApi()
                                            .validSubmission(widget.offer.id,
                                            applicationItem[index].id)
                                            .then((value) {
                                          responseModel = value;
                                          AppDialogs().showResponseDialog(
                                              buildContext,
                                              responseModel.message,
                                              responseModel.success);
                                          print(responseModel.data);
                                          setState(() {
                                            loading = false;
                                          });
                                        });
                                      }
                                    });



                                  }: null,
                                  child: Card(
                                    elevation: 4.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            '${applicationItem[index].company.name} ',
                                            style: regularLightTextStyle(
                                                AppColors.PRIMARY_COLOR),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${applicationItem[index].technicians.length} techniciens: ',
                                                style: mediumLightTextStyle(
                                                    AppColors.PRIMARY_COLOR),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  applicationItem[index]
                                                      .technicians
                                                      .map((e) => e.name)
                                                      .toList()
                                                      .join(', '),
                                                  style: mediumLightTextStyle(
                                                      AppColors.PRIMARY_COLOR),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                        widget.offer.installationId != null? GestureDetector(
                          onTap: () async {
                            await AppDialogs()
                                .showConfirmationDialog(buildContext,
                                'Voulez vous annuler l\'installation?')
                                .then((value) {
                              if (value) {
                                setState(() {
                                  loading = true;
                                });
                                ResponseModel responseModel;
                                AdminApi()
                                    .deleteInstallation(widget.offer.installationId)
                                    .then((value) {
                                  responseModel = value;
                                  AppDialogs().showResponseDialog(
                                      buildContext,
                                      responseModel.message,
                                      responseModel.success);
                                  print(responseModel.data);
                                  setState(() {
                                    loading = false;
                                  });
                                });
                              }
                            });
                          },
                          child: Text(
                          'Annuler l\'installation',
                            style: regularLightTextStyle(Colors.red),
                          ),
                        ): SizedBox(),
                      ],
                    ),
                  );
                }));
  }
}

class DropdownChoices {
  const DropdownChoices({this.title, this.icon});

  final String title;
  final IconData icon;
}
