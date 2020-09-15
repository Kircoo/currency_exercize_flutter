import 'package:currency_exchange/widgets/convert_screen.dart';
import 'package:currency_exchange/widgets/list_screen.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  static const routeName = '/tabsScreen';

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  String _currentCurrency1;
  String _currentCurrency2;
  int theNumber;

  getNumber(int index) {
    setState(() {
      theNumber = index;
    });
  }

  void changedDropDownItem1(String selectedCurrency) {
    setState(() {
      _currentCurrency1 = selectedCurrency;
    });
  }

  void changedDropDownItem2(String selectedCurrency) {
    setState(() {
      _currentCurrency2 = selectedCurrency;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text('CURRENCY ASSISTANT'),
            bottom: TabBar(
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Colors.white),
              tabs: [
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Converter'),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('List'),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ConvertScreen(
                changedDropDownItem1,
                _currentCurrency1,
                changedDropDownItem2,
                _currentCurrency2,
                theNumber,
                getNumber,
              ),
              ListScreen(
                _currentCurrency1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
