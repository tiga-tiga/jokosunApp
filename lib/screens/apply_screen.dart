import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/models/offers_model.dart';
import 'package:jokosun/models/technician_model.dart';
import 'package:jokosun/network/admin_api.dart';
import 'package:jokosun/screens/compose_team_screen.dart';
import 'package:jokosun/utils/app_dialogs.dart';
import 'package:jokosun/utils/app_format.dart';

class ApplyScreen extends StatefulWidget {
  static const routeName = '/applyScreen';

  @override
  _ApplyScreenState createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  bool cgvAccepted = false;
  bool loading = false;

  List<Technician> selectedTechnicians = [];

  @override
  Widget build(BuildContext context) {
    final Offer offer = ModalRoute.of(context).settings.arguments;
    return  loading? Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: AppColors.PRIMARY_COLOR,
          valueColor: new AlwaysStoppedAnimation<Color>(AppColors.ACCENT_COLOR),
        ),
      ),
    ): Scaffold(
      backgroundColor: Colors.white,
      appBar: mainAppBar('Postuler'),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
               Text(
                    'Prévu le ${offer.commissioningDate}',
                    style: regularBoldTextStyle(AppColors.PRIMARY_COLOR),
                  ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '${offer.city}',
                  style: regularLightTextStyle(AppColors.PRIMARY_COLOR),
                ),
                SizedBox(
                  height: 8,
                ),Text(
                    'Kit ${offer.kit.id}',
                    style: regularLightTextStyle(AppColors.PRIMARY_COLOR),
                  ),Text(
                    'Catégorie ${offer.kit.id}',
                    style: regularLightTextStyle(AppColors.PRIMARY_COLOR),
                  ),

                SizedBox(
                  height: 8,
                ),Text(
                    'Nécessite ${offer.technicians} installateurs',
                    style: regularLightTextStyle(AppColors.PRIMARY_COLOR),
                  ),

                SizedBox(
                  height: 14,
                ),
                Center(
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: AppColors.ACCENT_COLOR,
                          width: 1.0,
                        ),
                      ),
                      width: 130,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: FadeInImage.assetNetwork(
                              placeholder: 'assets/img/equipmentSolar.jpg',
                              image: '${offer.kit.sheet}'))),
                ),
                SizedBox(
                  height: 16,
                ),Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Rémunération proposée',
                      textAlign: TextAlign.left,
                      style: regularLightTextStyle(AppColors.PRIMARY_COLOR),
                    ),
                ),

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Colors.orange,
                      width: 1.5,
                    ),
                  ),
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Forfait',
                          style: regularLightTextStyle(AppColors.PRIMARY_COLOR),
                        ),
                        Text(
                          '${formatCurrency(int.parse(offer.flatRate))}Fcfa',
                          style: mediumLightTextStyle(AppColors.PRIMARY_COLOR),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Bonus',
                          style: regularLightTextStyle(AppColors.PRIMARY_COLOR),
                        ),
                        Text(
                          '80 points',
                          style: mediumLightTextStyle(AppColors.PRIMARY_COLOR),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Transport',
                          style: regularLightTextStyle(AppColors.PRIMARY_COLOR),
                        ),
                        Text(
                          '${formatCurrency(int.parse(offer.removalAndTransport))}Fcfa',
                          style: mediumLightTextStyle(AppColors.PRIMARY_COLOR),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Composeteam.routeName)
                          .then((value) {
                        if (value != null) {
                          setState(() {
                            selectedTechnicians = value;
                          });
                        }
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Composer votre équipe',
                            textAlign: TextAlign.left,
                            style:
                                regularLightTextStyle(AppColors.PRIMARY_COLOR)),
                        selectedTechnicians.isNotEmpty
                            ? Badge(
                                position: BadgePosition.topEnd(top: 0, end: 3),
                                animationDuration: Duration(milliseconds: 300),
                                animationType: BadgeAnimationType.slide,
                                badgeContent: Text(
                                  selectedTechnicians.length.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: AppColors.PRIMARY_COLOR,
                                  ),
                                ))
                            : Icon(
                                Icons.add,
                                color: AppColors.PRIMARY_COLOR,
                              ),
                      ],
                    ),
                  ),
                ),


                SizedBox(
                  height: 8,
                ),
                Text(
                  selectedTechnicians.isNotEmpty
                      ? selectedTechnicians
                          .map((e) => e.name)
                          .toList()
                          .join(', ')
                      : '',
                  style: mediumLightTextStyle(AppColors.PRIMARY_COLOR),
                ),
                Text(
                  selectedTechnicians.isNotEmpty && selectedTechnicians.length != offer.technicians
                      ?  '${offer.technicians} techniciens nécessaires'
                      : '',
                  style: mediumLightTextStyle(Colors.red),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Checkbox(
                        value: cgvAccepted,
                        // value: monVal,
                        onChanged: (bool value) {
                          setState(() {
                            cgvAccepted = value;
                          });
                        },
                        activeColor: AppColors.PRIMARY_COLOR,
                      ),
                      RichText(
                        text: TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.black87),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Accepter les ',
                                style: regularLightTextStyle(Colors.black87)),
                            TextSpan(
                                text: 'CGU',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                    decoration: TextDecoration.underline,
                                    color: AppColors.PRIMARY_COLOR)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Center(
                  child: RaisedButton(
                    onPressed: cgvAccepted && selectedTechnicians.length == offer.technicians ? () async {
                      AdminApi adminApi = AdminApi();
                      setState(() {
                        loading   = true;
                      });
                      List<int> technicians = [];
                      for(Technician technician in selectedTechnicians){
                        technicians.add(technician.id);
                      }
                      await adminApi.applyOffer(technicians, offer.id).then((value) {
                        setState(() {
                          loading = false;
                        });
                        print(value.data);
                        if(value.success){
                          AppDialogs().showResponseDialog(context, 'Votre demande est bien enregistré', value.success);
                        } else {

                          AppDialogs().showResponseDialog(context, value.message, value.success);
                        }
                      });
                    } : null,
                    shape: buttonMainShape(),
                    child: Text("Intéressé / Valider",
                        style: mediumBoldTextStyle(AppColors.PRIMARY_COLOR)),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
