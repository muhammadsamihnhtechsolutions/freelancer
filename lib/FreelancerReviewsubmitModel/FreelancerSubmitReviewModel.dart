class FreelancerSubmitReviewModel {
  final String id;
  final String jobId;
  final String reviewerId;
  final String reviewerRole;
  final String revieweeId;
  final int rating;
  final String review;
  final String createdAt;

  FreelancerSubmitReviewModel({
    required this.id,
    required this.jobId,
    required this.reviewerId,
    required this.reviewerRole,
    required this.revieweeId,
    required this.rating,
    required this.review,
    required this.createdAt,
  });

  factory FreelancerSubmitReviewModel.fromJson(Map<String, dynamic> json) {
    return FreelancerSubmitReviewModel(
      id: json["id"] ?? "",
      jobId: json["job_id"] ?? "",
      reviewerId: json["reviewer_id"] ?? "",
      reviewerRole: json["reviewer_role"] ?? "",
      revieweeId: json["reviewee_id"] ?? "",
      rating: json["rating"] is int
          ? json["rating"]
          : int.tryParse(json["rating"].toString()) ?? 0,
      review: json["review"] ?? "",
      createdAt: json["created_at"] ?? "",
    );
  }
}