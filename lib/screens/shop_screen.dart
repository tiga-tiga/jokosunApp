import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/widgets/app_drawer.dart';

class ShopScreen extends StatelessWidget {
  static const routeName = '/shopScreen';
  var items = List<String>();

  @override
  Widget build(BuildContext context) {
    items = ['test1', 'test 2'];
    return Scaffold(
      appBar: mainAppBar('Boutique'),
      drawer: Appdrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                '450 points',
                style: regularBoldTextStyle(AppColors.ACCENT_COLOR),
              ),
              decoration: BoxDecoration(
                  color: AppColors.PRIMARY_COLOR,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
            SizedBox(height: 8,),
            Expanded(
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: items[index] == 'test1'
                          ? TrainingCard(item: items[index])
                          : null,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class TrainingCard extends StatelessWidget {
  const TrainingCard({
    Key key,
    @required this.item,
  }) : super(key: key);

  final String item;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(
              'Formation CES',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: AppColors.PRIMARY_COLOR),
              textAlign: TextAlign.center,
            ),
            RatingBarIndicator(
              rating: 5,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 16.0,
              unratedColor: Colors.amber.withAlpha(50),
              direction: Axis.horizontal,
            ),
            Text(
              'La formation CES vous perrmettra de lorem ipsum lorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsum mlorem ipsum   mlorem ipsum  mlorem ipsum  mlorem ipsum  ',
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: AppColors.PRIMARY_COLOR),
              textAlign: TextAlign.start,
              softWrap: true,
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Prochaine session: ',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Le 23 Novembre 2020 ',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: AppColors.PRIMARY_COLOR),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Formateur: ',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Mr Mamadou Ba',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: AppColors.PRIMARY_COLOR),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Durée: ',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(
                  '5 jours',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: AppColors.PRIMARY_COLOR),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Certification: ',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Oui',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: AppColors.PRIMARY_COLOR),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Prix: ',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(
                  '20 000 Fcfa',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: AppColors.PRIMARY_COLOR),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Programme complet',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                        color: AppColors.PRIMARY_COLOR)),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            RaisedButton(
              onPressed: () async {},
              shape: buttonMainShape(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Column(
                  children: [
                    Text(item == 'test1' ? 'Reserver' : "Liste d'attente",
                        style: mediumLightTextStyle(AppColors.PRIMARY_COLOR)),
                    item == 'test1'
                        ? Text("(3 places restantes)",
                            style:
                                mediumLightTextStyle(AppColors.PRIMARY_COLOR))
                        : SizedBox(),
                  ],
                ),
              ),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
