import 'package:flutter/material.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/models/company_model.dart';
import 'package:jokosun/screens/edit_company_screen.dart';
import 'package:jokosun/screens/my_team_screen.dart';
import 'package:jokosun/screens/profile/bank_details.dart';
import 'package:jokosun/screens/profile/my_contracts.dart';

class MyCompanyScreen extends StatelessWidget {
  static const routeName = '/myCompany';
  final Company company;

  const MyCompanyScreen({this.company});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: mainAppBar('Mon entreprise'),
        backgroundColor: Color.fromRGBO(255, 255, 255, .9),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16),
                        height: 100,
                        width: 100,
                        child: new CircleAvatar(
                          radius: 30.0,
                          backgroundColor: const Color(0xFF778899),
                          backgroundImage: NetworkImage(''),
                        ),
                      ),
                      Text(
                        company.name,
                        style: regularBoldTextStyle(AppColors.PRIMARY_COLOR),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(EditCompany.routeName);
                    },
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 16, right: 8),
                          child: Icon(
                            Icons.edit,
                            size: 16,
                            color: AppColors.PRIMARY_COLOR,
                          ),
                        ),
                        Text(
                          "Editer",
                          style: regularLightTextStyle(AppColors.PRIMARY_COLOR),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                  ),
                  CompanyInfo(
                    company: company,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        child: Container(
                      child: ListTile(
                        leading: Icon(Icons.people, color: AppColors.PRIMARY_COLOR,),
                        title: Text(
                          "Mon équipe",
                          style: regularLightTextStyle(AppColors.PRIMARY_COLOR),
                        ),
                        trailing: Container(
                          height: double.infinity,
                          child: Icon(
                            Icons.chevron_right,
                            color: Colors.black54,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(MyTeam.routeName);
                        },
                      ),
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

  const CompanyInfo({this.company});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Card(
            child: Container(
                child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.my_location, color: AppColors.PRIMARY_COLOR,),
                  title: Text("Adresse",

                    style:smallLightTextStyle(AppColors.PRIMARY_COLOR),),
                  subtitle: Text(company.address,
                    style:regularLightTextStyle(AppColors.PRIMARY_COLOR),),
                ),
                ListTile(
                  leading: Icon(Icons.phone, color: AppColors.PRIMARY_COLOR,),
                  title: Text("Téléphone",
                    style:smallLightTextStyle(AppColors.PRIMARY_COLOR),),
                  subtitle: Text(company.phone,
                    style:regularLightTextStyle(AppColors.PRIMARY_COLOR),),
                ),
                ListTile(
                  leading: Icon(Icons.perm_device_information, color: AppColors.PRIMARY_COLOR,),
                  title: Text("NINEA",style:smallLightTextStyle(AppColors.PRIMARY_COLOR) ),
                  subtitle: Text(company.ninea,
                      style:regularLightTextStyle(AppColors.PRIMARY_COLOR),),
                ),
                ListTile(
                  leading: Icon(Icons.mail, color: AppColors.PRIMARY_COLOR,),
                  title: Text("Email", style: smallLightTextStyle(AppColors.PRIMARY_COLOR)),
                  subtitle: Text(company.email, style:regularLightTextStyle(AppColors.PRIMARY_COLOR)),
                ),
                ListTile(
                  leading: Icon(Icons.description, color: AppColors.PRIMARY_COLOR,),
                  title: Text("Mes contrats", style: regularLightTextStyle(AppColors.PRIMARY_COLOR)),
                  trailing: Container(
                    height: double.infinity,
                    child: Icon(
                      Icons.chevron_right,
                      color: Colors.black54,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(MyContracts.routeName);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.comment_bank, color: AppColors.PRIMARY_COLOR,),
                  title: Text("Coordonées bancaires", style: regularLightTextStyle(AppColors.PRIMARY_COLOR)),
                  subtitle: Text(""),
                  trailing: Container(
                    height: double.infinity,
                    child: Icon(
                      Icons.chevron_right,
                      color: Colors.black54,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(BankDetails.routeName);
                  },
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
