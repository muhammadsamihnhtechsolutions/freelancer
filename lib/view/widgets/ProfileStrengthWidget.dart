import 'package:flutter/material.dart';

class ProfileStrengthWidget extends StatelessWidget {
  const ProfileStrengthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TITLE
          const Text(
            "Profile Strength",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CIRCLE METER
              SizedBox(
                height: 70,
                width: 70,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: 1.0,
                      strokeWidth: 8,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: const AlwaysStoppedAnimation(Color(0xFF18C462)),
                    ),
                    const Text(
                      "100%",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // TEXT COLUMN
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Excellent profile",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Strong profiles get better freelancers.",
                      style: TextStyle(fontSize: 12),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: const [
                        Text(
                          "Credits: ",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "11",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF5A5BFF),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // CHECKLIST
          _checkItem("company name"),
          _checkItem("company description"),
          _checkItem("company website"),
          _checkItem("logo"),

          const SizedBox(height: 16),

          // EDIT PROFILE LINK
          Row(
            children: [
              Icon(Icons.edit_outlined, size: 18, color: Colors.blue.shade600),
              const SizedBox(width: 4),
              Text(
                "Edit Profile",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.blue.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _checkItem(String text) {
    return Row(
      children: [
        const Icon(Icons.check_circle,
            size: 16, color: Color(0xFF18C462)),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 13),
        ),
      ],
    );
  }
}