import 'package:flutter/material.dart';
class JobStat extends StatefulWidget {

   JobStat(  {Key? key, required this.jobId,required this.data} ) : super(key: key);
  final String jobId;
   var data;

  @override
  State<JobStat> createState() => _JobStatState();
}

class _JobStatState extends State<JobStat> {
  late String id;
  @override
  void initState() {
    id = widget.jobId;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
