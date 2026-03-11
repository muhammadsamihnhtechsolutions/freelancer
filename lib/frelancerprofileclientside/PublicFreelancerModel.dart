class PublicFreelancerModel {

  final String id;
  final String fullName;
  final String skills;
  final int experience;
  final String bio;
  final double rating;
  final int totalReviews;

  PublicFreelancerModel({
    required this.id,
    required this.fullName,
    required this.skills,
    required this.experience,
    required this.bio,
    required this.rating,
    required this.totalReviews,
  });

  factory PublicFreelancerModel.fromJson(Map<String, dynamic> json) {
    return PublicFreelancerModel(
      id: json["id"] ?? "",
      fullName: json["full_name"] ?? "",
      skills: json["skills"] ?? "",
      experience: int.tryParse(json["experience"].toString()) ?? 0,
      bio: json["short_bio"] ?? "",
      rating: double.tryParse(json["avg_rating"].toString()) ?? 0.0,
      totalReviews: json["total_reviews"] ?? 0,
    );
  }
}