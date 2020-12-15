import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:jokosun/constants/app_api.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/models/offers_model.dart';
import 'package:jokosun/models/response_model.dart';
import 'package:jokosun/screens/apply_screen.dart';
import 'package:jokosun/utils/app_format.dart';
import 'package:jokosun/widgets/app_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'client_suggest.dart';

class SearchInstall extends StatefulWidget {
  static const routeName = '/searchInstall';

  @override
  _SearchInstallState createState() => _SearchInstallState();
}

Future<Offers> _future;

class _SearchInstallState extends State<SearchInstall> {
  List<Offer> offerItems = [];
  bool loading = false;

  Future<Offers> getOffers() async {
    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    print(token);
    final response = await http.get(
      "$baseUrl/offers",
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      ResponseModel responseModel = responseModelFromJson(response.body);

      offerItems = Offers.fromJson(responseModel.data).offers;
      print('offers ${response.body}');
      setState(() {
        loading = false;
      });

      return Offers.fromJson(responseModel.data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      setState(() {
        loading = false;
      });
      throw Exception('Failed to load projects');
    }
  }
  ScrollController _hideButtonController;
  var _isVisible;

  @override
  void initState() {
    _future = getOffers();
    super.initState();
    _isVisible = true;
    _hideButtonController = new ScrollController();
    _hideButtonController.addListener((){
      if(_hideButtonController.position.userScrollDirection == ScrollDirection.reverse){
        if(_isVisible == true) {
          /* only set when the previous state is false
             * Less widget rebuilds
             */
          print("**** ${_isVisible} up"); //Move IO away from setState
          setState((){
            _isVisible = false;
          });
        }
      } else {
        if(_hideButtonController.position.userScrollDirection == ScrollDirection.forward){
          if(_isVisible == false) {
            /* only set when the previous state is false
               * Less widget rebuilds
               */
            print("**** ${_isVisible} down"); //Move IO away from setState
            setState((){
              _isVisible = true;
            });
          }
        }
      }});
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(body: loadingLayout())
        : Scaffold(
            appBar: mainAppBar('Rechercher une installation'),
            floatingActionButton: Visibility(
              visible: _isVisible,
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(ClientSuggest.routeName);
                },
                icon: Icon(
                  Icons.add,
                  color: AppColors.ACCENT_COLOR,
                ),
                backgroundColor: AppColors.PRIMARY_COLOR,
                label: Text(
                  "Proposer un client",
                  style: regularLightTextStyle(AppColors.ACCENT_COLOR),
                ),
              ),
            ),
            body: FutureBuilder<Offers>(
                future: _future,
                builder: (context, snapchot) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      controller: _hideButtonController,
                        itemCount: offerItems.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: Card(
                              elevation: 4.0,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: offerItems[index].kit.category.id== 1 ? Colors.red: Colors.green,
                                          radius: 12,
                                          child: Padding(
                                              padding: EdgeInsets.all(2),
                                              child: Icon(
                                                offerItems[index].kit.category.id== 1 ? Icons.lightbulb_outline: Icons.tv,
                                                color: Colors.white,
                                                size: 16,
                                              )),
                                        ),


                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Le ${offerItems[index].commissioningDate} ',
                                      style: mediumLightTextStyle(
                                          AppColors.PRIMARY_COLOR),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Kit ${offerItems[index].kit.id} remunéré ${formatCurrency(int.parse(offerItems[index].flatRate))} Fcfa / ${offerItems[index].kit.category.coefficient} points',
                                      style: mediumLightTextStyle(
                                          AppColors.PRIMARY_COLOR),
                                    ),
                                    Text(
                                      '${offerItems[index].city}',
                                      style: mediumLightTextStyle(
                                          AppColors.PRIMARY_COLOR),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Equipe nécessaire: ${offerItems[index].technicians} personne${offerItems[index].technicians > 1 ? 's':''}',
                                      style: mediumLightTextStyle(
                                          AppColors.PRIMARY_COLOR),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    !offerItems[index].applied ? Center(
                                      child: RaisedButton.icon(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color:
                                                      AppColors.PRIMARY_COLOR)),
                                          color: Colors.white,
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushNamed(ApplyScreen.routeName, arguments: offerItems[index]).then((value) {
                                                  getOffers();
                                            });
                                          },
                                          icon: Icon(Icons.label,
                                              color: AppColors.PRIMARY_COLOR),
                                          label: Text(
                                            'Postuler à cette installation',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.PRIMARY_COLOR),
                                          )),
                                    ): Center(
                                      child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text(
                                        'Déjà postulé',
                                        style: mediumBoldTextStyle(
                                              Colors.green),
                                      ),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                }));
  }
}
