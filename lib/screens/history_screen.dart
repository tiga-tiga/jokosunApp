import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';

class HistoryScreen extends StatelessWidget {
  static const routeName = '/historyScreen';
  var items = List<String>();

  @override
  Widget build(BuildContext context) {
    items = ['test1', 'test 2'];
    return Scaffold(
        appBar: mainAppBar('Historique des installations'),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Card(
                      elevation: 4.0,
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'N°11',
                                    style: regularLightTextStyle(AppColors.PRIMARY_COLOR),
                                  ),
                                  Text(
                                    '28/10/2020',
                                    style: mediumLightTextStyle(AppColors.PRIMARY_COLOR),
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
                                    'Mr Ndiaye (Dakar) | Kit 2',
                                    style: mediumLightTextStyle(AppColors.PRIMARY_COLOR),
                                  ),

                                ],
                              ),
                              SizedBox(height: 8,),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '100.000 Fcfa: ',
                                    style: mediumBoldTextStyle(AppColors.ACCENT_COLOR),
                                  ),
                                  Text(
                                    items[index]== 'test1' ? 'Reçu le 30/10/2020': 'En attente de la facture',
                                    style: mediumLightTextStyle(AppColors.PRIMARY_COLOR),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8,),
                               Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Text(
                                        '4.1',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: AppColors.PRIMARY_COLOR,
                                            fontSize: 12),
                                      ),
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
                                        unratedColor: Colors.amber.withAlpha(50),
                                        direction: Axis.horizontal,
                                      ),
                                    ],
                                  ),

                                  items[index]== 'test1' ?  Text(
                                    'Voir la facture',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: AppColors.PRIMARY_COLOR),
                                  ):  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        'Envoyer la facture',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.red),
                                      ),
                                      Icon(Icons.warning, color: Colors.red, size: 16,)
                                    ],
                                  ),
                                ],
                              )
                            ],
                          )),
                    ),
                  );
                })));
  }
}
