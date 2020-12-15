
import 'package:flutter/material.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/models/kit_model.dart';

class KitDetail extends StatefulWidget {
  static final String routeName = "/kitDetail";
  final Kit kit;

  const KitDetail({Key key, this.kit}) : super(key: key);

  @override
  _KitDetailState createState() => _KitDetailState();
}

class _KitDetailState extends State<KitDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar('Détails Kit'),
      body: _buildPageContent(),
    );
  }

  Widget _buildPageContent() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: <Widget>[
                Container(
                  height: 320,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.kit.sheet), fit: BoxFit.cover)),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "${widget.kit.price} Fcfa",
                      style: TextStyle(
                          color: AppColors.PRIMARY_COLOR,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  widget.kit.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  widget.kit.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600),
                ),

              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[

            ],
          )
        ],
      ),
    );
  }
}