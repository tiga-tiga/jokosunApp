import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jokosun/constants/app_api.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/models/response_model.dart';
import 'package:jokosun/models/technician_model.dart';
import 'package:jokosun/screens/add_team_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTeam extends StatefulWidget {
  static const routeName = '/myTeam';

  @override
  _MyTeamState createState() => _MyTeamState();
}

Future<ResponseModel> _future;

class _MyTeamState extends State<MyTeam> {
  var items = List<Technician>();
  bool loading = false;

  Future<ResponseModel> getTechnicians() async {
    // items.clear();
    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    print(token);
    final response = await http.get(
      "$baseUrl/technicians",
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    ResponseModel responseModel = responseModelFromJson(response.body);

    items = Technicians.fromJson(responseModel.data).technicians;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    _future = getTechnicians();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(body: loadingLayout())
        : Scaffold(
            appBar: mainAppBar('Mon équipe'),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(AddTeam.routeName);
              },
              icon: Icon(Icons.add,  color: AppColors.ACCENT_COLOR,),
              backgroundColor: AppColors.PRIMARY_COLOR,
              label: Text("Nouveau technicien", style: regularLightTextStyle(AppColors.ACCENT_COLOR)),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<ResponseModel>(
                  future: _future,
                  builder: (context, snapchot) {
                    return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 4.0,
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8.0),
                              leading: Container(
                                  height: double.infinity,
                                  child: CircleAvatar(
                                    radius: 24.0,
                                    backgroundImage: NetworkImage(
                                        items[index].profilePhotoUrl),
                                    backgroundColor: Colors.transparent,
                                  )),
                              title: Text(items[index].name,
                                  style: mediumBoldTextStyle(
                                      AppColors.PRIMARY_COLOR)),
                              subtitle: Text(
                                items[index].phone,
                                style: mediumLightTextStyle(
                                    AppColors.PRIMARY_COLOR),
                              ),
                              trailing: Container(
                                height: double.infinity,
                                child: Icon(
                                  Icons.chevron_right,
                                  color: Colors.black54,
                                ),
                              ),
                              onTap: () {},
                            ),
                          );
                        });
                  }),
            ),
          );
  }
}
