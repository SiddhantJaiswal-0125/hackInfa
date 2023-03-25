import 'package:flutter/material.dart';
import 'package:heck/Utility/CustomWidgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:heck/models/logData.dart';

class temp4 extends StatefulWidget {
  const temp4({Key? key, required this.filteredData}) : super(key: key);

  final List<LogData> filteredData;

  @override
  State<temp4> createState() => _temp4State();
}

class _temp4State extends State<temp4> {
  late List<LogData> data;

  @override
  void initState() {
    data = widget.filteredData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: CustomWidgets.backgroundNavyBlue,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 10,
          ),
          CustomWidgets().logo("Execution"),
          const SizedBox(
            height: 28,
          ),
          //Initialize the chart widget
          SfCartesianChart(
            borderColor: Colors.red,

            primaryXAxis: CategoryAxis(),
            // Chart title

            // Enable legend
            legend: Legend(isVisible: true),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<LogData, String>>[
              LineSeries<LogData, String>(
                dataSource: data,
                xValueMapper: (LogData dt, _) => dt.date.substring(0, 12),
                yValueMapper: (LogData dt, _) => num.parse(dt.dataprocessed),
                name: 'Processed Data',
                // Enable data label
                dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
            ],
          ),

          SizedBox(
            height: 30,
          ),


          CustomWidgets().logo("Success"),
          SizedBox(height: 20,),

          SfCartesianChart(
            borderColor: Colors.green,
            palette: [Colors.orangeAccent],

            primaryXAxis: CategoryAxis(),
            // Chart title
            plotAreaBackgroundColor : Colors.grey,
            plotAreaBorderColor :Colors.black,
            // Enable legend
            legend: Legend(isVisible: true,),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<LogData, String>>[
              LineSeries<LogData, String>(
                dataSource: data,
                xValueMapper: (LogData dt, _) => dt.date.substring(0, 12),
                yValueMapper: (LogData dt, _) => num.parse(dt.targetSuccessRows),
                name: 'Success Rows',
                // Enable data label
                dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// wf_mtt_0013E40Z0000000003G5
