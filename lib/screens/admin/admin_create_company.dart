import 'package:flutter/material.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/models/proposal_model.dart';
import 'package:jokosun/network/admin_api.dart';
import 'package:jokosun/utils/app_dialogs.dart';

class AdminCreateCompany extends StatefulWidget {
  static const routeName = '/adminCreateCompany';

  @override
  _AdminCreateCompanyState createState() => _AdminCreateCompanyState();
}

Future<Proposal> _future;

class _AdminCreateCompanyState extends State<AdminCreateCompany> {
  TextEditingController editingController = TextEditingController();
  String email;
  String phone;
  String company;
  String name;

  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(body: loadingLayout())
        : Scaffold(
            appBar: mainAppBar('Créer une Installateur'),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<Proposal>(
                  future: _future,
                  builder: (context, snapchot) {
                    return SingleChildScrollView(
                      child: Column(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (value) {
                              name = value;
                            },
                            decoration:
                                textFieldInputDecoration('Nom et Prénom'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: textFieldInputDecoration('Email'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (value) {
                              phone = value;
                            },
                            decoration: textFieldInputDecoration('Téléphone'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (value) {
                              company = value;
                            },
                            decoration: textFieldInputDecoration(
                                'Nom de l\'entreprise'),
                          ),
                        ),
                        const SizedBox(height: 48),
                        RaisedButton(
                          onPressed: () async {
                            setState(() {
                              //loading = true;
                            });
                            await AdminApi()
                                .createCompany(
                              name,
                              email,
                              phone,
                              company,
                            )
                                .then((value) {
                              setState(() {
                                loading = false;
                              });
                              if (value.success) {
                                print('success');
                                AppDialogs().showResponseDialog(
                                    context,
                                    'Entreprise créée avec succés ',
                                    value.success);
                              } else {
                                AppDialogs().showResponseDialog(
                                    context, value.message, value.success);
                              }
                            });
                          },
                          shape: buttonMainShape(),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text("Valider",
                                style: mediumBoldTextStyle(
                                    AppColors.PRIMARY_COLOR)),
                          ),
                          color: Colors.white,
                        ),
                      ]),
                    );
                  }),
            ),
          );
  }
}
