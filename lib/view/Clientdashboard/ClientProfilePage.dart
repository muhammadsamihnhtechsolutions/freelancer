import 'package:flutter/material.dart';
import 'package:freelancer_app/theme/AppColors.dart';

class ClientProfilePage extends StatelessWidget {
  const ClientProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final client = {
      "company_name": "eza-tech",
      "tagline": "dasa | eza-tech employees",
      "location": "East London, Buffalo City, Eastern Cape, ZAF",
      "about": "This is a sample company about section for the client profile.",
      "website": "eza-tech",
      "email": "ezatechltd1@gmail.com",
      "phone": "07471095853",
      "linkedin": "da",
    };

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _pageHeader(),
              const SizedBox(height: 18),
              _profileHeaderCard(client),
              const SizedBox(height: 18),
              _sectionTitle("About Company"),
              _aboutText(client["about"].toString()),
              const SizedBox(height: 20),
              _sectionTitle("Company Information"),
              const SizedBox(height: 10),
              _infoGrid(client),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // TOP PAGE TITLE
  Widget _pageHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Client Profile",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
        SizedBox(height: 4),
        Text(
          "Manage your company information",
          style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
        ),
      ],
    );
  }

  // HEADER CARD (Name, tagline, location)
Widget _profileHeaderCard(client) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white, // ← White background
      borderRadius: BorderRadius.circular(22),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 18,
          offset: const Offset(0, 5),
        ),
      ],
      border: Border.all(
        color: Colors.grey.withOpacity(0.12),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// 🔵 Modern Logo Placeholder (Light Blue Background)
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                AppColors.primaryStart.withOpacity(0.15),
                AppColors.primaryEnd.withOpacity(0.15),
              ],
            ),
          ),
          child: const Icon(
            Icons.business_rounded,
            size: 32,
            color: Color(0xFF1E293B),
          ),
        ),

        const SizedBox(width: 18),

        /// 📝 Company Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                client["company_name"].toString(),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                client["tagline"].toString(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF475569),
                ),
              ),
              const SizedBox(height: 6),

              /// 📍 Location
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on_rounded,
                      size: 16, color: Color(0xFF64748B)),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      client["location"].toString(),
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                        height: 1.3,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),

        const SizedBox(width: 10),

        /// ✏️ EDIT BUTTON (Gradient)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryStart,
                AppColors.primaryEnd,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(12),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                "Edit",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

  // SECTION TITLE
  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Color(0xFF0F172A),
      ),
    );
  }

  // ABOUT TEXT
  Widget _aboutText(String about) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        about,
        style: const TextStyle(
          fontSize: 15,
          height: 1.45,
          color: Color(0xFF475569),
        ),
      ),
    );
  }

  // INFO GRID (Website, Email, Phone, LinkedIn)
  Widget _infoGrid(client) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _infoTile(
                title: "Website",
                value: client["website"],
                icon: Icons.language,
                clickable: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _infoTile(
                title: "Email",
                value: client["email"],
                icon: Icons.email_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _infoTile(
                title: "Phone",
                value: client["phone"],
                icon: Icons.phone,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _infoTile(
                title: "LinkedIn",
                value: client["linkedin"],
                icon: Icons.link,
                clickable: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // INFO TILE
  Widget _infoTile({
    required String title,
    required String value,
    required IconData icon,
    bool clickable = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryStart, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    color: clickable ? Colors.blue : Color(0xFF0F172A),
                    decoration:
                        clickable ? TextDecoration.underline : TextDecoration.none,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}