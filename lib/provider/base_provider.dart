import 'dart:convert';

import 'package:currency_exchange/model/base_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Base with ChangeNotifier {
  List<BaseModel> _base = [];

  List<BaseModel> get base {
    return [..._base];
  }

  Future<void> getBase() async {
    final url =
        'https://openexchangerates.org/api/latest.json?app_id=8e49d41614234665a7fdf150a891139e';

    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = response.body;

      var t = jsonDecode(data)['base'];

      var timeStamp = jsonDecode(data)['timestamp'];
      var date = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);

      final List<BaseModel> theBase = [];

      theBase.add(
        BaseModel(
          time: date,
          base: t,
        ),
      );
      _base = theBase;
    }
    notifyListeners();
  }
}
