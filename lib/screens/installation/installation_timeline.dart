import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jokosun/constants/app_colors.dart';
import 'package:jokosun/constants/app_style.dart';
import 'package:jokosun/models/installations_model.dart';
import 'package:jokosun/screens/installation/subScreens/finalize_install_screen.dart';
import 'package:jokosun/screens/installation/subScreens/inventory_screen.dart';
import 'package:jokosun/screens/installation/subScreens/start_screen.dart';

class InstallationTimeline extends StatefulWidget {
  static const routeName = '/installationTimelineScreen';

  final Installation installation;

  const InstallationTimeline({Key key, this.installation});

  @override
  _InstallationTimelineState createState() => _InstallationTimelineState();
}

class _InstallationTimelineState extends State<InstallationTimeline> {
  SwiperController _controller = SwiperController();
  int _currentIndex = 0;
  final List<int> titles = [
    1,
    2,
    3,
  ];

  final List<Color> colors = [
    Colors.green.shade300,
    Colors.blue.shade300,
    Colors.indigo.shade300,
  ];

  @override
  void initState() {
    super.initState();
    switch (widget.installation.status) {
      case 'CHECKLIST':
        _currentIndex = 0;
        break;
      case 'PREPARED':
        _currentIndex = 1;
        break;
      case 'BEGIN':
        _currentIndex = 2;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Swiper(
            loop: false,
            index: _currentIndex,
            physics: NeverScrollableScrollPhysics(),
            onIndexChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            controller: _controller,
            pagination: SwiperPagination(
              margin: EdgeInsets.all(48),
              builder: DotSwiperPaginationBuilder(
                  activeColor: AppColors.PRIMARY_COLOR,
                  color: Colors.grey,
                  activeSize: 14.0,
                  space: 8,
                  size: 8),
            ),
            itemCount: titles.length,
            itemBuilder: (context, index) {
              switch (titles[index]) {
                case 1:
                  {
                    return InventoryScreen(
                      installationId: widget.installation.id,
                      onFinish: () {
                        if (_currentIndex != 2)
                          _controller.next();
                        else
                          Navigator.pop(context);
                      },
                    );
                  }
                  break;

                case 2:
                  {
                    return StartScreen(
                      installationId: widget.installation.id,
                      onFinish: () {
                        if (_currentIndex != 2)
                          _controller.next();
                        else
                          Navigator.pop(context);
                      },
                    );
                  }
                  break;

                case 3:
                  {
                    return FinalizeInstallScreen(
                      installationId: widget.installation.id,
                      onFinish: () {
                        print(_currentIndex);
                        Navigator.pop(context);
                      },
                    );
                  }
                  break;

                default:
                  {
                    return IntroItem(
                      title: titles[index],
                      bg: colors[index],
                      //imageUrl: introIllus[index],
                    );
                  }
                  break;
              }
            },
          ),
//          Align(
//            alignment: Alignment.bottomCenter,
//            child: Padding(
//              padding: const EdgeInsets.all(100.0),
//              child: IconButton(
//                icon: Icon(
//                    _currentIndex == 2 ? Icons.check : Icons.arrow_forward),
//                onPressed: () {
//                  if (_currentIndex != 2)
//                    _controller.next();
//                  else
//                    Navigator.pop(context);
//                },
//              ),
//            ),
//          )
        ],
      ),
    );
  }
}

class IntroItem extends StatelessWidget {
  final int title;
  final String subtitle;
  final Color bg;
  final String imageUrl;

  const IntroItem(
      {Key key, @required this.title, this.subtitle, this.bg, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar('title'),
      body: Container(
        color: bg ?? Theme.of(context).primaryColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 40),
                Text(
                  '$title',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                      color: Colors.white),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 20.0),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.white, fontSize: 24.0),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 40.0),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 70),
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Material(
                        elevation: 4.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
