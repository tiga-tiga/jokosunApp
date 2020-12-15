import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/providers/user.dart';
import 'package:jokosun/screens/dash_board.dart';
import 'package:jokosun/utils/app_dialogs.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  static final String path = "lib/src/pages/login/auth3.dart";

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text feild state
  String email = '';
  String password = '';
  String error = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColors.PRIMARY_COLOR,
                valueColor:
                    new AlwaysStoppedAnimation<Color>(AppColors.ACCENT_COLOR),
              ),
            ),
          )
        : Scaffold(
            body: Container(
              color: AppColors.PRIMARY_COLOR,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
                  // Container(padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 48),child: Image(image: AssetImage('assets/img/wbtech.png'))),
                  SizedBox(
                    height: 20.0,
                  ),

                  _buildLoginForm(),
                ],
              ),
            ),
          );
  }

  Container _buildLoginForm() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: RoundedDiagonalPathClipper(),
            child: Container(
              height: 400,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                color: Colors.white,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 90.0,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          initialValue: email,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                          validator: (val) =>
                              val.isEmpty ? 'Enter an email' : null,
                          style: TextStyle(color: AppColors.ACCENT_COLOR),
                          decoration: InputDecoration(
                              hintText: "Adresse email",
                              hintStyle:
                                  TextStyle(color: AppColors.ACCENT_COLOR),
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.email,
                                color: AppColors.ACCENT_COLOR,
                              )),
                        )),
                    Container(
                      child: Divider(
                        color: AppColors.ACCENT_COLOR,
                      ),
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 10.0),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          initialValue: password,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          validator: (val) =>
                              val.isEmpty ? 'Mot de passe nécessaire' : null,
                          style: TextStyle(color: AppColors.ACCENT_COLOR),
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "Mot de passe",
                              hintStyle:
                                  TextStyle(color: AppColors.ACCENT_COLOR),
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.lock,
                                color: AppColors.ACCENT_COLOR,
                              )),
                        )),
                    Container(
                      child: Divider(
                        color: AppColors.ACCENT_COLOR,
                      ),
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 10.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(right: 20.0),
                            child: Text(
                              "Mot de passe oublié?",
                              style: TextStyle(color: Colors.black45),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 40.0,
                backgroundColor: AppColors.ACCENT_COLOR,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            height: 420,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    print(email);
                    print(password);
                    Provider.of<UserProvider>(context, listen: false)
                        .signIn(email.trim(), password.trim())
                        .then((responseModel) {
                      setState(() {
                        loading = false;
                      });
                      if (responseModel.success) {
                        Navigator.pushNamed(context, DashBoard.routeName);
                      } else {
                        AppDialogs().showResponseDialog(context,
                            'Vérifiez vos identifiants de connexion', false);
                      }
                    });
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0)),
                child: Text("Se connecter",
                    style: mediumBoldTextStyle(AppColors.PRIMARY_COLOR)),
                color: AppColors.ACCENT_COLOR,
              ),
            ),
          )
        ],
      ),
    );
  }
}
