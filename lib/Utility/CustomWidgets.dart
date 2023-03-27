import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heck/Screens/DtmStatus.dart';
import 'package:heck/Screens/JobStats.dart';
import '../models/logData.dart';

class CustomWidgets {
  static const Color backgroundNavyBlue = Color(0xff203857);

  Widget dtmWidget(BuildContext context, bool light) {

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DtmStatus( light:light)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.orange,
          boxShadow: [
            BoxShadow(
              blurRadius: 15.0,
            ),
          ],
          border: Border.all(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          "Check your DTM Status",
          style: GoogleFonts.asar(textStyle: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }

  Widget buildSummerCard(LogData li, BuildContext context, var data , bool light) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => JobStat(jobId: li.jobName, data: data,light:light)));
      },
      child: Container(
        color: light ? Colors.white : Colors.blueGrey,

        height: 20,
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Material(
            color: light ? Colors.white : Colors.black54,
            borderRadius: BorderRadius.circular(10),
            elevation: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 10),
                    ),
                     Text(
                      "Job Name : ",
                      style: TextStyle(
                          color: light ? CustomWidgets.backgroundNavyBlue : Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "${li.jobName}",
                      style: TextStyle(color: Colors.orange),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(
                            text: li.jobName,
                          ),
                        );

                        final snak = SnackBar(
                            content: Text(
                                '${li.jobName} is copied to your clipboard'));
                        ScaffoldMessenger.of(context).showSnackBar(snak);
                      },
                      icon: Icon(
                        Icons.copy,
                        size: 15,
                        color: light  ? Colors.black : Colors.tealAccent,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 10),
                    ),
                    Text(
                      "Data Processed : ",
                      style: TextStyle(
                          color: light ? CustomWidgets.backgroundNavyBlue : Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "${li.dataprocessed.toString()}",
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 10),
                    ),
                    Text(
                      "Date: ",
                      style: TextStyle(
                          color: light ? CustomWidgets.backgroundNavyBlue : Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "${li.date.substring(0, 12)}",
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 10,
        ),
        Container(
          width: width,
          height: 10,
          color: CustomWidgets.backgroundNavyBlue.withOpacity(1.0),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: CustomWidgets.backgroundNavyBlue.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: CustomWidgets.backgroundNavyBlue.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: CustomWidgets.backgroundNavyBlue.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: CustomWidgets.backgroundNavyBlue.withOpacity(0.4),
        ),
      ],
    );
  }

  Widget logo(var txt, bool light) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(
          width: 8,
        ),
        Text(
          txt,
          style:
              TextStyle(color: light ?CustomWidgets.backgroundNavyBlue : Colors.tealAccent, fontSize: 28),
        ),
        const SizedBox(
          width: 4,
        ),
         Text(
          'Status',
          style: TextStyle(color: light ?   Color(0xff77839a):Colors.white, fontSize: 24),
        ),
      ],
    );
  }
}
