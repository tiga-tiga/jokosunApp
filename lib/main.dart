import 'package:flutter/material.dart';
import 'package:jokosun/providers/user.dart';
import 'package:jokosun/screens/add_team_screen.dart';
import 'package:jokosun/screens/admin/admin_companies_screen.dart';
import 'package:jokosun/screens/admin/admin_create_offer_screen.dart';
import 'package:jokosun/screens/admin/admin_installations.dart';
import 'package:jokosun/screens/admin/admin_offers_screen.dart';
import 'package:jokosun/screens/admin/admin_screen.dart';
import 'package:jokosun/screens/apply_screen.dart';
import 'package:jokosun/screens/auth_screen.dart';
import 'package:jokosun/screens/client_suggest.dart';
import 'package:jokosun/screens/compose_team_screen.dart';
import 'package:jokosun/screens/dash_board.dart';
import 'package:jokosun/screens/edit_company_screen.dart';
import 'package:jokosun/screens/history_screen.dart';
import 'package:jokosun/screens/installation/installation_screen.dart';
import 'package:jokosun/screens/installation/installation_timeline.dart';
import 'package:jokosun/screens/installation/subScreens/inventory_screen.dart';
import 'package:jokosun/screens/my_company_screen.dart';
import 'package:jokosun/screens/my_team_screen.dart';
import 'package:jokosun/screens/news_screen.dart';
import 'package:jokosun/screens/pending_installs.dart';
import 'package:jokosun/screens/profile/bank_details.dart';
import 'package:jokosun/screens/profile/kit_detail.dart';
import 'package:jokosun/screens/profile/my_contracts.dart';
import 'package:jokosun/screens/profile/my_kits_screen.dart';
import 'package:jokosun/screens/profile/profile.dart';
import 'package:jokosun/screens/search_install.dart';
import 'package:jokosun/screens/technical_sheet_screen.dart';
import 'package:jokosun/screens/shop_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthScreen(),
        routes: {
          ClientSuggest.routeName: (ctx) => ClientSuggest(),
          DashBoard.routeName: (ctx) => DashBoard(),
          AdminScreen.routeName: (ctx) => AdminScreen(),
          PendingInstalls.routeName: (ctx) => PendingInstalls(),
          SearchInstall.routeName: (ctx) => SearchInstall(),
          Profile.routeName: (ctx) => Profile(),
          BankDetails.routeName: (ctx) => BankDetails(),
          MyContracts.routeName: (ctx) => MyContracts(),
          ApplyScreen.routeName: (ctx) => ApplyScreen(),
          TechnicalSheetScreen.routeName: (ctx) => TechnicalSheetScreen(),
          InstallationScreen.routeName: (ctx) => InstallationScreen(),
          MyCompanyScreen.routeName: (ctx) => MyCompanyScreen(),
          MyTeam.routeName: (ctx) => MyTeam(),
          AddTeam.routeName: (ctx) => AddTeam(),
          EditCompany.routeName: (ctx) => EditCompany(),
          InventoryScreen.routeName: (ctx) => InventoryScreen(),
          InstallationTimeline.routeName: (ctx) => InstallationTimeline(),
          HistoryScreen.routeName: (ctx) => HistoryScreen(),
          ShopScreen.routeName: (ctx) => ShopScreen(),
          NewsScreen.routeName: (ctx) => NewsScreen(),
          MyKits.routeName: (ctx) => MyKits(),
          KitDetail.routeName: (ctx) => KitDetail(),
          Composeteam.routeName: (ctx) => Composeteam(),
          AdminOffers.routeName: (ctx) => AdminOffers(),
          AdminCreateOffer.routeName: (ctx) => AdminCreateOffer(),
          AdminInstallations.routeName: (ctx) => AdminInstallations(),
          AdminCompaniesScreen.routeName: (ctx) => AdminCompaniesScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
