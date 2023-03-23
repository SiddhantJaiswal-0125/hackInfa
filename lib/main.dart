import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heck/Screens/JobStats.dart';
import 'package:heck/Utility/fetchData.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var data;
  Set st = Set();

  getData() async {
    String path = "lib/dataFeed.json";
    String response = await rootBundle.loadString(path);
    data = await json.decode(response);

    for (var dt in data) st.add(dt['jobName']);

    // print(st);
  }

  @override
  void initState() {
    // TODO: implement initState

    print("AT INIT");

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getData();
    });
    super.initState();
  }

  String searchtext = "";

  bool elementExist = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        title: Text(
          "Tomcat Stats",
          style: GoogleFonts.lato(
              textStyle: TextStyle(letterSpacing: 1.5, fontSize: 40)),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 85.0, left: 8.0, right: 8.0, bottom: 8.0),
            child: Container(
              height: 660.0,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SearchBarAnimation(
                      onFieldSubmitted: (var val) {
                        print("FIELD DPONE ");
                        print(val);
                        searchtext = val;
                        print(st);
                        if (st.contains(searchtext)) {
                          print("ST CONTAINS");
                          elementExist = true;
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JobStat(
                                  jobId: searchtext,
                                  data: data,
                                ),
                              ),
                            );
                          });

                          //TODO:NAVIGATION
                        } else {
                          elementExist = false;
                          setState(() {});
                        }
                      },
                      textEditingController: TextEditingController(),
                      isOriginalAnimation: true,
                      enableKeyboardFocus: true,
                      onExpansionComplete: () {
                        debugPrint(
                            'do something just after searchbox is opened.');
                      },
                      onCollapseComplete: () {
                        debugPrint(
                            'do something just after searchbox is closed.');
                      },
                      onPressButton: (isSearchBarOpens) {
                        debugPrint(
                            'do something before animation started. It\'s the ${isSearchBarOpens ? 'opening' : 'closing'} animation');
                      },
                      trailingWidget: const Icon(
                        Icons.search,
                        size: 20,
                        color: Colors.black,
                      ),
                      secondaryButtonWidget: const Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.black,
                      ),
                      buttonWidget: const Icon(
                        Icons.search,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  elementExist == false && searchtext.length > 0
                      ? Center(
                          child: Container(
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "This Job ID Is not present at the moment, \n Please try again later",
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                          color: Colors.blueGrey.withOpacity(0.9),
                        ))
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
