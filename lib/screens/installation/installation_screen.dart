import 'package:flutter/material.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/constants/app_text.dart';
import 'package:jokosun/models/installations_model.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'installation_timeline.dart';

class InstallationScreen extends StatefulWidget {
  static const routeName = '/installationScreen';
  final Installation installation;

  const InstallationScreen({this.installation});

  @override
  _InstallationScreenState createState() => _InstallationScreenState();
}

class _InstallationScreenState extends State<InstallationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar('Installation N°${widget.installation.id}'),
      body: Container(
        padding: EdgeInsets.all(8),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.1,
              isFirst: true,
              indicatorStyle: IndicatorStyle(
                  width: 25,
                  color: widget.installation.status == 'CHECKLIST'
                      ? AppColors.PRIMARY_COLOR
                      : Colors.green,
                  padding: EdgeInsets.all(6),
                  iconStyle: IconStyle(
                      iconData: Icons.remove_red_eye, color: Colors.white)),
              endChild: _RightChild(
                buildContext: context,
                installation: widget.installation,
                title: 'Etat des lieux ',
                message: 'Commencer',
                disabled: false,
                finished: widget.installation.status != 'CHECKLIST',
              ),
              beforeLineStyle: LineStyle(
                  color: widget.installation.status == 'CHECKLIST'
                      ? AppColors.PRIMARY_COLOR
                      : Colors.green,
                  thickness: 2),
            ),
            TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.1,
              indicatorStyle: IndicatorStyle(
                  width: 25,
                  color: widget.installation.status == 'PREPARED'
                      ? AppColors.PRIMARY_COLOR
                      : widget.installation.status == 'BEGIN'
                      || widget.installation.status == 'FINISHED'
                          ? Colors.green
                          : Colors.grey,
                  padding: EdgeInsets.all(6),
                  iconStyle: IconStyle(
                      iconData: Icons.play_circle_filled, color: Colors.white)),
              endChild: _RightChild(
                installation: widget.installation,
                buildContext: context,
                title: 'Commencer l\'installation',
                message: 'Continuer',
                disabled: widget.installation.status == 'CHECKLIST',
                finished: widget.installation.status == 'BEGIN' || widget.installation.status == 'FINISHED',
              ),
              beforeLineStyle: LineStyle(
                  color: widget.installation.status == 'PREPARED'
                      ? AppColors.PRIMARY_COLOR
                      : widget.installation.status == 'BEGIN'
                      || widget.installation.status == 'FINISHED'
                          ? Colors.green
                          : Colors.grey,
                  thickness: 2),
            ),
            TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.1,
              indicatorStyle: IndicatorStyle(
                  width: 25,
                  color: widget.installation.status == 'BEGIN'
                      ? AppColors.PRIMARY_COLOR
                      : widget.installation.status == 'CHECKLIST' ||
                              widget.installation.status == 'PREPARED'
                          ? Colors.grey
                          : Colors.green,
                  padding: EdgeInsets.all(6),
                  iconStyle: IconStyle(
                      iconData: Icons.arrow_forward_ios, color: Colors.white)),
              endChild: _RightChild(
                installation: widget.installation,
                buildContext: context,
                title: 'Finaliser l\'installation',
                message: 'Terminer',
                disabled: widget.installation.status == 'CHECKLIST' ||
                    widget.installation.status == 'PREPARED',
                finished: widget.installation.status == 'FINISHED',
              ),
              beforeLineStyle: LineStyle(
                  color: widget.installation.status == 'BEGIN'
                      ? AppColors.PRIMARY_COLOR
                      : widget.installation.status == 'CHECKLIST' ||
                              widget.installation.status == 'PREPARED'
                          ? Colors.grey
                          : Colors.green,
                  thickness: 2),
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _RightChild extends StatelessWidget {
  const _RightChild({
    Key key,
    this.title,
    this.message,
    this.installation,
    this.buildContext,
    this.disabled = false,
    this.finished = false,
  }) : super(key: key);

  final String title;
  final String message;
  final bool disabled;
  final bool finished;
  final Installation installation;
  final BuildContext buildContext;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: regularLightTextStyle(!disabled && !finished
                    ? AppColors.PRIMARY_COLOR
                    : !disabled && finished
                        ? Colors.green
                        : Colors.grey),
                textAlign: TextAlign.start,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  !disabled && !finished
                      ? RaisedButton.icon(
                          onPressed: () {
                            Navigator.of(buildContext).push(MaterialPageRoute(
                                builder: (context) =>
                                    InstallationTimeline(
                                      installation: installation
                                    ))).then((value) {
                                      Navigator.of(buildContext).pop();
                            });
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: AppColors.PRIMARY_COLOR)),
                          color: Colors.white,
                          icon: Icon(Icons.play_circle_filled,
                              color: AppColors.PRIMARY_COLOR),
                          label: Text(
                            message,
                            style:
                                mediumLightTextStyle(AppColors.PRIMARY_COLOR),
                            textAlign: TextAlign.start,
                          ),
                        )
                      : !disabled && finished
                          ? Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 20,
                                ),
                                Text(
                                  'Terminé',
                                  style: mediumLightTextStyle(Colors.green),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Icon(
                                  Icons.lock_clock,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                Text(
                                  'En attente',
                                  style: mediumLightTextStyle(Colors.grey),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
