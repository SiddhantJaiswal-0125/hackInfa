import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heck/Screens/JobStats.dart';
import 'package:heck/Utility/CustomWidgets.dart';
import 'package:heck/Utility/fetchData.dart';
import 'package:heck/models/dtmData.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'models/logData.dart';

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
  List <LogData> elements = [];
  bool wait = true;
  List<DtmData> dtmdata = [];

  getData() async {
    String path = "lib/dataFeed_V1.json";
    String response = await rootBundle.loadString(path);
    data = await json.decode(response);
    elements =  FetchData().decodekro(data) ;

    for(LogData li in elements)
      st.add(li.jobName);

    print("-----------------------------------------------------");

    setState(() {
      wait = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    print("AT INIT");


    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getData();
    });
    // elements = st.toList();
    // print("LIST IS HERE ");
    // print(elements);

    super.initState();
  }

  String searchtext = "";

  bool elementExist = true;

  bool test = false;
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return wait
        ? Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
          )
        : Scaffold(
            appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),

              child: AppBar(
                centerTitle: true,
                leading:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(image: AssetImage("lib/INFA2.png"),height: 50,width: 50,),
                  ),



                backgroundColor:
                light ? Colors.white54 :
                CustomWidgets.backgroundNavyBlue,
                title: Row(
                  children: [
                    Spacer(),
                    Text(
                      "Task Execution Visualizer",
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              letterSpacing: 1.5, fontSize: 40,
                          color: light ? CustomWidgets.backgroundNavyBlue : Colors.tealAccent,
                          )),
                    ),
                    Spacer(),
                    Row(
                      children: [  GestureDetector(
                        onTap: (){
                          setState(() {
                            if(light)
                              light = false;
                            else
                              light = true;
                          });

                        },
                        child: Icon(
                            light ? Icons.light_mode : Icons.dark_mode_outlined,
                        color: light ? Colors.black : Colors.white,
                        ) ,
                      ),
                        SizedBox(width: 40,),
                        CustomWidgets().dtmWidget(context, true),
                      ],
                    ),
                    SizedBox(width: 8,),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          color: light ? Colors.white:Colors.black54,
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 55.0, left: 8.0, right: 8.0, bottom: 8.0),
                            child: Container(
                              height: 10.0,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.1),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: SearchBarAnimation(

                                      cursorColour: Colors.deepOrange,
                                      onFieldSubmitted: (var val) {
                                        print("FIELD DONE ");
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
                                                  light: true,
                                                ),
                                              ),
                                            );
                                          });
                                        } else {
                                          elementExist = false;
                                          setState(() {});
                                        }
                                      },
                                      textEditingController:
                                          TextEditingController(),
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
                                            decoration: BoxDecoration(
                                              color: Colors.blueGrey.withOpacity(0.9),
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            height: 80,


                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: Text(
                                                "Job Id =  ${searchtext} is not present at the moment, \n Please try with a Vaild Job Id. ",
                                                style: GoogleFonts.lato(
                                                    textStyle: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),

                                  SizedBox(height: 10,)
                                ],
                              ),
                            ),
                          ),
                        ),
                         Container(color: light ? Colors.black : Colors.tealAccent,
                         height: 0.8,),
                        // Container(
                        //   height: MediaQuery.of(context).size.height-100,
                        //   child: GridView.count(
                        //     crossAxisCount: 3,
                        //     children: List.generate(
                        //         elements.length,
                        //         (index) => CustomWidgets()
                        //             .buildSummerCard(elements[index], context)),
                        //   ),
                        // ),


                        Container(
                          color: light ? Colors.white :  Colors.black54,

                          height:  MediaQuery.of(context).size.height-100,
                            padding: EdgeInsets.all(12.0),
                            child: GridView.builder(
                              itemCount: elements.length ,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  childAspectRatio: 3.5,

                                  crossAxisSpacing: 2.0,
                                  mainAxisSpacing: 4.0,
                              ),
                              itemBuilder: (BuildContext context, int index){
                                return CustomWidgets().
                                buildSummerCard( elements[index], context, data, light);

                                Container(height: 10,color: Colors.black,);},
                            ),
                        ),
                        // CustomWidgets().buildSummerCard(context),
                      ],
                    ),
                  ),
          );
  }
}
