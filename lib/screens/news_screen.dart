import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/models/notifications_model.dart';
import 'package:jokosun/models/response_model.dart';
import 'package:jokosun/network/user_api.dart';
import 'package:jokosun/providers/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsScreen extends StatefulWidget {
  static const routeName = '/newsScreen';

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

Future<ResponseModel> _future;

class _NewsScreenState extends State<NewsScreen> {
  var items = List<AppNotification>();
  bool loading = false;
  int companyId;
  var _value = "all";

  Future<ResponseModel> getNotifications(int companyId) async {
    // items.clear();
    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    print(token);

    var queryParameters = {
      'status': 'FINISHED',
    };
    var uri = Uri.https('jokosun.dohappit.com', '/api/notifications/all');

    final response = await http.get(
      uri,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    ResponseModel responseModel = responseModelFromJson(response.body);

    items = Notifications.fromJson(responseModel.data).notifications;

    setState(() {
      loading = false;
    });
  }

  int dayDifference(String date) {
    DateTime aDateTime = DateFormat("dd/MM/yy hh:mm").parse(date);
    DateTime now = DateTime.now();
    return aDateTime.difference(now).inDays;
  }

  @override
  void initState() {
    companyId =
        Provider.of<UserProvider>(context, listen: false).user.company.id;
    _future = getNotifications(companyId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(body: loadingLayout())
        : Scaffold(
            appBar: mainAppBar('Notifications'),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: FutureBuilder<ResponseModel>(
                    future: _future,
                    builder: (context, snapchot) {
                      return Column(
                        children: [
                          ListView.builder(
                              itemCount: items.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    //TODO: Mark  as read
                                  },
                                  child: Card(
                                    elevation: 4.0,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  '${items[index].createdAt}',
                                                  style: smallBoldTextStyle(
                                                      AppColors.PRIMARY_COLOR),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    items[index].readAt != null
                                                        ? null
                                                        : setState(() {
                                                            loading = true;
                                                          });
                                                    UserApi()
                                                        .markNotificationAsRead(
                                                      items[index].id,
                                                    )
                                                        .then((value) {
                                                      setState(() {
                                                        loading = false;
                                                      });
                                                      getNotifications(
                                                          companyId);
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.check,
                                                    color:
                                                        items[index].readAt !=
                                                                null
                                                            ? AppColors
                                                                .PRIMARY_COLOR
                                                            : Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '${items[index].message}',
                                                  textAlign: TextAlign.left,
                                                  style: mediumLightTextStyle(
                                                      AppColors.PRIMARY_COLOR),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                  ),
                                );
                              }),
                        ],
                      );
                    }),
              ),
            ),
          );
  }
}
