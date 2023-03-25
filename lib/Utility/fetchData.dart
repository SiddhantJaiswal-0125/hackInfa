import 'dart:io';
import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/logData.dart';

class FetchData {
  List<LogData> decodekro( var data )  {

    List<LogData> res = [];
    for (var dt in data) {
      if (int.parse(dt['dataProcessed']) > 100 &&
          int.parse(dt['targetSuccessRows']) > 5)
        {
          LogData li = LogData(
            dt['jobName'],
            dt['startTime'],
            dt['endTime'],
            dt['duration'],
            dt['dataProcessed'],
            dt['status'],
            dt['date'],
            dt['targetSuccessRows']);

        res.add(li);

        }
    }


    return res;
  }

  List<LogData> fetchDataforId(String id, var data) {
    List<LogData> filteredData = [];
    for (var dt in data) {
       if (dt['jobName'] == id) {
        LogData li = LogData(
            dt['jobName'],
            dt['startTime'],
            dt['endTime'],
            dt['duration'],
            dt['dataProcessed'],
            dt['status'],
            dt['date'],
            dt['targetSuccessRows']);

        filteredData.add(li);
      }
    }

    print("FILTERED DATA LENGTH");
    print(filteredData.length);

    return filteredData;
  }
}
