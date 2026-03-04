import 'package:flutter/material.dart';
import 'package:freelancer_app/FreelancerDashboard/findjob/FindJobController.dart';
import 'package:freelancer_app/FreelancerDashboard/findjob/FreeelanceFindJobModel.dart' show JobModel;
import 'package:get/get.dart';
import 'package:freelancer_app/theme/AppColors.dart';
import 'package:freelancer_app/FreelancerDashboard/myperposal/ProposelDetailsView.dart';



class FindJobsView extends StatelessWidget {
  const FindJobsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JobsController>();

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

              // ===========================
              // LIVE JOB LIST FROM API
              // ===========================
              Obx(() {
                if (controller.loading.value) {
                  return const Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: CircularProgressIndicator(),
                  ));
                }

                if (controller.jobs.isEmpty) {
                  return const Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      "No open jobs found",
                      style: TextStyle(fontSize: 15),
                    ),
                  ));
                }

                return Column(
                  children: controller.jobs
                      .map((job) => _jobCard(job))
                      .toList(),
                );
              }),

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
      child: const TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.black54),
          hintText: "Search jobs...",
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
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
  // JOB CARD (DYNAMIC)
  // -------------------------------
  Widget _jobCard(JobModel job) {
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
            job.category,
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
              Expanded(
                child: Text(
                  job.title,
                  style: const TextStyle(
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
                child: Text(
                  job.status,
                  style: const TextStyle(
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

              Text(
                job.remote ? "Remote" : "Onsite",
                style: const TextStyle(color: Colors.black54, fontSize: 12),
              ),

              const SizedBox(width: 12),
              const Icon(Icons.calendar_today, size: 16, color: Colors.black45),
              const SizedBox(width: 4),

              Text(
                job.createdAt.split("T")[0],
                style: const TextStyle(color: Colors.black54, fontSize: 12),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // DESCRIPTION
          Text(
            job.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, height: 1.4),
          ),

          const SizedBox(height: 14),

          // BUDGET + VIEW JOB BUTTON
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "BUDGET",
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "£${job.minBudget} - £${job.maxBudget}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),

              _viewJobButton(job),
            ],
          ),
        ],
      ),
    );
  }

  // -------------------------------
  // VIEW JOB BUTTON
  // -------------------------------
  Widget _viewJobButton(JobModel job) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProposalDetailsView(job: job));
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