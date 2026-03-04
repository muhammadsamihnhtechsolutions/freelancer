class JobModel {
  final String id;
  final String title;
  final String category;
  final String description;
  final String status;
  final String createdAt;
  final bool remote;
  final double minBudget;
  final double maxBudget;

  JobModel({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.remote,
    required this.minBudget,
    required this.maxBudget,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json["_id"] ?? "",
      title: json["title"] ?? "",
      category: json["category"] ?? "General",
      description: json["description"] ?? "",
      status: json["status"] ?? "open",
      createdAt: json["createdAt"] ?? "",
      remote: json["remote"] ?? true,
      minBudget: (json["minBudget"] ?? 0).toDouble(),
      maxBudget: (json["maxBudget"] ?? 0).toDouble(),
    );
  }
}