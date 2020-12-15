import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/models/installations_model.dart';
import "package:latlong/latlong.dart" as latLng;

class InstallationDetail extends StatelessWidget {

  final Installation installation;
  const InstallationDetail({Key key, this.installation}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar('Les installateurs'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Début: ${installation.startAt}', style: mediumLightTextStyle(AppColors.PRIMARY_COLOR),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Fin: ${installation.endAt}', style: mediumLightTextStyle(AppColors.PRIMARY_COLOR),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Photos de pré-installation', style: mediumLightTextStyle(AppColors.PRIMARY_COLOR),),
            ),
            SizedBox(height: 8,),
            Row(
              children: [
                ClipRRect(
                  borderRadius:
                  BorderRadius.all(Radius.circular(8)),
                  child: Image.network(
                    installation.preparation[1],
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Colors.orange,
                  width: 1.5,
                ),
              ),
              child: Container(
                height: 250,
                padding: EdgeInsets.all(4),
                width: double.infinity,
                child: FlutterMap(
                  options: new MapOptions(
                    center: latLng.LatLng(double.parse(installation.latitude), double.parse(installation.longitude)),
                    zoom: 13.0,
                  ),
                  layers: [
                    new TileLayerOptions(
                        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c']
                    ),
                    new MarkerLayerOptions(
                      markers: [
                        new Marker(
                          width: 100.0,
                          height: 100.0,
                          point: latLng.LatLng(double.parse(installation.latitude), double.parse(installation.longitude)),
                          builder: (ctx) =>
                          new Container(
                            child: Icon(Icons.add_location_alt_sharp, color: AppColors.PRIMARY_COLOR,),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),

    );
  }
}
