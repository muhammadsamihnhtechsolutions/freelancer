// class FreelancerProfileModel {

//   final String userId;
//   final String skills;
//   final String portfolioLinks;
//   final int experience;
//   final String bio;

//   FreelancerProfileModel({
//     required this.userId,
//     required this.skills,
//     required this.portfolioLinks,
//     required this.experience,
//     required this.bio,
//   });

//   factory FreelancerProfileModel.fromJson(Map<String, dynamic> json) {
//     return FreelancerProfileModel(
//       userId: json["user_id"] ?? "",
//       skills: json["skills"] ?? "",
//       portfolioLinks: json["portfolio_links"] ?? "",
//       experience: int.tryParse(json["experience"].toString()) ?? 0,
//       bio: json["bio"] ?? "",
//     );
//   }
// }


class FreelancerProfileModel {

  final String userId;
  final String skills;
  final String portfolioLinks;
  final int experience;
  final String bio;

  FreelancerProfileModel({
    required this.userId,
    required this.skills,
    required this.portfolioLinks,
    required this.experience,
    required this.bio,
  });

  factory FreelancerProfileModel.fromJson(Map<String, dynamic> json) {

    print("🧠 PARSING PROFILE MODEL");

    return FreelancerProfileModel(
      userId: json["user_id"] ?? "",
      skills: json["skills"] ?? "",
      portfolioLinks: json["portfolio_links"] ?? "",
      experience: int.tryParse(json["experience"].toString()) ?? 0,
      bio: json["bio"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "skills": skills,
      "portfolio_links": portfolioLinks,
      "experience": experience,
      "bio": bio,
    };
  }

}