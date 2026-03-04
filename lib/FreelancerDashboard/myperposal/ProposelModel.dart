class ProposalModel {
  final String id;
  final String jobTitle;
  final String price;
  final int days;
  final String status;

  ProposalModel({
    required this.id,
    required this.jobTitle,
    required this.price,
    required this.days,
    required this.status,
  });

  factory ProposalModel.fromJson(Map<String, dynamic> json) {
    print("📥 Parsing Proposal JSON → $json");

    return ProposalModel(
      id: json["_id"]?.toString() ?? "",
      jobTitle: json["job_title"] ?? "No Title",
      price: json["price"]?.toString() ?? "0",
      days: json["delivery_days"] ?? 0,
      status: json["status"] ?? "PENDING",
    );
  }
}