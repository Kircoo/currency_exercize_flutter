import 'dart:convert';

import 'package:currency_exchange/model/rates_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Rates with ChangeNotifier {
  List<RatesModel> _ratesModel = [];
  List<String> _fullNameCurrency = [];

  List<String> get fullNameCurrency {
    return [..._fullNameCurrency];
  }

  List<RatesModel> get ratesModel {
    return [..._ratesModel];
  }

  Future<void> getFullNameCurrency() async {
    final url = 'https://openexchangerates.org/api/currencies.json';

    final response = await http.get(url);
    final extractedDataCurrency =
        json.decode(response.body) as Map<String, dynamic>;

    final List<String> theCurrency = [];

    if (extractedDataCurrency == null) {
      return;
    }

    extractedDataCurrency.forEach((key, value) {
      theCurrency.add(value);
    });

    _fullNameCurrency = theCurrency;

    // _fullNameCurrency.forEach((element) {
    //   print(element);
    // });
    notifyListeners();
  }

  Future<void> getRates() async {
    final url =
        'https://openexchangerates.org/api/latest.json?app_id=8e49d41614234665a7fdf150a891139e';

    final response = await http.get(url);
    final extractedDataRates =
        json.decode(response.body)['rates'] as Map<String, dynamic>;

    final List<RatesModel> theRatesModel = [];

    if (extractedDataRates == null) {
      return;
    }

    extractedDataRates.forEach((key, value) {
      theRatesModel.add(
        RatesModel(
          name: key.toString(),
          number: value.toString(),
        ),
      );
    });

    _ratesModel = theRatesModel;
    // _ratesModel.forEach((element) {
    //   print(element.name);
    // });
    notifyListeners();
  }
}
