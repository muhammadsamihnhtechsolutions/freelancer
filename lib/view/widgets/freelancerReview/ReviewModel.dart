class ReviewModel {
  final String name;
  final int rating;
  final String review;
  final String time;
  

  ReviewModel({
    required this.name,
    required this.rating,
    required this.review,
    required this.time,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      name: json["reviewer_name"] ?? "Unknown",
      rating: json["rating"] ?? 0,
      review: json["comment"] ?? "",
      time: json["created_at"] ?? "",
    );
  }
}