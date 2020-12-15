import 'package:flutter/material.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/network/admin_api.dart';
import 'package:jokosun/utils/app_dialogs.dart';

class AddTeam extends StatefulWidget {
  static const routeName = '/addTeam';

  @override
  _AddTeamState createState() => _AddTeamState();
}

class _AddTeamState extends State<AddTeam> {
  TextEditingController editingController = TextEditingController();
  String name;
  String email;
  String phone;
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar('Ajouter un technicien'),
      body: loading? Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            backgroundColor: AppColors.PRIMARY_COLOR,
            valueColor: new AlwaysStoppedAnimation<Color>(AppColors.ACCENT_COLOR),
          ),
        ),
      ): Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  name = value;
                },
                //controller: editingController,
                decoration: textFieldInputDecoration('Prenom et nom '),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  email = value;
                },
                //controller: editingController,
                decoration: textFieldInputDecoration('Adresse Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  phone = value;
                },
                //controller: editingController,
                decoration: textFieldInputDecoration('N° de téléphone'),
              ),
            ),
            const SizedBox(height: 48),
            RaisedButton(
              onPressed: () async {
                AdminApi adminApi = AdminApi();
                setState(() {
                  loading   = true;
                });
                await adminApi.createEmploye(email, name, phone).then((value) {
                  setState(() {
                    loading = false;
                  });
                  print(value.message);
                  if(value.success){
                    AppDialogs().showResponseDialog(context, 'Technicien crée avec succés', value.success);
                  } else {

                    AppDialogs().showResponseDialog(context, 'Erreur lors de la création du  technicien', value.success);
                  }
                });
              },
              shape: buttonMainShape(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text("Valider",
                    style: mediumLightTextStyle(AppColors.PRIMARY_COLOR)),
              ),
              color: Colors.white,
            ),
          ]),
        ),
      ),
    );
  }
}
