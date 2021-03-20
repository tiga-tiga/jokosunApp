import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/models/invoices_model.dart';
import 'package:jokosun/models/response_model.dart';
import 'package:jokosun/network/admin_api.dart';
import 'package:jokosun/utils/app_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminInstallationInvoices extends StatefulWidget {
  static const routeName = '/adminInvoice';
  final int installationId;

  const AdminInstallationInvoices({this.installationId});

  @override
  _AdminInstallationInvoicesState createState() =>
      _AdminInstallationInvoicesState();
}

Future<ResponseModel> _future;

class _AdminInstallationInvoicesState extends State<AdminInstallationInvoices> {
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

    var uri = Uri.https('jokosun.dohappit.com',
        '/api/installations/${widget.installationId}/invoice');

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
    print(items.last.file);

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
    BuildContext buildContext = context;
    return loading
        ? Scaffold(body: loadingLayout())
        : Scaffold(
      appBar: mainAppBar('Factures'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: FutureBuilder<ResponseModel>(
              future: _future,
              builder: (context, snapchot) {
                return items.length > 0
                    ? Column(children: [
                  ListView.builder(
                      itemCount: items.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 16),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Facture ${index + 1}'),
                                      items[index].status == 'PENDING'
                                          ? Row(
                                        children: [
                                          Icon(
                                            Icons.download_outlined,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          GestureDetector(
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            onTap: () async {
                                              await AppDialogs()
                                                  .showConfirmationDialog(
                                                  buildContext,
                                                  'Approuver cette facture?')
                                                  .then((value) {
                                                if (value) {
                                                  setState(() {
                                                    loading = true;
                                                  });
                                                  ResponseModel responseModel;
                                                  AdminApi()
                                                      .approveInvoice(
                                                      widget.installationId,
                                                      items[index].id)
                                                      .then((value) {
                                                    responseModel = value;
                                                    getInvoices();
                                                    setState(() {
                                                      loading = false;
                                                    });
                                                  });
                                                }
                                              });
                                            },
                                          ),

                                          GestureDetector(
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ),
                                            onTap: () async {
                                              await AppDialogs()
                                                  .showConfirmationDialog(
                                                  buildContext,
                                                  'Rejeter la  facture?')
                                                  .then((value) {
                                                if (value) {
                                                  setState(() {
                                                    loading = true;
                                                  });
                                                  ResponseModel responseModel;
                                                  AdminApi()
                                                      .rejectInvoice(
                                                      widget.installationId,
                                                      items[index].id)
                                                      .then((value) {
                                                    responseModel = value;
                                                    //print(responseModel.message);
                                                    getInvoices();
                                                    setState(() {
                                                      loading = false;
                                                    });
                                                  });
                                                }
                                              });
                                            },
                                          )
                                        ],
                                      )
                                          : items[index].status == 'APPROVED'
                                          ? Text(
                                        'Validé',
                                        style:
                                        regularLightTextStyle(
                                            Colors.green),
                                      ) : Text('Réfusé',
                                          style:
                                          regularLightTextStyle(
                                              Colors.red))

                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Télécharger',
                                          style:
                                          mediumLightTextStyle(
                                              Colors.grey)),
                                    ],
                                  )
                                ],
                              ),
                            ));
                      }),

                ])
                    : Center(
                  child: Text('Pas de facture envoyé'),
                );
              }),
        ),
      ),
    );
  }
}
