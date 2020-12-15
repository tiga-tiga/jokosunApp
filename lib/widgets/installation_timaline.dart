
import 'package:flutter/material.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/models/installations_model.dart';
import 'package:timeline_tile/timeline_tile.dart';
class InstallationTimeLine extends StatelessWidget {
  const InstallationTimeLine({
    Key key,
    @required this.item,
  }) : super(key: key);

  final Installation item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Center(
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: [
            TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.manual,
              lineXY: 0.3,
              isFirst: true,
              indicatorStyle: IndicatorStyle(
                  width: 25,
                  color: item.status == 'PENDING' ? AppColors.PRIMARY_COLOR: Colors.green,
                  padding: EdgeInsets.all(6),
                  iconStyle: IconStyle(
                      iconData:
                      Icons.check,
                      color: Colors.white)),

              endChild: _EndChildDelivery(text:'Checklist',  ),

              beforeLineStyle: item.status == 'PENDING' ?
              const LineStyle(color: AppColors.PRIMARY_COLOR, thickness: 2):
              const LineStyle(color:  Colors.green , thickness: 2),
            ),TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.manual,
              lineXY: 0.3,
              indicatorStyle: IndicatorStyle(
                  width: 25,
                  color: item.status == 'CHECKLIST' ? AppColors.PRIMARY_COLOR: item.status == 'PENDING' ? Colors.grey: Colors.green,
                  padding: EdgeInsets.all(6),
                  iconStyle: IconStyle(
                      iconData:
                      Icons.check,
                      color: Colors.white)),

              endChild: _EndChildDelivery(text:'Etat des lieux',),

              beforeLineStyle: item.status == 'CHECKLIST' ?

              const LineStyle(color: AppColors.PRIMARY_COLOR, thickness: 2):
              item.status == 'PENDING' ?
              const LineStyle(color:  Colors.grey , thickness: 2):
              const LineStyle(color:  Colors.green , thickness: 2),
            ),
            TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.manual,
              lineXY: 0.3,
              //isFirst: true,
              indicatorStyle: IndicatorStyle(
                  width: 25,
                  color: item.status == 'PREPARED' ? AppColors.PRIMARY_COLOR: item.status == 'CHECKLIST' || item.status == 'PENDING' ?  Colors.grey: Colors.green,
                  padding: EdgeInsets.all(6),
                  iconStyle: IconStyle(
                      iconData:
                      Icons.check,
                      color: Colors.white)),

              endChild: _EndChildDelivery(text:'Démarrage', ),

              beforeLineStyle: item.status == 'PREPARED' ?
              const LineStyle(color: AppColors.PRIMARY_COLOR, thickness: 2):
              item.status == 'CHECKLIST' || item.status == 'PENDING' ?
              const LineStyle(color:  Colors.grey , thickness: 2):
              const LineStyle(color:  Colors.green , thickness: 2),
            ),
            TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.manual,
              lineXY: 0.3,
              isLast: true,
              indicatorStyle: IndicatorStyle(
                  width: 0,
                  color: item.status == 'BEGIN' ? AppColors.PRIMARY_COLOR: item.status == 'CHECKLIST' || item.status == 'PENDING' || item.status == 'PREPARED' ?  Colors.grey: Colors.green,
                  padding: EdgeInsets.all(6),
                  iconStyle: IconStyle(
                      iconData:
                      Icons.check,
                      color: Colors.white)),

              endChild: _EndChildDelivery(text:'Finalisation' ),

              beforeLineStyle: item.status == 'BEGIN' ?
              const LineStyle(color: AppColors.PRIMARY_COLOR, thickness: 2):
              item.status == 'CHECKLIST' || item.status == 'PENDING' || item.status == 'PREPARED' ?
              const LineStyle(color:  Colors.grey , thickness: 2):
              const LineStyle(color:  Colors.green , thickness: 2),
            ),

          ],
        ),
      ),
    );
  }
}

class _EndChildDelivery extends StatelessWidget {
  const _EndChildDelivery({
    Key key,
    @required this.text,
    @required this.current,
    @required this.done,
  }) : super(key: key);

  final String text;
  final bool current;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 70),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: smallLightTextStyle(AppColors.PRIMARY_COLOR)
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

