import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jokosun/constants/app_api.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/models/kit_model.dart';
import 'package:jokosun/models/offers_model.dart';
import 'package:jokosun/models/proposal_model.dart';
import 'package:jokosun/models/response_model.dart';
import 'package:jokosun/network/admin_api.dart';
import 'package:jokosun/utils/app_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminUpdateOffer extends StatefulWidget {
  static const routeName = '/adminUpdateOffer';

  final Offer offer;

  const AdminUpdateOffer(this.offer);

  @override
  _AdminUpdateOfferState createState() => _AdminUpdateOfferState();
}

Future<Proposal> _future;

class _AdminUpdateOfferState extends State<AdminUpdateOffer> {
  TextEditingController editingController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String address;
  String city;
  int technicians;
  int flatRate;
  int removalAndTransport;
  String name;
  List<ListItem> _dropdownItems = [];

  Future<Proposal> getKits() async {
    _dropdownItems.clear();

    setState(() {
      loadingKits = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    print(token);

    final responseKits = await http.get(
      "$baseUrl/resources/kits",
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    if (responseKits.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
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

      return Proposal.fromJson(responseKitsModel.data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      setState(() {
        loadingKits = false;
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
    _future = getKits();

    selectedDate = new DateFormat("dd/MM/yyyy hh:mm")
        .parse(widget.offer.commissioningDate);
    selectedTime = new TimeOfDay.fromDateTime(selectedDate);
    address = widget.offer.address;
    city = widget.offer.city;
    name = widget.offer.customerName;
    flatRate = int.parse(widget.offer.flatRate);
    removalAndTransport = int.parse(widget.offer.removalAndTransport);
    technicians = widget.offer.technicians;
    address = widget.offer.address;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(body: loadingLayout())
        : Scaffold(
            appBar: mainAppBar('Créer une offre'),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<Proposal>(
                  future: _future,
                  builder: (context, snapchot) {
                    return SingleChildScrollView(
                      child: Column(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            initialValue: widget.offer.customerName,
                            onChanged: (value) {
                              name = value;
                            },
                            decoration: textFieldInputDecoration(
                                'Prenom et nom du client'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            initialValue: widget.offer.address,
                            onChanged: (value) {
                              address = value;
                            },
                            decoration:
                                textFieldInputDecoration('Adresse du client'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            initialValue: widget.offer.city,
                            onChanged: (value) {
                              city = value;
                            },
                            decoration: textFieldInputDecoration('Ville'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            initialValue: widget.offer.flatRate.toString(),
                            onChanged: (value) {
                              flatRate = int.parse(value);
                            },
                            decoration:
                                textFieldInputDecoration('Forfat en Fcfa'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            initialValue:
                                widget.offer.removalAndTransport.toString(),
                            onChanged: (value) {
                              removalAndTransport = int.parse(value);
                            },
                            decoration:
                                textFieldInputDecoration('Transport en Fcfa'),
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
                                  items: _dropdownMenuItems,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedItem = value;
                                    });
                                  }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            initialValue: widget.offer.technicians.toString(),
                            onChanged: (value) {
                              technicians = int.parse(value);
                            },
                            decoration: textFieldInputDecoration(
                                'Techniciens nécessaires'),
                            keyboardType: TextInputType.number,
                          ),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: AppColors.PRIMARY_COLOR,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Date d\'installation: ',
                                  //controller: editingController,
                                ),
                                Text("${selectedDate.toLocal()}".split(' ')[0]),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: AppColors.PRIMARY_COLOR,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Heure d\'installation: ',
                                  //controller: editingController,
                                ),
                                Text(
                                    "${selectedTime.hour}: ${selectedTime.minute}"),
                              ],
                            ),
                          ),
                          onTap: () {
                            AppDialogs()
                                .showTimePickerDialog(context, selectedTime)
                                .then((value) {
                              if (value != null && value != selectedTime)
                                setState(() {
                                  selectedTime = value;
                                });
                            });
                          },
                        ),
                        const SizedBox(height: 48),
                        RaisedButton(
                          onPressed: () async {
                            setState(() {
                              //loading = true;
                            });
                            print(name);
                            print(address);
                            print(city);
                            print(flatRate);
                            print(removalAndTransport);
                            print(
                                "${DateFormat('dd-MM-yyyy').format(selectedDate)} ${selectedTime.hour}:${selectedTime.minute}");
                            print(_selectedItem.kit.id);
                            print(technicians);
                            print(name);
                            await AdminApi()
                                .updateOffer(
                                    widget.offer.id,
                                    name,
                                    address,
                                    city,
                                    flatRate,
                                    removalAndTransport,
                                    "${DateFormat('dd-MM-yyyy').format(selectedDate)} ${selectedTime.hour}:${selectedTime.minute}",
                                    _selectedItem.kit.id,
                                    technicians)
                                .then((value) {
                              setState(() {
                                loading = false;
                              });
                              if (value.success) {
                                print('success');
                                AppDialogs().showResponseDialog(context,
                                    'Offre modifié avec succés ', value.success);
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
