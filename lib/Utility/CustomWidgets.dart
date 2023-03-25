import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heck/Screens/JobStats.dart';
import '../models/logData.dart';

class CustomWidgets {
  static const Color backgroundNavyBlue = Color(0xff203857);

  Widget buildSummerCard( LogData li , BuildContext context, var data) {


    print("AT BUILDSUMMER");
    print(li.jobName);
    // LogData li = LogData(
    //     "wf_mtt_0013E40Z00000000030B",
    //     "1676253637545",
    //     "1676254193737",
    //     "556192",
    //     "5025722",
    //     "SUCCESS",
    //     "Feb 13, 2023 7:30:37 AM",
    //     "5025722");
    // color = Color(0xffFC9B87) ;
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:
            (context)=>JobStat(jobId: li.jobName, data: data)));
      },
      child: Container(
        height: 20,
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            elevation: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 10),
                    ),
                    Text(
                      "Job Name : ",
                      style: TextStyle(
                          color: CustomWidgets.backgroundNavyBlue,
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
                            content: Text('${li.jobName} is copied to your clipboard'));
                        ScaffoldMessenger.of(context).showSnackBar(snak);
                      },
                      icon: Icon(
                        Icons.copy,
                        size: 15,
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
                          color: CustomWidgets.backgroundNavyBlue,
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
                          color: CustomWidgets.backgroundNavyBlue,
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

  Widget clip(BuildContext context) {
    return Row(
      children: [
        Text(
          "SIDDD",
          style: GoogleFonts.abel(
            color: Colors.green,
          ),
        ),
        IconButton(
            icon: Icon(
              Icons.copy,
              color: Colors.black,
              size: 17,
            ),
            onPressed: () {
              Clipboard.setData(
                ClipboardData(
                  text: "COPIED",
                ),
              );

              final snak =
                  SnackBar(content: Text('File Unique is copied to Clipboard'));
              ScaffoldMessenger.of(context).showSnackBar(snak);
            }),
      ],
    );
  }

  Widget logo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CustomWidgets().makeTransactionsIcon(),
        const SizedBox(
          width: 38,
        ),
        const Text(
          'Execution',
          style:
              TextStyle(color: CustomWidgets.backgroundNavyBlue, fontSize: 28),
        ),
        const SizedBox(
          width: 4,
        ),
        const Text(
          'status',
          style: TextStyle(color: Color(0xff77839a), fontSize: 20),
        ),
      ],
    );
  }
}
