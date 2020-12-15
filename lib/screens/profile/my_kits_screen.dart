import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jokosun/constants/app_api.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/models/kit_model.dart';
import 'package:jokosun/models/response_model.dart';
import 'package:jokosun/screens/profile/kit_detail.dart';
import 'package:jokosun/utils/app_format.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyKits extends StatefulWidget {
  static final String routeName = "/myKits";

  @override
  _MyKitsState createState() => _MyKitsState();
}

Future<ResponseModel> _future;

class _MyKitsState extends State<MyKits> {
  var items = List<Kit>();
  bool loading = false;

  Future<ResponseModel> getKits() async {
    // items.clear();
    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    print(token);
    final response = await http.get(
      "$baseUrl/settings/kits",
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    ResponseModel responseModel = responseModelFromJson(response.body);

    items = Kits.fromJson(responseModel.data).kits;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    _future = getKits();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return loading
        ? Scaffold(body: loadingLayout())
        : Scaffold(
            appBar: mainAppBar('Kits'),
            body: FutureBuilder<ResponseModel>(
                future: _future,
                builder: (context, snapchot) {
                  return Lists(data: items);
                }),
          );
  }
}


class Lists extends StatelessWidget {
  final List<Kit> data;

  const Lists({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(6),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        Kit kit = data[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push( MaterialPageRoute(builder: (context) => KitDetail(kit: kit)));
          },
          child: Card(
            elevation: 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 100,
                  width: 110,
                  padding:
                      EdgeInsets.only(left: 0, top: 10, bottom: 70, right: 20),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(kit.sheet), fit: BoxFit.cover)),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        kit.name,
                        style: regularLightTextStyle(AppColors.PRIMARY_COLOR),
                      ),
                      Text(
                        '${kit.categoryId}',
                        style: smallLightTextStyle(Colors.black87),
                      ),
                      Text(
                        '${formatCurrency(int.parse(kit.price))}Fcfa',
                        style: smallLightTextStyle(Colors.black87),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
