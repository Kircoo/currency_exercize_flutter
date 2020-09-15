import 'package:currency_exchange/provider/base_provider.dart';
import 'package:currency_exchange/provider/rates_provider.dart';
import 'package:currency_exchange/widgets/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Rates(),
        ),
        ChangeNotifierProvider.value(
          value: Base(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF876796),
        accentColor: Colors.yellow[800],
      ),
      home: Home(),
      routes: {
        TabScreen.routeName: (ctx) => TabScreen(),
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return TabScreen();
  }
}
