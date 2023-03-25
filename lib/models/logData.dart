class LogData {
  final String jobName;
  final String startTime;
  final String endTime;
  final String duration;
  final String dataprocessed;
  final String status;
  final String date;
  final String targetSuccessRows;

  LogData(this.jobName, this.startTime, this.endTime, this.duration,
      this.dataprocessed, this.status, this.date, this.targetSuccessRows);
}
