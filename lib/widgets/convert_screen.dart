import 'package:currency_exchange/provider/base_provider.dart';
import 'package:currency_exchange/provider/rates_provider.dart';
import 'package:currency_exchange/widgets/convert_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConvertScreen extends StatefulWidget {
  final Function changedDropDownItem1;
  final String currentCurrency1;
  final Function changedDropDownItem2;
  final String currentCurrency2;
  int theNumber;
  Function getNumber;

  ConvertScreen(
    this.changedDropDownItem1,
    this.currentCurrency1,
    this.changedDropDownItem2,
    this.currentCurrency2,
    this.theNumber,
    this.getNumber,
  );
  @override
  _ConvertScreenState createState() => _ConvertScreenState();
}

class _ConvertScreenState extends State<ConvertScreen>
    with AutomaticKeepAliveClientMixin<ConvertScreen> {
  @override
  bool get wantKeepAlive => true;

  TextEditingController _rates = TextEditingController();
  TextEditingController _base = TextEditingController();
  var thevalue;

  bool realChange = false;
  double baseValue = 0.0;
  double ratesValue = 0.0;
  bool swapPosition = false;

  swap() {
    setState(() {
      swapPosition = !swapPosition;
    });
  }

  getIt() {
    setState(() {
      if (widget.currentCurrency1 == null) {
        thevalue = '0.00';
      } else {
        thevalue = '1';
      }
      return thevalue;
    });
  }

  @override
  void initState() {
    Provider.of<Rates>(
      context,
      listen: false,
    ).getRates();
    Provider.of<Rates>(
      context,
      listen: false,
    ).getFullNameCurrency();
    Provider.of<Base>(
      context,
      listen: false,
    ).getBase().then((value) {
      setState(() {
        realChange = true;
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
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            height: 350,
            width: 380,
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.swap_horiz,
                            size: 35,
                          ),
                          onPressed: () => swap(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: realChange == false
                              ? Text('Loading...')
                              : Text(
                                  'Latest change ${baseList[0].time.toString().substring(11, 16)}'),
                        ),
                      ],
                    ),
                  ),
                  realChange == false
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                            left: 18.0,
                            bottom: 18.0,
                            right: 18.0,
                          ),
                          child: ConvertForm(
                            base: _base,
                            baseList: baseList,
                            baseValue: baseValue,
                            changedDropDownItem1: widget.changedDropDownItem1,
                            changedDropDownItem2: widget.changedDropDownItem2,
                            currentCurrency1: widget.currentCurrency1,
                            currentCurrency2: widget.currentCurrency2,
                            getNumber: widget.getNumber,
                            listFullNameCurrency: listFullNameCurrency,
                            listRates: listRates,
                            rates: _rates,
                            ratesValue: ratesValue,
                            theNumber: widget.theNumber,
                            swapPosition: swapPosition,
                          ),
                        ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    width: double.infinity,
                    height: 30,
                    child: Center(
                      child: widget.currentCurrency2 == null ||
                              widget.currentCurrency1 == null
                          ? Text('')
                          : Text(
                              ' 1\$ = ${double.parse(widget.currentCurrency2).toStringAsFixed(2)} ${listRates[widget.theNumber].name}',
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
