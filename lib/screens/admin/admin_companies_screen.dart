import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jokosun/constants/app_api.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/models/company_model.dart';
import 'package:jokosun/models/response_model.dart';
import 'package:jokosun/models/technician_model.dart';
import 'package:jokosun/screens/add_team_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminCompaniesScreen extends StatefulWidget {
  static const routeName = '/adminCompanies';

  @override
  _AdminCompaniesScreenState createState() => _AdminCompaniesScreenState();
}

Future<ResponseModel> _future;

class _AdminCompaniesScreenState extends State<AdminCompaniesScreen> {
  var items = List<Company>();
  bool loading = false;

  Future<ResponseModel> getCompanies() async {
    // items.clear();
    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    print(token);
    final response = await http.get(
      "$baseUrl/companies",
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    ResponseModel responseModel = responseModelFromJson(response.body);

    items = Companies.fromJson(responseModel.data).companies;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    _future = getCompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(body: loadingLayout())
        : Scaffold(
      appBar: mainAppBar('Les installateurs'),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<ResponseModel>(
            future: _future,
            builder: (context, snapchot) {
              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical:4.0),
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  items[index].name,
                                  style: regularBoldTextStyle(AppColors.ACCENT_COLOR)
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text('Bonus: ${items[index].bonus} points', style: mediumLightTextStyle(AppColors.PRIMARY_COLOR),),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[

                                  Text(
                                    'Détails',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: AppColors.PRIMARY_COLOR),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
