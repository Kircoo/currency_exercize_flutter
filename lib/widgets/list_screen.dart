import 'package:currency_exchange/provider/base_provider.dart';
import 'package:currency_exchange/provider/rates_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatefulWidget {
  final String currentCurrency1;

  ListScreen(
    this.currentCurrency1,
  );

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen>
    with AutomaticKeepAliveClientMixin<ListScreen> {
  @override
  bool get wantKeepAlive => true;
  bool listChange = false;

  theDialog(
    List listRates,
    List listFullNameCurrency,
    int index,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Back',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              listRates[index].name,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              listFullNameCurrency[index],
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        content: ListTile(
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Value: ${double.parse(listRates[index].number).toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          trailing: Icon(Icons.money, size: 30,),
        ),
      ),
    );
  }

  @override
  void initState() {
    Provider.of<Base>(
      context,
      listen: false,
    ).getBase().then((value) {
      setState(() {
        listChange = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final listRates = Provider.of<Rates>(context, listen: false).ratesModel;
    final listFullNameCurrency =
        Provider.of<Rates>(context, listen: false).fullNameCurrency;
    final baseList = Provider.of<Base>(context, listen: false).base;
    return Container(
      color: Colors.grey[200],
      child: Column(
        children: [
          Container(
            height: 40,
            width: double.infinity,
            color: Theme.of(context).accentColor,
            child: Center(
              child: listChange == false
                  ? Text('Loading...')
                  : Text(
                      'Latest change ${baseList[0].time.toString().substring(11, 16)}',
                    ),
            ),
          ),
          widget.currentCurrency1 == null
              ? Expanded(
                  child: Center(
                    child: Text('No currency selected'),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemBuilder: (ctx, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => theDialog(
                          listRates,
                          listFullNameCurrency,
                          index,
                        ),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            side: BorderSide(
                              width: 0.5,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          shadowColor: Theme.of(context).accentColor,
                          child: ListTile(
                            leading: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  listRates[index].name,
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  listFullNameCurrency[index],
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                    'Value: ${double.parse(listRates[index].number).toStringAsFixed(2)}'),
                              ],
                            ),
                            trailing: Icon(Icons.money),
                          ),
                        ),
                      ),
                    ),
                    itemCount: listRates.length,
                  ),
                )
        ],
      ),
    );
  }
}
