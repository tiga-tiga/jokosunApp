import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/network/user_api.dart';
import 'package:jokosun/utils/app_dialogs.dart';
import 'package:jokosun/utils/take_picture_screen.dart';

class FinalizeInstallScreen extends StatefulWidget {
  static const routeName = '/startScreen';
  final VoidCallback onFinish;
  final int installationId;

  const FinalizeInstallScreen({Key key, this.onFinish, this.installationId})
      : super(key: key);

  @override
  _FinalizeInstallScreenState createState() => _FinalizeInstallScreenState();
}

class _FinalizeInstallScreenState extends State<FinalizeInstallScreen> {
  bool checkNotice = false;
  bool checkExplanation = false;
  bool checkVisitCard = false;
  bool checkSignShipment = false;
  var imagePath1;
  var imagePath2;
  var imagePath3;
  var imagePath4;
  var imagePath5;
  bool loading = false;

  int _radioValue1 = -1;
  int _radioValue2 = -1;
  int _radioValue3 = -1;

  bool isButtonEnable() {
    return checkSignShipment &&
        checkVisitCard &&
        checkExplanation &&
        checkNotice;
  }

  @override
  void initState() {
    super.initState();
  }

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
            appBar: mainAppBar('Formation client'),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            checkNotice = !checkNotice;
                          });
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Remettez les notices au client",
                                    style: regularLightTextStyle(checkNotice
                                        ? Colors.green
                                        : AppColors.PRIMARY_COLOR)),
                                checkNotice
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
                        )),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            checkExplanation = !checkExplanation;
                          });
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Expliquez l'utilisation au client",
                                    style: regularLightTextStyle(
                                        checkExplanation
                                            ? Colors.green
                                            : AppColors.PRIMARY_COLOR)),
                                checkExplanation
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
                        )),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            checkVisitCard = !checkVisitCard;
                          });
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Expliquez la maintenance au client",
                                    style: regularLightTextStyle(checkVisitCard
                                        ? Colors.green
                                        : AppColors.PRIMARY_COLOR)),
                                checkVisitCard
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
                        )),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            checkSignShipment = !checkSignShipment;
                          });
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                    "Faites signer le bon de livraison\nau client",
                                    style: regularLightTextStyle(
                                        checkSignShipment
                                            ? Colors.green
                                            : AppColors.PRIMARY_COLOR)),
                                checkSignShipment
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
                        )),
                    SizedBox(
                      height: 24,
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(child: child, scale: animation);
                      },
                      child: checkNotice &&
                              checkExplanation &&
                              checkSignShipment &&
                              checkVisitCard
                          ? Visibility(
                              maintainState: true,
                              maintainAnimation: true,
                              visible: checkNotice &&
                                  checkExplanation &&
                                  checkSignShipment &&
                                  checkVisitCard,
                              child: Column(
                                children: [
                                  Text(
                                    'Prenez 5 belles photos de l\'intallation \n et des clients (si possible)',
                                    textAlign: TextAlign.center,
                                    style: mediumLightTextStyle(
                                        AppColors.PRIMARY_COLOR),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Card(
                                    shape: imagePath1 != null
                                        ? RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: BorderSide(
                                              color: Colors.green,
                                              width: 1.5,
                                            ),
                                          )
                                        : null,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: ListTile(
                                        leading: GestureDetector(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppColors.ACCENT_COLOR,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            padding: EdgeInsets.all(2),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
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
                                                  builder: (context) =>
                                                      DisplayPictureScreen(
                                                          imagePath:
                                                              imagePath1),
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
                                                  builder: (context) =>
                                                      TakePictureScreen(),
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
                                                imagePath1 != null
                                                    ? 'Modifier'
                                                    : "Ajouter",
                                                style: mediumLightTextStyle(
                                                    AppColors.PRIMARY_COLOR))),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    shape: imagePath2 != null
                                        ? RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: BorderSide(
                                              color: Colors.green,
                                              width: 1.5,
                                            ),
                                          )
                                        : null,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: ListTile(
                                        leading: GestureDetector(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppColors.ACCENT_COLOR,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            padding: EdgeInsets.all(2),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
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
                                                  builder: (context) =>
                                                      DisplayPictureScreen(
                                                          imagePath:
                                                              imagePath2),
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
                                                  builder: (context) =>
                                                      TakePictureScreen(),
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
                                                imagePath2 != null
                                                    ? 'Modifier'
                                                    : "Ajouter",
                                                style: mediumLightTextStyle(
                                                    AppColors.PRIMARY_COLOR))),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    shape: imagePath3 != null
                                        ? RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: BorderSide(
                                              color: Colors.green,
                                              width: 1.5,
                                            ),
                                          )
                                        : null,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: ListTile(
                                        leading: GestureDetector(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppColors.ACCENT_COLOR,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            padding: EdgeInsets.all(2),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
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
                                                  builder: (context) =>
                                                      DisplayPictureScreen(
                                                          imagePath:
                                                              imagePath3),
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
                                                  builder: (context) =>
                                                      TakePictureScreen(),
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
                                                imagePath3 != null
                                                    ? 'Modifier'
                                                    : "Ajouter",
                                                style: mediumLightTextStyle(
                                                    AppColors.PRIMARY_COLOR))),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    shape: imagePath4 != null
                                        ? RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: BorderSide(
                                              color: Colors.green,
                                              width: 1.5,
                                            ),
                                          )
                                        : null,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: ListTile(
                                        leading: GestureDetector(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppColors.ACCENT_COLOR,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            padding: EdgeInsets.all(2),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                child: imagePath4 != null
                                                    ? Image.file(
                                                        File(imagePath4),
                                                        height: 50,
                                                        width: 50,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.asset(
                                                        'assets/img/take_picture.jpg',
                                                        height: 50)),
                                          ),
                                          onTap: () {
                                            if (imagePath4 != null) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DisplayPictureScreen(
                                                          imagePath:
                                                              imagePath4),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                        title: Text('Photo 4',
                                            style: regularLightTextStyle(
                                                AppColors.PRIMARY_COLOR)),
                                        trailing: GestureDetector(
                                            onTap: () async {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TakePictureScreen(),
                                                ),
                                              ).then((value) {
                                                if (value != null) {
                                                  setState(() {
                                                    imagePath4 = value;
                                                  });
                                                }
                                              });
                                            },
                                            child: Text(
                                                imagePath3 != null
                                                    ? 'Modifier'
                                                    : "Ajouter",
                                                style: mediumLightTextStyle(
                                                    AppColors.PRIMARY_COLOR))),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    shape: imagePath5 != null
                                        ? RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: BorderSide(
                                              color: Colors.green,
                                              width: 1.5,
                                            ),
                                          )
                                        : null,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: ListTile(
                                        leading: GestureDetector(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppColors.ACCENT_COLOR,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            padding: EdgeInsets.all(2),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                child: imagePath5 != null
                                                    ? Image.file(
                                                        File(imagePath5),
                                                        height: 50,
                                                        width: 50,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.asset(
                                                        'assets/img/take_picture.jpg',
                                                        height: 50)),
                                          ),
                                          onTap: () {
                                            if (imagePath5 != null) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DisplayPictureScreen(
                                                            imagePath:
                                                                imagePath5)),
                                              );
                                            }
                                          },
                                        ),
                                        title: Text('Photo 5',
                                            style: regularLightTextStyle(
                                                AppColors.PRIMARY_COLOR)),
                                        trailing: GestureDetector(
                                            onTap: () async {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TakePictureScreen(),
                                                ),
                                              ).then((value) {
                                                if (value != null) {
                                                  setState(() {
                                                    imagePath5 = value;
                                                  });
                                                }
                                              });
                                            },
                                            child: Text(
                                                imagePath5 != null
                                                    ? 'Modifier'
                                                    : "Ajouter",
                                                style: mediumLightTextStyle(
                                                    AppColors.PRIMARY_COLOR))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                    ),
                    AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                              child: child, scale: animation);
                        },
                        child: checkNotice &&
                                    checkExplanation &&
                                    checkSignShipment &&
                                    checkVisitCard &&
                                    imagePath1 != null &&
                                    imagePath2 != null &&
                                    imagePath3 != null &&
                                    imagePath4 != null &&
                                    imagePath5 != null ||
                                1 == 1
                            ? Visibility(
                                maintainState: true,
                                maintainAnimation: true,
                                visible: checkNotice &&
                                    checkExplanation &&
                                    checkSignShipment &&
                                    checkVisitCard &&
                                    imagePath1 != null &&
                                    imagePath2 != null &&
                                    imagePath3 != null &&
                                    imagePath4 != null &&
                                    imagePath5 != null,
                                child: Column(children: [
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Card(
                                    elevation: 4.0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Center(
                                          child: Text(
                                            'Avez vous eu rencontré des difficultés?',
                                            style: mediumBoldTextStyle(
                                                AppColors.PRIMARY_COLOR),
                                          ),
                                        ),
                                        new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Radio(
                                                value: 0,
                                                groupValue: _radioValue1,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _radioValue1 = value;
                                                  });
                                                }),
                                            new Text('Oui',
                                                style: mediumLightTextStyle(
                                                    AppColors.PRIMARY_COLOR)),
                                            new Radio(
                                                value: 1,
                                                groupValue: _radioValue1,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _radioValue1 = value;
                                                  });
                                                }),
                                            new Text('Non',
                                                style: mediumLightTextStyle(
                                                    AppColors.PRIMARY_COLOR)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Card(
                                    elevation: 4.0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Center(
                                          child: Text(
                                            'Questions a définir?',
                                            style: mediumBoldTextStyle(
                                                AppColors.PRIMARY_COLOR),
                                          ),
                                        ),
                                        Center(
                                          child: Text(''),
                                        ),
                                        new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Radio(
                                                value: 0,
                                                groupValue: _radioValue3,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _radioValue3 = value;
                                                  });
                                                }),
                                            new Text('Oui',
                                                style: mediumLightTextStyle(
                                                    AppColors.PRIMARY_COLOR)),
                                            new Radio(
                                                value: 1,
                                                groupValue: _radioValue3,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _radioValue3 = value;
                                                  });
                                                }),
                                            new Text('Non',
                                                style: mediumLightTextStyle(
                                                    AppColors.PRIMARY_COLOR)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Card(
                                    elevation: 4.0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Center(
                                          child: Text(
                                            'Questions a définir?',
                                            style: mediumBoldTextStyle(
                                                AppColors.PRIMARY_COLOR),
                                          ),
                                        ),
                                        new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Radio(
                                                value: 0,
                                                groupValue: _radioValue2,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _radioValue2 = value;
                                                  });
                                                }),
                                            new Text('Oui',
                                                style: mediumLightTextStyle(
                                                    AppColors.PRIMARY_COLOR)),
                                            new Radio(
                                                value: 1,
                                                groupValue: _radioValue2,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _radioValue2 = value;
                                                  });
                                                }),
                                            new Text('Non',
                                                style: mediumLightTextStyle(
                                                    AppColors.PRIMARY_COLOR)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ]))
                            : SizedBox()),
                    SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Center(
                      child: RaisedButton.icon(
                        icon: Icon(Icons.arrow_forward,
                            color: AppColors.PRIMARY_COLOR),
                        label: Text('Valider',
                            style:
                                regularLightTextStyle(AppColors.PRIMARY_COLOR)),
                        shape: buttonMainShape(),
                        color: Colors.white,
                        onPressed: isButtonEnable()
                            ? () async {
                                await UserApi()
                                    .finalizeInstallationRequest(
                                  widget.installationId,
                                  imagePath1,
                                  imagePath2,
                                  imagePath3,
                                  imagePath4,
                                  imagePath5,
                                )
                                    .then((value) {
                                  setState(() {
                                    loading = false;
                                  });
                                  if (value.success) {
                                    print('success');
                                    AppDialogs()
                                        .showResponseDialog(context,
                                            value.message, value.success)
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
                    ),
                    SizedBox(
                      height: 64,
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
