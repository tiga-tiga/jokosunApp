import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/models/invoices_model.dart';
import 'package:jokosun/models/response_model.dart';
import 'package:jokosun/network/user_api.dart';
import 'package:jokosun/utils/app_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddInvoice extends StatefulWidget {
  static const routeName = '/addInvoice';
  final int installationId;

  const AddInvoice({this.installationId});
  @override
  _AddInvoiceState createState() => _AddInvoiceState();
}

Future<ResponseModel> _future;

class _AddInvoiceState extends State<AddInvoice> {
  var items = List<Invoice>();
  bool loading = false;
  var _value = "all";

  Future<ResponseModel> getInvoices() async {
    // items.clear();
    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    print(token);


    var uri = Uri.https(
        'jokosun.dohappit.com', '/api/installations/${widget.installationId}/invoice');

    final response = await http.get(
      uri,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    ResponseModel responseModel = responseModelFromJson(response.body);

    items = Invoices
        .fromJson(responseModel.data)
        .invoices;

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    _future = getInvoices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(body: loadingLayout())
        : Scaffold(
      appBar: mainAppBar('Factures'),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          FilePickerResult result = await FilePicker.platform.pickFiles();

          if (result != null) {
            File file = File(result.files.single.path);
            setState(() {
              loading = true;
            });
            await UserApi()
                .sendInvoice(
              widget.installationId,
                result.files.single.path,
            )
                .then((value) {
              setState(() {
                loading = false;
              });
              if (value.success) {
                print('success');
                AppDialogs()
                    .showResponseDialog(
                    context,
                    "Facture envoyé ",
                    value.success)
                    .then((value) {
                      getInvoices();
                });
              } else {
                AppDialogs().showResponseDialog(
                    context, value.message, value.success);
              }
            });
          } else {
            // User canceled the picker
          }
        },
        icon: Icon(Icons.add, color: AppColors.ACCENT_COLOR,),
        backgroundColor: AppColors.PRIMARY_COLOR,
        label: Text("Nouvelle Facture",
            style: regularLightTextStyle(AppColors.ACCENT_COLOR)),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: FutureBuilder<ResponseModel>(
              future: _future,
              builder: (context, snapchot) {
                return items.length > 0 ? Column(children: [
                  ListView.builder(
                      itemCount: items.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Card(child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Facture ${index + 1}'),
                              items[index].status == 'PENDING' ? Text(
                                'En cours de validation',
                                style: regularLightTextStyle(
                                    AppColors.PRIMARY_COLOR),) : items[index]
                                  .status == 'PENDING'
                                  ? Text('Réfusé',
                                  style: regularLightTextStyle(Colors.red))
                                  : Text('Validé',
                                style: regularLightTextStyle(Colors.green),)
                            ],
                          ),
                        ));
                      })
                ]) : Center(
                  child: Text('Pas de facture envoyé'),
                );
              }),
        ),
      ),
    );
  }
}
