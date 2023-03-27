import 'package:flutter/material.dart';
import 'package:heck/models/dtmData.dart';

import '../Utility/CustomWidgets.dart';
import '../Utility/fetchData.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DtmStatus extends StatefulWidget {
  final light;
  const DtmStatus({Key? key, this.light}) : super(key: key);

  @override
  State<DtmStatus> createState() => _DtmStatusState();
}

class _DtmStatusState extends State<DtmStatus> {
  bool wait = true;
  List<DtmData> dtmdata = [];
  late bool light;

  getData() async {
    dtmdata = await FetchData().getDtmData();
    print("+++++_+++++ DTM DATA");
    print(dtmdata[0].date);
    print(dtmdata[0].noOfJobs);
    setState(() {
      wait = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    print("AT DTM STATUS");

    light = widget.light;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return wait ? Center(
      child: CircularProgressIndicator(color: Colors.orange,),) : Scaffold(

      appBar: AppBar(title: Text(""),
      backgroundColor: light ? Colors.orangeAccent : CustomWidgets.backgroundNavyBlue ,),
      body: SingleChildScrollView(


      child: Container(

        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 10,
          ),
          CustomWidgets().logo("DTM",light),
          const SizedBox(
            height: 8,
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
            series: <ChartSeries<DtmData, String>>[
              LineSeries<DtmData, String>(
                dataSource: dtmdata,
                xValueMapper: (DtmData dt, _) => dt.date.substring(0, 10),
                yValueMapper: (DtmData dt, _) => num.parse(dt.noOfJobs),
                name: 'Number of Jobs',
                // Enable data label
                dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
            ],
          ),

          SizedBox(
            height: 45,
          ),
        ],
    ),
      ),
    ),
    );
  }
}
