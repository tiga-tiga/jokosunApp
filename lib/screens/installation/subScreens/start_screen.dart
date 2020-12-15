import 'package:flutter/material.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/network/user_api.dart';

class StartScreen extends StatefulWidget {
  static const routeName = '/startScreen';
  final VoidCallback onFinish;
  final int installationId;

  const StartScreen({Key key, this.onFinish, this.installationId})
      : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool isStarted = false;
  bool loading = false;

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
            appBar: mainAppBar('Installation'),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      !isStarted
                          ? 'Vous êtes sur le point de démarrer \n  l\'installation'
                          : 'Vous allez mettre en route  et \n tester  l\'équipement ',
                      textAlign: TextAlign.center,
                      style: regularLightTextStyle(AppColors.PRIMARY_COLOR),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Center(
                      child: RaisedButton.icon(
                        icon: Icon(Icons.arrow_forward,
                            color: AppColors.PRIMARY_COLOR),
                        label: Text(
                          !isStarted ? 'Démarrer l\'installation ' : 'Test OK',
                          style: regularLightTextStyle(AppColors.PRIMARY_COLOR),
                        ),
                        shape: buttonMainShape(),
                        color: Colors.white,
                        onPressed: () async {
                          if (!isStarted) {
                            await UserApi()
                                .startInstall(widget.installationId)
                                .then((value) {
                              setState(() {
                                loading = false;
                              });
                              if (value.success) {
                                setState(() {
                                  isStarted = true;
                                });
                              } else {}
                            });
                          }else{
                            widget.onFinish();
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
