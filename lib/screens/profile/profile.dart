import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/models/company_model.dart';
import 'package:jokosun/models/user_model.dart';
import 'package:jokosun/providers/user.dart';
import 'package:jokosun/screens/my_company_screen.dart';
import 'package:jokosun/screens/profile/my_kits_screen.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';

class Profile extends StatelessWidget {
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).user;
    return Scaffold(
        appBar: mainAppBar('Profil'),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {

                          },
                          child: Text('Déconnéxion',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.red,
                                  decoration: TextDecoration.underline,
                                  fontSize: 14)),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 16),
                      padding: EdgeInsets.all(8),
                      child: CircleAvatar(
                        radius: 40.0,
                        backgroundImage:
                            NetworkImage(userModel.profilePhotoUrl),
                        backgroundColor: Colors.transparent,
                      )),
                  Text(
                    userModel.name,
                    style: regularLightTextStyle(AppColors.PRIMARY_COLOR),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                  ),
                  Text(
                    userModel.role.id == 2 ? "Manager" : 'Technicien',
                    style: smallBoldTextStyle(AppColors.ACCENT_COLOR),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Card(
                      elevation: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(top: 15, bottom: 5),
                                  child: Text("Note",
                                      style: TextStyle(color: Colors.black54))),
                              Container(
                                padding: EdgeInsets.only(bottom: 15),
                                child: RatingBarIndicator(
                                  rating: 3,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 16.0,
                                  unratedColor: Colors.amber.withAlpha(50),
                                  direction: Axis.horizontal,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(top: 15, bottom: 5),
                                  child: Text("Télephone",
                                      style: TextStyle(color: Colors.black54))),
                              Container(
                                  padding: EdgeInsets.only(bottom: 15),
                                  child: Text(userModel.phone,
                                      style: regularLightTextStyle(AppColors.PRIMARY_COLOR))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  CompanyInfo(
                    company: userModel.company,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                        elevation: 2,
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed(MyKits.routeName);
                          },
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Mes Kits',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.PRIMARY_COLOR,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        )),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class CompanyInfo extends StatelessWidget {
  final Company company;

  const CompanyInfo({Key key, this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
          elevation: 2,
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MyCompanyScreen(company: company)));
            },
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Mon Entreprise',
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: AppColors.PRIMARY_COLOR,
                      fontSize: 16),
                ),
                Text(company.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.ACCENT_COLOR)),
              ],
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
          )),
    );
  }
}
