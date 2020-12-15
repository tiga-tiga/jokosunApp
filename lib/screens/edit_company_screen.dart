import 'package:flutter/material.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';

class EditCompany extends StatefulWidget {
  static const routeName = '/editCompany';

  @override
  _EditCompanyState createState() => _EditCompanyState();
}

class _EditCompanyState extends State<EditCompany> {
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar('Paramétres'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: 'Hlm Grand Médine',
                onChanged: (value) {},
                //controller: editingController,
                decoration: textFieldInputDecoration('Adresse'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: '77 854 64 17',
                onChanged: (value) {},
                //controller: editingController,
                decoration: textFieldInputDecoration('N° de téléphone'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: '3847293930',
                onChanged: (value) {},
                //controller: editingController,
                decoration: textFieldInputDecoration('NINEA'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: 'gmtsarr@gmail.com',
                onChanged: (value) {},
                //controller: editingController,
                decoration: textFieldInputDecoration('Email'),
              ),
            ),
            const SizedBox(height: 48),
            RaisedButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: Text("Valider",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      wordSpacing: 3)),
              color: AppColors.PRIMARY_COLOR,
            ),
          ]),
        ),
      ),
    );
  }
}
