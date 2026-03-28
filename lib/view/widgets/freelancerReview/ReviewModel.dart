class ReviewModel {
  final String id;
  final String name;
  final int rating;
  final String review;
  final String time;

  ReviewModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.review,
    required this.time,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    print("=================================");
    print("📥 PARSING REVIEW MODEL");
    print("📦 RAW REVIEW JSON → $json");
    print("=================================");

    return ReviewModel(
      id: (json["id"] ?? "").toString(),
      name: (json["reviewer_name"] ?? "Anonymous").toString(),
      rating: json["rating"] is int
          ? json["rating"]
          : int.tryParse(json["rating"].toString()) ?? 0,
      review: (json["review"] ?? "").toString(),
      time: (json["created_at"] ?? "").toString(),
    );
  }
}