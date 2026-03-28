class ClientSideReviewModel {
  final String id;
  final String jobId;
  final int rating;
  final String review;
  final String createdAt;
  final String reviewerName;
  final String reviewerEmail;

  ClientSideReviewModel({
    required this.id,
    required this.jobId,
    required this.rating,
    required this.review,
    required this.createdAt,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory ClientSideReviewModel.fromJson(Map<String, dynamic> json) {
    return ClientSideReviewModel(
      id: (json["id"] ?? "").toString(),
      jobId: (json["job_id"] ?? "").toString(),
      rating: _parseRating(json["rating"]),
      review: (json["review"] ?? json["comment"] ?? "").toString(),
      createdAt: (json["created_at"] ?? "").toString(),
      reviewerName: (json["client_name"] ??
              json["reviewer_name"] ??
              json["user_name"] ??
              "")
          .toString(),
      reviewerEmail: (json["client_email"] ??
              json["reviewer_email"] ??
              json["user_email"] ??
              "")
          .toString(),
    );
  }

  static int _parseRating(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.round();
    return int.tryParse(value.toString()) ?? 0;
  }
}

class ClientSideReviewStatsModel {
  final int totalReviews;
  final double avgRating;

  ClientSideReviewStatsModel({
    required this.totalReviews,
    required this.avgRating,
  });

  factory ClientSideReviewStatsModel.fromJson(Map<String, dynamic> json) {
    return ClientSideReviewStatsModel(
      totalReviews: _parseInt(json["totalReviews"]),
      avgRating: _parseDouble(json["avgRating"]),
    );
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }
}

class ClientSideReviewListResponseModel {
  final bool success;
  final String message;
  final List<ClientSideReviewModel> reviews;
  final ClientSideReviewStatsModel stats;

  ClientSideReviewListResponseModel({
    required this.success,
    required this.message,
    required this.reviews,
    required this.stats,
  });

  factory ClientSideReviewListResponseModel.fromJson(Map<String, dynamic> json) {
    final List reviewsJson = (json["reviews"] ?? []) as List;

    return ClientSideReviewListResponseModel(
      success: (json["success"] ?? true) == true,
      message: (json["message"] ?? "").toString(),
      reviews: reviewsJson
          .map((e) => ClientSideReviewModel.fromJson(
                Map<String, dynamic>.from(e as Map),
              ))
          .toList(),
      stats: ClientSideReviewStatsModel.fromJson(
        Map<String, dynamic>.from(json["stats"] ?? {}),
      ),
    );
  }
}

class ClientSideSubmitReviewResponseModel {
  final bool success;
  final String message;
  final ClientSideReviewModel? review;

  ClientSideSubmitReviewResponseModel({
    required this.success,
    required this.message,
    required this.review,
  });

  factory ClientSideSubmitReviewResponseModel.fromJson(
      Map<String, dynamic> json) {
    return ClientSideSubmitReviewResponseModel(
      success: (json["success"] ?? true) == true,
      message: (json["message"] ?? "").toString(),
      review: json["review"] != null
          ? ClientSideReviewModel.fromJson(
              Map<String, dynamic>.from(json["review"]),
            )
          : null,
    );
  }
}