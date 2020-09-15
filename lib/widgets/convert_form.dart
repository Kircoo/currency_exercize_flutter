import 'package:flutter/material.dart';

class ConvertForm extends StatefulWidget {
  String currentCurrency1;
  List baseList;
  Function changedDropDownItem1;
  String currentCurrency2;
  TextEditingController base;
  double baseValue;
  double ratesValue;
  TextEditingController rates;
  List listRates;
  Function getNumber;
  Function changedDropDownItem2;
  int theNumber;
  List listFullNameCurrency;
  bool swapPosition;

  ConvertForm({
    this.currentCurrency1,
    this.baseList,
    this.changedDropDownItem1,
    this.currentCurrency2,
    this.base,
    this.baseValue,
    this.ratesValue,
    this.rates,
    this.listRates,
    this.getNumber,
    this.changedDropDownItem2,
    this.theNumber,
    this.listFullNameCurrency,
    this.swapPosition,
  });

  @override
  _ConvertFormState createState() => _ConvertFormState();
}

class _ConvertFormState extends State<ConvertForm> {
  Widget _column1() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            child: DropdownButton(
              value: widget.currentCurrency1,
              items: List<DropdownMenuItem<String>>.generate(
                widget.baseList.length,
                (index) => DropdownMenuItem(
                  value: widget.baseList[0].base,
                  child: Text(widget.baseList[0].base),
                ),
              ),
              onChanged: widget.changedDropDownItem1,
            ),
          ),
          widget.currentCurrency1 == null
              ? Text('')
              : Text(
                  'American Dollar',
                  style: TextStyle(fontSize: 10),
                ),
          Container(
            width: double.infinity,
            child: TextFormField(
              controller: widget.currentCurrency2 == null ||
                      widget.currentCurrency1 == null
                  ? TextEditingController(text: '')
                  : widget.base,
              onChanged: (value) {
                setState(() {
                  widget.baseValue = double.parse(value);
                  widget.ratesValue =
                      widget.baseValue * double.parse(widget.currentCurrency2);
                  widget.rates.text = widget.ratesValue.toStringAsFixed(2);
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: widget.currentCurrency1 == null ? '0.00' : '1'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _column2() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            child: DropdownButton(
              value: widget.currentCurrency2,
              items: List<DropdownMenuItem<String>>.generate(
                widget.listRates.length,
                (index) => DropdownMenuItem(
                  onTap: () {
                    widget.getNumber(index);
                    setState(() {
                      widget.rates.text = '';
                      widget.base.text = '';
                    });
                  },
                  value: widget.listRates[index].number,
                  child: Text(widget.listRates[index].name),
                ),
              ),
              onChanged: widget.changedDropDownItem2,
            ),
          ),
          widget.theNumber == null
              ? Text('')
              : Text(
                  widget.listFullNameCurrency[widget.theNumber],
                  style: TextStyle(fontSize: 10),
                ),
          Container(
            width: double.infinity,
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  widget.ratesValue = double.parse(value);
                  widget.baseValue =
                      widget.ratesValue / double.parse(widget.currentCurrency2);
                  widget.base.text = widget.baseValue.toStringAsFixed(2);
                });
              },
              controller: widget.currentCurrency2 == null ||
                      widget.currentCurrency1 == null
                  ? TextEditingController(text: '')
                  : widget.rates,
              decoration: InputDecoration(
                hintText: widget.currentCurrency2 == null ||
                        widget.currentCurrency1 == null
                    ? '0.00'
                    : '${double.parse(widget.currentCurrency2).toStringAsFixed(2)}',
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> columnList = [
      _column1(),
      _column2(),
    ];
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.swapPosition == false
            ? columnList
                .map(
                  (columns) => columns,
                )
                .toList()
            : columnList
                .map(
                  (columns) => columns,
                )
                .toList()
                .reversed
                .toList(),
      ),
    );
  }
}
