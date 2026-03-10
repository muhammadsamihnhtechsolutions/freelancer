class ActivityModel {
  final String action;
  final String jobTitle;
  final DateTime date;
  final String status;

  ActivityModel({
    required this.action,
    required this.jobTitle,
    required this.date,
    required this.status,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      action: json["status"] ?? "",
      jobTitle: json["job_title"] ?? "",
      date: DateTime.parse(json["created_at"]),
      status: json["status"] ?? "",
    );
  }
}