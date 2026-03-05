class AdminJobModel {
  final String id;
  final String title;
  final String clientName;
  final double budgetMin;
  final double budgetMax;
  final String jobType;
  final String status;
  final int proposalsCount;
  final String description;

  AdminJobModel({
    required this.id,
    required this.title,
    required this.clientName,
    required this.budgetMin,
    required this.budgetMax,
    required this.jobType,
    required this.status,
    required this.proposalsCount,
    required this.description,
  });

  factory AdminJobModel.fromJson(Map<String, dynamic> json) {
    // ✅ client name multiple possible keys
    final client =
        (json["client_name"] ??
                json["clientName"] ??
                json["client"]?["name"] ??
                json["user"]?["name"] ??
                "Client")
            .toString();

    // ✅ budgets multiple keys
    final minRaw = json["budget_min"] ?? json["budgetMin"] ?? json["min_budget"] ?? 0;
    final maxRaw = json["budget_max"] ?? json["budgetMax"] ?? json["max_budget"] ?? 0;

    return AdminJobModel(
      id: (json["id"] ?? json["_id"] ?? "").toString(),
      title: (json["title"] ?? "").toString(),
      clientName: client,
      budgetMin: (minRaw is num) ? minRaw.toDouble() : double.tryParse(minRaw.toString()) ?? 0,
      budgetMax: (maxRaw is num) ? maxRaw.toDouble() : double.tryParse(maxRaw.toString()) ?? 0,
      jobType: (json["job_type"] ?? json["jobType"] ?? "remote").toString(),
      status: (json["status"] ?? "pending").toString(),
      proposalsCount: (json["proposals_count"] ??
              json["proposalsCount"] ??
              json["proposalCount"] ??
              0) is num
          ? (json["proposals_count"] ?? json["proposalsCount"] ?? json["proposalCount"] ?? 0).toInt()
          : int.tryParse((json["proposals_count"] ?? json["proposalsCount"] ?? json["proposalCount"] ?? 0).toString()) ?? 0,
      description: (json["description"] ?? "").toString(),
    );
  }
}