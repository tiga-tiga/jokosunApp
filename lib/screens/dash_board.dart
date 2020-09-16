import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/widgets/app_drawer.dart';

class DashBoard extends StatelessWidget {
  static const routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: mainAppBar('DashBoard'),
        drawer: Appdrawer(),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                height: 300,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  color: AppColors.PRIMARY_COLOR_LIGHT,
                ),
                width: double.infinity,
              ),
              Container(
                margin: EdgeInsets.only(left: 90, bottom: 20),
                width: 299,
                height: 279,
                decoration: BoxDecoration(
                    color: AppColors.ACCENT_COLOR,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(160),
                        bottomLeft: Radius.circular(290),
                        bottomRight: Radius.circular(160),
                        topRight: Radius.circular(10))),
              ),
              CustomScrollView(
                slivers: <Widget>[

                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverGrid.count(
                      childAspectRatio: 2,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: <Widget>[
                        caCards('CA 2020', '300000'),
                        caCards('CA Juillet', '43000'),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverGrid.count(
                      childAspectRatio: 3,
                      crossAxisCount: 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: <Widget>[
                        caCards('Bonus prévisionnel', '300000'),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverGrid.count(
                      childAspectRatio: 2,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: <Widget>[
                        installationCards('Installation 2020', '10'),
                        installationCards('Installation Juillet', '5'),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverGrid.count(
                      childAspectRatio: 2,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: <Widget>[
                        rateCards('Note globale 2020', 3.6),
                        rateCards('Note globale Juillet', 5.0),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

Widget caCards(title, price) {
  return Container(
    height: 100,
    width: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 6.0,
        ),
      ],
      color: Colors.white,
    ),
    child: Padding(
      padding:EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                color: AppColors.PRIMARY_COLOR,
              ),

              child: Text(price + ' Fcfa',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12))),
          SizedBox(height: 8,),
          Text('Verserment le 18/08/2020',
              style: TextStyle(fontSize: 12)),
        ],
      ),
    ),
  );
}
Widget installationCards(title, number) {
  return Container(
    height: 100,
    width: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 6.0,
        ),
      ],
      color: Colors.white,
    ),
    child: Padding(
      padding:EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Container(
            width: 60,
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                color: AppColors.ACCENT_COLOR,
              ),

              child: Center(
                child: Text(number,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              )),
        ],
      ),
    ),
  );
}
Widget rateCards(title, rate) {
  return Container(
    height: 100,
    width: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 6.0,
        ),
      ],
      color: Colors.white,
    ),
    child: Padding(
      padding:EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RatingBarIndicator(
                rating: rate,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 16.0,
                unratedColor: Colors.amber.withAlpha(50),
                direction: Axis.horizontal,
              ),
              Text(rate.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),

        ],
      ),
    ),
  );
}
