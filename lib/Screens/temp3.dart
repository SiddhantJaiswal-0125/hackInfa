import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:heck/models/logData.dart';

import '../Utility/CustomWidgets.dart';

class BarChartSample2 extends StatefulWidget {
  BarChartSample2({super.key, required this.filteredData});

  final List<LogData> filteredData;
  final Color leftBarColor = Colors.tealAccent;
  final Color rightBarColor = Colors.red;
  final Color avgColor = Colors.orange;

  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final double width = 14;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  late List<LogData> filteredData;
  int touchedGroupIndex = -1;
  double mxY = -1;

  @override
  void initState() {
    filteredData = widget.filteredData;

    List<BarChartGroupData> itm = [];

    for (var i = 0; i < filteredData.length; i++) {
      var y = double.parse(filteredData[i].dataprocessed);
      var y2 = double.parse(filteredData[i].targetSuccessRows);
      print(y2);
      var b1 = makeGroupData(i, y / 10000, y2/10000);
      if (mxY < y) mxY = y;

      itm.add(b1);
    }

    super.initState();

    print("ITM LENGTH ");
    print(itm.length);
    rawBarGroups = itm.sublist(0, 5);
    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff203857),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CustomWidgets().logo(),
            const SizedBox(
              height: 38,
            ),
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: 2000,
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        interval: 1,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: showingBarGroups,
                  gridData: FlGridData(show: true),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      // color: Color(0xff7589a2),
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 100) {
      text = '1K';
    } else if (value == 450) {
      text = '5K';
    } else if (value == 1000) {
      text = '10K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {

    List<String> titles = [];
    for(LogData li in filteredData)
        titles.add(li.date);

    final Widget text = Text(
        titles[value.toInt()].substring(0, 13 ),
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: widget.rightBarColor,
          width: width,
        ),
      ],
    );
  }
}

//wf_mtt_0013E40Z00000000030B
