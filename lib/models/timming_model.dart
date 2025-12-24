class TimingModel {
  String title;
  String startTime;
  String endTime;

  TimingModel({
    required this.title,
    required this.startTime,
    required this.endTime,
  });

  factory TimingModel.fromJson(Map<String, dynamic> j) => TimingModel(
    title: j['title'] ?? '',
    startTime: j['startTime'] ?? '',
    endTime: j['endTime'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'startTime': startTime,
    'endTime': endTime,
  };
}
