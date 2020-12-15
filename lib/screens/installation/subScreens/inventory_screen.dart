import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/network/user_api.dart';
import 'package:jokosun/utils/app_dialogs.dart';
import 'package:jokosun/utils/take_picture_screen.dart';

class InventoryScreen extends StatefulWidget {
  static const routeName = '/inventoryScreen';
  final VoidCallback onFinish;
  final int installationId;

  const InventoryScreen({Key key, this.onFinish, this.installationId})
      : super(key: key);

  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  bool isCameraReady = false;
  bool clientExplained = false;
  bool gpsRegistered = false;
  bool showCapturedPhoto = false;
  bool loading = false;
  Position position;

  var imagePath1;
  var imagePath2;
  var imagePath3;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    position = await Geolocator.getCurrentPosition();
    print(position.latitude);
    print(position.longitude);
    return position;
  }

  @override
  void initState() {
    super.initState();
  }

  List<String> images = List<String>();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColors.PRIMARY_COLOR,
                valueColor:
                    new AlwaysStoppedAnimation<Color>(AppColors.ACCENT_COLOR),
              ),
            ),
          )
        : Scaffold(
            appBar: mainAppBar('Etat des lieux'),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Expliquez au client',
                                style: regularLightTextStyle(clientExplained
                                    ? Colors.green
                                    : AppColors.PRIMARY_COLOR)),
                            clientExplained
                                ? Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        clientExplained = true;
                                      });
                                    },
                                    child: Text("Valider",
                                        style: mediumLightTextStyle(
                                            AppColors.PRIMARY_COLOR))),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Enregistrez le point GPS',
                                style: regularLightTextStyle(gpsRegistered
                                    ? Colors.green
                                    : AppColors.PRIMARY_COLOR)),
                            gpsRegistered
                                ? Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      _determinePosition();
                                      setState(() {
                                        gpsRegistered = true;
                                      });
                                    },
                                    child: Text("Enregistrer",
                                        style: mediumLightTextStyle(
                                            AppColors.PRIMARY_COLOR))),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Prenez 3 photos de départ',
                          style:
                              regularLightTextStyle(AppColors.PRIMARY_COLOR)),
                    ),
                    Card(
                      shape: imagePath1 != null
                          ? RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.green,
                                width: 1.5,
                              ),
                            )
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          leading: GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.ACCENT_COLOR,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              padding: EdgeInsets.all(2),
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  child: imagePath1 != null
                                      ? Image.file(
                                          File(imagePath1),
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'assets/img/take_picture.jpg',
                                          height: 50)),
                            ),
                            onTap: () {
                              if (imagePath1 != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DisplayPictureScreen(
                                        imagePath: imagePath1),
                                  ),
                                );
                              }
                            },
                          ),
                          title: Text('Photo 1',
                              style: regularLightTextStyle(
                                  AppColors.PRIMARY_COLOR)),
                          trailing: GestureDetector(
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TakePictureScreen(),
                                  ),
                                ).then((value) {
                                  if (value != null) {
                                    setState(() {
                                      imagePath1 = value;
                                    });
                                  }
                                });
                              },
                              child: Text(
                                  imagePath1 != null ? 'Modifier' : "Ajouter",
                                  style: mediumLightTextStyle(
                                      AppColors.PRIMARY_COLOR))),
                        ),
                      ),
                    ),
                    Card(
                      shape: imagePath2 != null
                          ? RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.green,
                                width: 1.5,
                              ),
                            )
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          leading: GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.ACCENT_COLOR,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              padding: EdgeInsets.all(2),
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  child: imagePath2 != null
                                      ? Image.file(
                                          File(imagePath2),
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'assets/img/take_picture.jpg',
                                          height: 50)),
                            ),
                            onTap: () {
                              if (imagePath2 != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DisplayPictureScreen(
                                        imagePath: imagePath2),
                                  ),
                                );
                              }
                            },
                          ),
                          title: Text('Photo 2',
                              style: regularLightTextStyle(
                                  AppColors.PRIMARY_COLOR)),
                          trailing: GestureDetector(
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TakePictureScreen(),
                                  ),
                                ).then((value) {
                                  if (value != null) {
                                    setState(() {
                                      imagePath2 = value;
                                    });
                                  }
                                });
                              },
                              child: Text(
                                  imagePath2 != null ? 'Modifier' : "Ajouter",
                                  style: mediumLightTextStyle(
                                      AppColors.PRIMARY_COLOR))),
                        ),
                      ),
                    ),
                    Card(
                      shape: imagePath3 != null
                          ? RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.green,
                                width: 1.5,
                              ),
                            )
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          leading: GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.ACCENT_COLOR,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              padding: EdgeInsets.all(2),
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  child: imagePath3 != null
                                      ? Image.file(
                                          File(imagePath3),
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'assets/img/take_picture.jpg',
                                          height: 50)),
                            ),
                            onTap: () {
                              if (imagePath3 != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DisplayPictureScreen(
                                        imagePath: imagePath3),
                                  ),
                                );
                              }
                            },
                          ),
                          title: Text('Photo 3',
                              style: regularLightTextStyle(
                                  AppColors.PRIMARY_COLOR)),
                          trailing: GestureDetector(
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TakePictureScreen(),
                                  ),
                                ).then((value) {
                                  if (value != null) {
                                    setState(() {
                                      imagePath3 = value;
                                    });
                                  }
                                });
                              },
                              child: Text(
                                  imagePath3 != null ? 'Modifier' : "Ajouter",
                                  style: mediumLightTextStyle(
                                      AppColors.PRIMARY_COLOR))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: RaisedButton.icon(
                        icon: Icon(Icons.arrow_forward,
                            color: AppColors.PRIMARY_COLOR),
                        label: Text(
                          'Suivant',
                          style: regularLightTextStyle(AppColors.PRIMARY_COLOR),
                        ),
                        shape: buttonMainShape(),
                        color: Colors.white,
                        onPressed: gpsRegistered &&
                                    clientExplained &&
                                    imagePath1 != null &&
                                    imagePath2 != null &&
                                    imagePath3 != null

                            ? () async {
                          setState(() {
                            loading = true;
                          });
                                await UserApi()
                                    .prepareInstallationRequest(
                                        widget.installationId,
                                        imagePath1,
                                        imagePath2,
                                        imagePath3,
                                        position.latitude,
                                        position.longitude)
                                    .then((value) {
                                  setState(() {
                                    loading = false;
                                  });
                                  if (value.success) {
                                    print('success');
                                    AppDialogs()
                                        .showResponseDialog(context,
                                            'Etat des lieux enregistré avec succés', value.success)
                                        .then((value) {
                                      widget.onFinish();
                                    });
                                  } else {
                                    AppDialogs().showResponseDialog(
                                        context, value.message, value.success);
                                  }
                                });
                              }
                            : null,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
