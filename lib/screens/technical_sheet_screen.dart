import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jokosun/constants/app_api.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/models/inventory_model.dart';
import 'package:jokosun/models/response_model.dart';
import 'package:jokosun/utils/app_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TechnicalSheetScreen extends StatefulWidget {
  static const routeName = '/technicalSheetScreen';
  final int installationId;

  const TechnicalSheetScreen({this.installationId});

  @override
  _TechnicalSheetScreenState createState() => _TechnicalSheetScreenState();
}

Future<ResponseModel> _future;

class _TechnicalSheetScreenState extends State<TechnicalSheetScreen> {
  var products = List<Product>();
  var tools = List<Tool>();
  bool loading = false;
  bool checkListOk = false;

  Future<ResponseModel> getCompanies() async {

    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    print(token);
    final response = await http.get(
      "$baseUrl/installations/setups/${widget.installationId}/inventory",
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    ResponseModel responseModel = responseModelFromJson(response.body);
    print(responseModel.data);
    products = Inventory
        .fromJson(responseModel.data)
        .inventory
        .products;
    tools = Inventory
        .fromJson(responseModel.data)
        .inventory
        .tools;
    setState(() {
      loading = false;
    });
  }
Future<ResponseModel> validChecklist() async {

    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    print(token);
    final response = await http.get(
      "$baseUrl/installations/setups/${widget.installationId}/checklist",
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    ResponseModel responseModel = responseModelFromJson(response.body);
    print(responseModel.data);
    setState(() {
      loading = false;
    });
    return(responseModel);

  }

  Function verify() {
    bool checked = true;
    products.forEach((element) {
      if (!element.selected) {
        setState(() {
          checkListOk = false;
          checked = false;
          return;
        });
      }
    });
    tools.forEach((element) {
      if (!element.selected) {
        setState(() {
          checkListOk = false;
          checked  = false;
          return;
        });
      }
    });
    if(checked){
      setState(() {
        checkListOk = true;
      });
    }

  }

  @override
  void initState() {
    _future = getCompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    BuildContext buildContext  = context;
    return loading
        ? Scaffold(body: loadingLayout())
        : Scaffold(
      appBar: mainAppBar('Préparation'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<ResponseModel>(
            future: _future,
            builder: (context, snapchot) {
              return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Produits',
                          style: regularLightTextStyle(
                              AppColors.PRIMARY_COLOR)),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                products[index].selected =
                                !products[index].selected;
                              });
                              verify();
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(products[index].name,
                                        style: regularLightTextStyle(
                                            products[index].selected
                                                ? Colors.green
                                                : AppColors.PRIMARY_COLOR)),
                                    products[index].selected
                                        ? Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    )
                                        : Text("Valider",
                                        style: mediumLightTextStyle(
                                            AppColors.PRIMARY_COLOR)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Outils',
                          style: regularLightTextStyle(
                              AppColors.PRIMARY_COLOR)),
                    ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: tools.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                tools[index].selected =
                                !tools[index].selected;
                              });
                              verify();
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(tools[index].name,
                                        style: regularLightTextStyle(
                                            tools[index].selected
                                                ? Colors.green
                                                : AppColors.PRIMARY_COLOR)),
                                    tools[index].selected
                                        ? Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    )
                                        : Text("Valider",
                                        style: mediumLightTextStyle(
                                            AppColors.PRIMARY_COLOR)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                    SizedBox(height: 16,),
                    Center(
                        child: RaisedButton.icon(
                          icon:
                          Icon(Icons.check,
                              color: AppColors.PRIMARY_COLOR),
                          label: Text(
                            'Préparation terminée',
                            style: regularLightTextStyle(
                                AppColors.PRIMARY_COLOR),
                          ),
                          shape: buttonMainShape(),
                          color: Colors.white,
                          onPressed: checkListOk
                              ? () {
                                  validChecklist().then((value) {
                                    if(value.success){
                                      AppDialogs().showResponseDialog(buildContext, 'Préparation validée avec succés', true).then((value) => Navigator.of(buildContext).pop(true));
                                    } else {
                                      AppDialogs().showResponseDialog(buildContext, value.message, true);

                                    }
                                  });
                          }
                              : null,
                        )),

                    SizedBox(height: 64,),
                  ]
              );
            }),
      ),
    );
  }
}
