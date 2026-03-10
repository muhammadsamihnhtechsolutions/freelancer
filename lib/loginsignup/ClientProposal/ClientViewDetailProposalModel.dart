class ClientViewDetailsProposalModel {

  final String id;
  final String jobId;
  final String freelancerName;
  final String freelancerEmail;
  final String coverLetter;
  final String status;
  final String cvUrl;
  final double price;
  final int deliveryDays;

  ClientViewDetailsProposalModel({
    required this.id,
    required this.jobId,
    required this.freelancerName,
    required this.freelancerEmail,
    required this.coverLetter,
    required this.status,
    required this.cvUrl,
    required this.price,
    required this.deliveryDays,
  });

  /// --------------------------------------------------
  /// FROM JSON
  /// --------------------------------------------------
  factory ClientViewDetailsProposalModel.fromJson(
      Map<String, dynamic> json) {

    print("📥 ClientViewDetailsProposalModel JSON → $json");

    return ClientViewDetailsProposalModel(

      id: json["id"]?.toString() ?? "",

      jobId: json["job_id"]?.toString() ?? "",

      freelancerName: json["freelancer_name"]?.toString() ?? "",

      freelancerEmail: json["freelancer_email"]?.toString() ?? "",

      coverLetter: json["cover_letter"]?.toString() ?? "",

      status: json["status"]?.toString() ?? "",

      cvUrl: json["cv_pdf_url"]?.toString() ?? "",

      price: double.tryParse(json["price"]?.toString() ?? "0") ?? 0,

      deliveryDays:
          int.tryParse(json["delivery_days"]?.toString() ?? "0") ?? 0,
    );
  }

  /// --------------------------------------------------
  /// TO JSON
  /// --------------------------------------------------
  Map<String, dynamic> toJson() {
    return {

      "id": id,

      "job_id": jobId,

      "freelancer_name": freelancerName,

      "freelancer_email": freelancerEmail,

      "cover_letter": coverLetter,

      "status": status,

      "cv_pdf_url": cvUrl,

      "price": price,

      "delivery_days": deliveryDays,
    };
  }
}