import 'package:flutter/material.dart';

class ClientFreelancerProfileUI extends StatelessWidget {
  const ClientFreelancerProfileUI({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = {
      "full_name": "John Doe",
      "title": "Senior Flutter Developer",
      "skills": "Flutter, Dart, Firebase, UI/UX",
      "experience": 4,
      "portfolio_links":
          "https://github.com/johndoe, https://dribbble.com/johndoe",
      "avg_rating": 4.5,
      "total_reviews": 32,
      "bio":
          "Experienced Flutter developer with strong UI/UX background. Built 30+ apps for clients globally.",
    };

    return Scaffold(
      backgroundColor: const Color(0xFFF3F5FA),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.95),
                  Colors.blue.shade50.withOpacity(0.4),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ⭐ HEADER
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _profileAvatar(),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile["full_name"].toString(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            profile["title"].toString(),
                            style: const TextStyle(
                              color: Color(0xFF475569),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Row(
                            children: [
                              _ratingStars(profile["avg_rating"] as double),
                              const SizedBox(width: 6),

                              Text(
                                "(${profile["total_reviews"]} reviews)",
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    _experienceTag(profile["experience"]),
                  ],
                ),

                const SizedBox(height: 24),

                // ⭐ ABOUT
                _sectionTitle("About"),
                const SizedBox(height: 6),

                Text(
                  profile["bio"].toString(),
                  style: const TextStyle(
                    fontSize: 14.5,
                    height: 1.4,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 28),

                // ⭐ SKILLS
                _sectionTitle("Skills"),
                const SizedBox(height: 10),

                _skillChips(profile["skills"]),

                const SizedBox(height: 30),

                // ⭐ PORTFOLIO LINKS
                _sectionTitle("Portfolio"),
                const SizedBox(height: 10),

                _portfolioList(profile["portfolio_links"]),

                const SizedBox(height: 28),

                // ⭐ BACK BUTTON
                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Back",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ------------------ UI COMPONENTS ------------------ //

  Widget _profileAvatar() {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.blue.shade700],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade200.withOpacity(0.4),
            blurRadius: 18,
          ),
        ],
      ),
      child: const Icon(Icons.person, size: 34, color: Colors.white),
    );
  }

  Widget _experienceTag(dynamic years) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "$years yrs",
        style: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _skillChips(dynamic skills) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: skills
          .toString()
          .split(",")
          .map(
            (skill) => Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue.shade50,
              ),
              child: Text(
                skill.trim(),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _portfolioList(dynamic links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: links
          .toString()
          .split(",")
          .map(
            (url) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                url.trim(),
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _ratingStars(double rating) {
    List<Widget> stars = [];
    int full = rating.floor();
    bool half = rating - full >= 0.5;

    for (int i = 0; i < full; i++) {
      stars.add(const Icon(Icons.star, size: 20, color: Colors.amber));
    }

    if (half) {
      stars.add(const Icon(Icons.star_half, size: 20, color: Colors.amber));
    }

    while (stars.length < 5) {
      stars.add(const Icon(Icons.star_border, size: 20, color: Colors.amber));
    }

    return Row(children: stars);
  }
}