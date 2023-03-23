import 'dart:io';
import 'dart:convert';

import 'package:flutter/services.dart';

class FetchData
{
  var data;
  Future<Set> getData() async {
    String path = "lib/dataFeed.json";
    String response = await rootBundle.loadString(path);
     data = await json.decode(response);
    Set<String> st = Set();
    for(var dt in data)
      st.add(dt['jobName']);


    print('RETURNED ST');
    print(st);
    return st;
  }

}