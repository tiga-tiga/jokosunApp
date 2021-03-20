import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:jokosun/constants/app_api.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/models/company_model.dart';
import 'package:jokosun/models/response_model.dart';
import 'package:jokosun/models/technician_model.dart';
import 'package:jokosun/screens/add_team_screen.dart';
import 'package:jokosun/screens/admin/admin_company_details.dart';
import 'package:jokosun/screens/admin/admin_create_company.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin_create_offer_screen.dart';

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


  ScrollController _hideButtonController;
  var _isVisible;

  @override
  void initState() {
    _future = getCompanies();

    super.initState();
    _isVisible = true;
    _hideButtonController = new ScrollController();
    _hideButtonController.addListener((){
      if(_hideButtonController.position.userScrollDirection == ScrollDirection.reverse){
        if(_isVisible == true) {
          /* only set when the previous state is false
             * Less widget rebuilds
             */
          print("**** ${_isVisible} up"); //Move IO away from setState
          setState((){
            _isVisible = false;
          });
        }
      } else {
        if(_hideButtonController.position.userScrollDirection == ScrollDirection.forward){
          if(_isVisible == false) {
            /* only set when the previous state is false
               * Less widget rebuilds
               */
            print("**** ${_isVisible} down"); //Move IO away from setState
            setState((){
              _isVisible = true;
            });
          }
        }
      }});
  }


  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(body: loadingLayout())
        : Scaffold(
      appBar: mainAppBar('Les installateurs'),

      floatingActionButton: Visibility(
        visible: _isVisible,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pushNamed(AdminCreateCompany.routeName);
          },
          icon: Icon(Icons.add,  color: AppColors.ACCENT_COLOR,),
          backgroundColor: AppColors.PRIMARY_COLOR,
          label: Text("Nouvel Installateur", style: regularLightTextStyle(AppColors.ACCENT_COLOR)),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<ResponseModel>(
            future: _future,
            builder: (context, snapchot) {
              return ListView.builder(

                  controller: _hideButtonController,
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

                                  GestureDetector(
                                    child: Text(
                                      'Installations',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: AppColors.PRIMARY_COLOR),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminCompanyDetails(companyId: items[index].id,)));
                                    },
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
