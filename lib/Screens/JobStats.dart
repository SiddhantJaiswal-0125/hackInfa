import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:heck/Screens/temp3.dart';

import 'package:heck/models/logData.dart';

class JobStat extends StatefulWidget {
  JobStat({Key? key, required this.jobId, required this.data})
      : super(key: key);
  final String jobId;
  var data;

  @override
  State<JobStat> createState() => _JobStatState();
}

class _JobStatState extends State<JobStat> {
  late String id;
  var data;

  @override
  void initState() {
    id = widget.jobId;
    data = widget.data;
    // TODO: implement initState
    fetchDataforId();
    super.initState();
  }

  List<LogData> filteredData = [];

  fetchDataforId() {
    print(data[0]);

    for (var dt in data) {
      if (dt['jobName'] == id) {
        LogData li = LogData(dt['jobName'], dt['startTime'], dt['endTime'],
            dt['duration'], dt['dataProcessed'], dt['status'], dt['date']);

        filteredData.add(li);
      }
    }

    print(filteredData.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff203857),
      appBar: AppBar(
        title: Text(id),
      ),
      // body: Temp2(filteredData: filteredData,),
      body: BarChartSample2(
        // filteredData: filteredData,
      ),
    );
  }
}

// wf_mtt_0013E40Z000000000329
