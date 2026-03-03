import 'package:flutter/material.dart';
import 'package:freelancer_app/FreelancerDashboard/myperposal/ProposelDetailsView.dart' show ProposalDetailsView;
import 'package:freelancer_app/theme/AppColors.dart';
import 'package:get/get.dart';


class FindJobsView extends StatelessWidget {
  const FindJobsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              const SizedBox(height: 10),
              _buildCategoryDropdown(),

              const SizedBox(height: 18),

              // JOB LIST (FAKE DATA FOR NOW)
              _jobCard(),
              _jobCard(),
              _jobCard(),
              _jobCard(),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------
  // SEARCH FIELD
  // -------------------------------
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: Colors.black54),
          hintText: "Search jobs...",
          hintStyle: const TextStyle(color: Colors.black45),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  // -------------------------------
  // CATEGORY DROPDOWN
  // -------------------------------
  Widget _buildCategoryDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: "All Categories",
          items: const [
            DropdownMenuItem(value: "All Categories", child: Text("All Categories")),
            DropdownMenuItem(value: "Programming", child: Text("Programming")),
            DropdownMenuItem(value: "Design", child: Text("Design")),
            DropdownMenuItem(value: "Finance", child: Text("Finance")),
          ],
          onChanged: (v) {},
        ),
      ),
    );
  }

  // -------------------------------
  // JOB CARD UI (single)
  // -------------------------------
  Widget _jobCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CATEGORY
          Text(
            "Accounting & Finance",
            style: TextStyle(
              color: AppColors.primaryStart,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),

          // TITLE + STATUS BADGE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  "Example Job Title — Mobile UI",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    height: 1.3,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "open",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // REMOTE + DATE
          Row(
            children: [
              const Icon(Icons.public, size: 16, color: Colors.black45),
              const SizedBox(width: 4),
              const Text(
                "Remote",
                style: TextStyle(color: Colors.black54, fontSize: 12),
              ),
              const SizedBox(width: 12),

              const Icon(Icons.calendar_today, size: 16, color: Colors.black45),
              const SizedBox(width: 4),
              const Text(
                "Feb 23, 2026",
                style: TextStyle(color: Colors.black54, fontSize: 12),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // DESCRIPTION PREVIEW
          const Text(
            "**Job Overview** Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
            "Sed do eiusmod tempor incididunt ut labore.",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 13,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 14),

          // BUDGET + VIEW JOB BUTTON
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "BUDGET",
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "£12.00 - £30.00",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),

           _viewJobButton(),
            ],
          ),
        ],
      ),
    );
  }

  // -------------------------------
  // BLUE VIEW JOB BUTTON
  // -------------------------------
Widget _viewJobButton() {
  return GestureDetector(
    onTap: () {
      Get.to(() => const ProposalDetailsView());
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: [
            AppColors.primaryStart,
            AppColors.primaryEnd,
          ],
        ),
      ),
      child: const Text(
        "View Job",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
    ),
  );
}
}



