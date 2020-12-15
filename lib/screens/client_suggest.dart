import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jokosun/constants/app_api.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/models/kit_model.dart';
import 'package:jokosun/models/proposal_model.dart';
import 'package:jokosun/models/response_model.dart';
import 'package:jokosun/network/user_api.dart';
import 'package:jokosun/utils/app_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientSuggest extends StatefulWidget {
  static const routeName = '/clientSuggest';

  @override
  _ClientSuggestState createState() => _ClientSuggestState();
}

Future<Proposal> _future;

class _ClientSuggestState extends State<ClientSuggest> {
  TextEditingController editingController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String address;
  String phone;
  String name;
  List<ListItem> _dropdownItems = [];

  List<ProposalElement> clientList = [];

  Future<Proposal> getProposals() async {
    _dropdownItems.clear();

    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    print(token);
    final response = await http.get(
      "$baseUrl/proposals",
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      ResponseModel responseModel = responseModelFromJson(response.body);

      clientList = Proposal.fromJson(responseModel.data).proposal;
      print('Clientlist ${response.body}');
      setState(() {
        loading = false;
        loadingKits = true;
      });
      final responseKits = await http.get(
        "$baseUrl/resources/kits",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      ResponseModel responseKitsModel =
          responseModelFromJson(responseKits.body);

      List<Kit> kits = Kits.fromJson(responseKitsModel.data).kits;

      print(kits.length);

      for (Kit kit in kits) {
        _dropdownItems.add(ListItem(kit.id, "kit", kit));
      }

      _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
      _selectedItem = _dropdownMenuItems[0].value;
      setState(() {
        loadingKits = false;
      });

      return Proposal.fromJson(responseModel.data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      setState(() {
        loading = false;
      });
      throw Exception('Failed to load projects');
    }
  }

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;
  bool loading = false;
  bool loadingKits = false;

  @override
  void initState() {
    _future = getProposals();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(body: loadingLayout())
        : Scaffold(
            appBar: mainAppBar('Proposer un client'),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<Proposal>(
                  future: _future,
                  builder: (context, snapchot) {
                    return SingleChildScrollView(
                      child: Column(children: <Widget>[
                        ExpansionTile(
                          title: Text(
                            '${clientList.length} clients proposés',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: AppColors.PRIMARY_COLOR,
                                fontSize: 16),
                          ),
                          trailing: Text('Tout voir',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 12)),
                          children: <Widget>[
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: clientList.length,
                              itemBuilder: (context, index) {
                                //print(clientList[index].fullName);
                                return Card(
                                    child: ListTile(
                                  leading: Text(
                                    'N°${clientList[index].id}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: AppColors.PRIMARY_COLOR,
                                        fontSize: 16),
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        clientList[index].fullName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.PRIMARY_COLOR,
                                            fontSize: 16),
                                      ),
                                      Text(clientList[index].kit.name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 12)),
                                      Text(clientList[index].address,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 12)),
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text('20/11/2020',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 12)),
                                      Text('Perdu',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 12,
                                              color: Colors.red)),
                                    ],
                                  ),
                                ));
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (value) {
                              name = value;
                            },
                            decoration: textFieldInputDecoration(
                                'Prenom et nom du client'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (value) {
                              address = value;
                            },
                            decoration:
                                textFieldInputDecoration('Adresse du client'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (value) {
                              phone = value;
                            },
                            decoration:
                                textFieldInputDecoration('N° de téléphone'),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border:
                                  Border.all(color: AppColors.PRIMARY_COLOR)),
                          child: loadingKits
                              ? Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(
                                        backgroundColor:
                                            AppColors.PRIMARY_COLOR,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                AppColors.ACCENT_COLOR),
                                      ),
                                    ),
                                  ],
                                )
                              : DropdownButton(
                                  isExpanded: true,
                                  value: _selectedItem,
                                  iconEnabledColor: AppColors.PRIMARY_COLOR,
                                  iconSize: 32,
                                  style: regularLightTextStyle(Colors.black87),
                                  items: _dropdownMenuItems,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedItem = value;
                                    });
                                  }),
                        ),
                        GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border:
                                    Border.all(color: AppColors.PRIMARY_COLOR)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text(
                                  'Date souhaitée: ${selectedDate.toLocal()}'.split(' ')[0],
                                  style: regularLightTextStyle(Colors.black87),
                                  //controller: editingController,
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(
                                    Icons.calendar_today,
                                    color: AppColors.PRIMARY_COLOR,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            AppDialogs()
                                .showDatePickerDialod(context, selectedDate)
                                .then((value) {
                              if (value != null && value != selectedDate)
                                setState(() {
                                  selectedDate = value;
                                });
                            });
                          },
                        ),
                        const SizedBox(height: 48),
                        RaisedButton(
                          onPressed: () async {
                            UserApi userApi = UserApi();
                            setState(() {
                              loading = true;
                            });
                            await userApi
                                .createProposal(
                                    name,
                                    address,
                                    phone,
                                    "${selectedDate.toLocal()}".split(' ')[0],
                                    _selectedItem.kit.id)
                                .then((value) {
                              setState(() {
                                loading = false;
                              });
                              if (value.success) {
                                print('success');
                                AppDialogs().showResponseDialog(
                                    context, value.message, value.success);
                              } else {
                                AppDialogs().showResponseDialog(
                                    context, value.message, value.success);
                              }
                            });
                          },
                          shape: buttonMainShape(),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text("Valider",
                                style: mediumBoldTextStyle(
                                    AppColors.PRIMARY_COLOR)),
                          ),
                          color: Colors.white,
                        ),
                      ]),
                    );
                  }),
            ),
          );
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.kit.name),
          value: listItem,
        ),
      );
    }
    return items;
  }
}

class ListItem {
  int value;
  String name;
  Kit kit;

  ListItem(this.value, this.name, this.kit);
}
