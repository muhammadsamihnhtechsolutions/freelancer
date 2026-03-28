
// class JobModel {
//   final String id;
//   final String title;
//   final String category;
//   final String description;
//   final String status;
//   final String createdAt;
//   final bool remote;
//   final double minBudget;
//   final double maxBudget;

//   JobModel({
//     required this.id,
//     required this.title,
//     required this.category,
//     required this.description,
//     required this.status,
//     required this.createdAt,
//     required this.remote,
//     required this.minBudget,
//     required this.maxBudget,
//   });

//   factory JobModel.fromJson(Map<String, dynamic> json) {

//     print("=================================");
//     print("📦 PARSING JOB JSON");
//     print("📦 RAW JSON → $json");
//     print("=================================");

//     final id = json["id"] ?? json["_id"] ?? "";

//     final title = json["title"]?.toString() ?? "";

//     final category =
//         json["category_name"] ??
//         json["category"] ??
//         "General";

//     final description = json["description"]?.toString() ?? "";

//     final status = json["status"]?.toString() ?? "open";

//     final createdAt =
//         json["created_at"] ??
//         json["createdAt"] ??
//         "";

//     final remote =
//         json["job_type"] == "remote" ||
//         json["remote"] == true;

//     final minBudget = double.tryParse(
//           json["budget_min"]?.toString() ??
//           json["minBudget"]?.toString() ??
//           "0",
//         ) ??
//         0;

//     final maxBudget = double.tryParse(
//           json["budget_max"]?.toString() ??
//           json["maxBudget"]?.toString() ??
//           "0",
//         ) ??
//         0;

//     print("🆔 JOB ID → $id");
//     print("📌 TITLE → $title");
//     print("📦 CATEGORY → $category");
//     print("💰 MIN BUDGET → $minBudget");
//     print("💰 MAX BUDGET → $maxBudget");

//     return JobModel(
//       id: id.toString(),
//       title: title,
//       category: category,
//       description: description,
//       status: status,
//       createdAt: createdAt,
//       remote: remote,
//       minBudget: minBudget,
//       maxBudget: maxBudget,
//     );
//   }
// }
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
  final bool alreadySubmitted;

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
    required this.alreadySubmitted,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    print("=================================");
    print("📦 PARSING JOB JSON");
    print("📦 RAW JSON → $json");
    print("=================================");

    final id = json["id"] ?? json["_id"] ?? "";

    final title = json["title"]?.toString() ?? "";

    final category =
        json["category_name"] ??
        json["category"] ??
        "General";

    final description = json["description"]?.toString() ?? "";

    final status = json["status"]?.toString() ?? "open";

    final createdAt =
        json["created_at"] ??
        json["createdAt"] ??
        "";

    final remote =
        json["job_type"] == "remote" ||
        json["remote"] == true;

    final minBudget = double.tryParse(
          json["budget_min"]?.toString() ??
              json["minBudget"]?.toString() ??
              "0",
        ) ??
        0;

    final maxBudget = double.tryParse(
          json["budget_max"]?.toString() ??
              json["maxBudget"]?.toString() ??
              "0",
        ) ??
        0;

    final alreadySubmitted =
        json["alreadySubmitted"] == true ||
        json["already_submitted"] == true ||
        json["proposal_submitted"] == true ||
        json["is_applied"] == true ||
        json["alreadySubmitted"] == 1 ||
        json["already_submitted"] == 1 ||
        json["proposal_submitted"] == 1 ||
        json["is_applied"] == 1;

    print("🆔 JOB ID → $id");
    print("📌 TITLE → $title");
    print("📦 CATEGORY → $category");
    print("💰 MIN BUDGET → $minBudget");
    print("💰 MAX BUDGET → $maxBudget");
    print("📨 ALREADY SUBMITTED → $alreadySubmitted");

    return JobModel(
      id: id.toString(),
      title: title,
      category: category,
      description: description,
      status: status,
      createdAt: createdAt,
      remote: remote,
      minBudget: minBudget,
      maxBudget: maxBudget,
      alreadySubmitted: alreadySubmitted,
    );
  }
}