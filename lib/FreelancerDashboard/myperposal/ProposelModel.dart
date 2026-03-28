// class ProposalModel {
//   final String id;
//   final String jobTitle;
//   final String price;
//   final int days;
//   final String status;

//   ProposalModel({
//     required this.id,
//     required this.jobTitle,
//     required this.price,
//     required this.days,
//     required this.status,
//   });

//   factory ProposalModel.fromJson(Map<String, dynamic> json) {
//     print("📥 Parsing Proposal JSON → $json");

//     return ProposalModel(
//       id: json["_id"]?.toString() ?? "",
//       jobTitle: json["job_title"] ?? "No Title",
//       price: json["price"]?.toString() ?? "0",
//       days: json["delivery_days"] ?? 0,
//       status: json["status"] ?? "PENDING",
//     );
//   }
// }

// class ProposalModel {

//   final String id;
  
//   final String jobTitle;
//   final String price;
//   final int days;
//   final String status;
  

//   ProposalModel({
//     required this.id,
//     required this.jobTitle,
//     required this.price,
//     required this.days,
//     required this.status,
//   });

//   factory ProposalModel.fromJson(Map<String, dynamic> json) {

//     print("=================================");
//     print("📥 PARSING PROPOSAL JSON");
//     print("📦 RAW JSON → $json");
//     print("=================================");

//     final id = json["id"] ?? json["_id"] ?? "";

//     final jobTitle =
//         json["job_title"] ??
//         json["title"] ??
//         json["job"]?["title"] ??
//         "No Title";

//     final price =
//         json["price"] ??
//         json["bid_amount"] ??
//         0;

//     final days =
//         json["delivery_days"] ??
//         json["days"] ??
//         0;

//     final status =
//         json["status"] ??
//         "PENDING";

//     print("🆔 ID → $id");
//     print("📌 TITLE → $jobTitle");
//     print("💰 PRICE → $price");
//     print("📦 DAYS → $days");
//     print("📊 STATUS → $status");

//     return ProposalModel(
//       id: id.toString(),
//       jobTitle: jobTitle.toString(),
//       price: price.toString(),
//       days: days is int ? days : int.tryParse(days.toString()) ?? 0,
//       status: status.toString(),
//     );
//   }
// }



// class ProposalModel {

//   final String id;
//   final String jobId;   // ✅ ADD THIS

//   final String jobTitle;
//   final String price;
//   final int days;
//   final String status;

//   ProposalModel({
//     required this.id,
//     required this.jobId,
//     required this.jobTitle,
//     required this.price,
//     required this.days,
//     required this.status,
//   });

//   factory ProposalModel.fromJson(Map<String, dynamic> json) {

//     print("=================================");
//     print("📥 PARSING PROPOSAL JSON");
//     print("📦 RAW JSON → $json");
//     print("=================================");

//     final id = json["id"] ?? json["_id"] ?? "";

//     /// ✅ JOB ID EXTRACTION (important)
//     final jobId =
//         json["job_id"] ??
//         json["job"]?["id"] ??
//         json["job"]?["_id"] ??
//         "";

//     final jobTitle =
//         json["job_title"] ??
//         json["title"] ??
//         json["job"]?["title"] ??
//         "No Title";

//     final price =
//         json["price"] ??
//         json["bid_amount"] ??
//         0;

//     final days =
//         json["delivery_days"] ??
//         json["days"] ??
//         0;

//     final status =
//         json["status"] ??
//         "PENDING";

//     print("🆔 Proposal ID → $id");
//     print("🗂 Job ID → $jobId");
//     print("📌 TITLE → $jobTitle");
//     print("💰 PRICE → $price");
//     print("📦 DAYS → $days");
//     print("📊 STATUS → $status");

//     return ProposalModel(
//       id: id.toString(),
//       jobId: jobId.toString(),  // ✅ PASS HERE
//       jobTitle: jobTitle.toString(),
//       price: price.toString(),
//       days: days is int ? days : int.tryParse(days.toString()) ?? 0,
//       status: status.toString(),
//     );
//   }
// }
class ProposalModel {
  final String id;
  final String jobId;
  final String jobTitle;
  final String price;
  final int days;
  final String status;
  final String coverLetter;
  final String clientId;
  final String userId;
  final String freelancerId;

  ProposalModel({
    required this.id,
    required this.jobId,
    required this.jobTitle,
    required this.price,
    required this.days,
    required this.status,
    required this.coverLetter,
    required this.clientId,
    required this.userId,
    required this.freelancerId,
  });

  factory ProposalModel.fromJson(Map<String, dynamic> json) {
    print("=================================");
    print("📥 PARSING PROPOSAL JSON");
    print("📦 RAW JSON → $json");
    print("=================================");

    final id = json["id"] ?? json["_id"] ?? "";

    final jobId =
        json["job_id"] ??
        json["job"]?["id"] ??
        json["job"]?["_id"] ??
        "";

    final jobTitle =
        json["job_title"] ??
        json["title"] ??
        json["job"]?["title"] ??
        "No Title";

    final price =
        json["price"] ??
        json["bid_amount"] ??
        0;

    final days =
        json["delivery_days"] ??
        json["days"] ??
        0;

    final status =
        json["status"] ??
        "PENDING";

    final coverLetter =
        json["cover_letter"] ??
        json["coverLetter"] ??
        json["proposal_text"] ??
        json["description"] ??
        "";

    final clientId =
        json["client_id"] ??
        json["clientId"] ??
        json["client"]?["id"] ??
        json["client"]?["_id"] ??
        json["job"]?["client_id"] ??
        json["job"]?["clientId"] ??
        json["job"]?["client"]?["id"] ??
        json["job"]?["client"]?["_id"] ??
        "";

    final userId =
        json["user_id"] ??
        json["userId"] ??
        json["user"]?["id"] ??
        json["user"]?["_id"] ??
        "";

    final freelancerId =
        json["freelancer_id"] ??
        json["freelancerId"] ??
        json["freelancer"]?["id"] ??
        json["freelancer"]?["_id"] ??
        "";

    print("🆔 Proposal ID → $id");
    print("🗂 Job ID → $jobId");
    print("📌 TITLE → $jobTitle");
    print("💰 PRICE → $price");
    print("📦 DAYS → $days");
    print("📊 STATUS → $status");
    print("📝 COVER LETTER → $coverLetter");
    print("👤 CLIENT ID → $clientId");
    print("👤 USER ID → $userId");
    print("🧑‍💻 FREELANCER ID → $freelancerId");

    return ProposalModel(
      id: id.toString(),
      jobId: jobId.toString(),
      jobTitle: jobTitle.toString(),
      price: price.toString(),
      days: days is int ? days : int.tryParse(days.toString()) ?? 0,
      status: status.toString(),
      coverLetter: coverLetter.toString(),
      clientId: clientId.toString(),
      userId: userId.toString(),
      freelancerId: freelancerId.toString(),
    );
  }
}