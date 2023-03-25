import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:heck/Screens/temp3.dart';
import 'package:heck/Screens/temp4.dart';

import 'package:heck/models/logData.dart';

import '../Utility/fetchData.dart';

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
  List<LogData> filteredData = [];
  @override
  void initState() {
    id = widget.jobId;
    data = widget.data;
    // TODO: implement initState
   filteredData=  FetchData().fetchDataforId(id, data);

   if(filteredData != null) {
     print("filtered data is not null");
     print("DATA PROCESSED");
    print(filteredData[0].dataprocessed);
   }
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(id),
      ),
      // body: Temp2(filteredData: filteredData,),
      // body: BarChartSample2(
      //   filteredData: filteredData,
      // ),
      body: temp4(filteredData: filteredData,),

      );
  }
}

// wf_mtt_0013E40Z00000000030B
