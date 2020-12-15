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

class Composeteam extends StatefulWidget {
  static const routeName = '/composeTeam';

  @override
  _ComposeteamState createState() => _ComposeteamState();
}

Future<ResponseModel> _future;

class _ComposeteamState extends State<Composeteam> {
  var items = List<Technician>();
  List<Technician> selectedTechnicians = [];
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

  Function handleSelection(Technician technician){
    if(selectedTechnicians.contains(technician)){
      setState(() {
        selectedTechnicians.remove(technician);
      });
    } else {
      setState(() {
        selectedTechnicians.add(technician);
      });
    }
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

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${selectedTechnicians.length} techniciens séléctionnés',
                style: regularLightTextStyle(AppColors.PRIMARY_COLOR),
              ),
            ),
            FutureBuilder<ResponseModel>(
                future: _future,
                builder: (context, snapchot) {
                  return Expanded(
                    child: ListView.builder(
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
                                  style: regularBoldTextStyle(
                                      AppColors.PRIMARY_COLOR)),
                              subtitle: Text(
                                items[index].phone,
                                style: mediumLightTextStyle(
                                    AppColors.PRIMARY_COLOR),
                              ),
                              trailing: selectedTechnicians.contains( items[index])? Icon(Icons.check_box, color: Colors.green,): null,

                              onTap: () {
                                handleSelection( items[index]);
                              },
                            ),
                          );
                        }),
                  );
                }),
            RaisedButton(
              onPressed: () async {
                Navigator.of(context).pop(selectedTechnicians);
              },
              shape: buttonMainShape(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text("Valider",
                    style: mediumBoldTextStyle(AppColors.PRIMARY_COLOR)),
              ),
              color: Colors.white,
            ),
            SizedBox(height: 16,)
          ],
        ),
      ),
    );
  }
}
