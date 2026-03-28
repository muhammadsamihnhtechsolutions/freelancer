
import 'package:flutter/material.dart';
import 'package:freelancer_app/FreelancerDashboard/myperposal/ProposelController.dart';
import 'package:freelancer_app/theme/AppColors.dart';
import 'package:get/get.dart';

class MyProposalsView extends StatelessWidget {
  const MyProposalsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProposalController controller = Get.put(ProposalController());

    print("🟢 MyProposalsView BUILD");

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: SafeArea(
        child: Obx(() {
          print("📊 UI REBUILD");
          print("📦 Proposals Count → ${controller.filteredProposals.length}");
          print("⏳ Loading → ${controller.isLoading.value}");

          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// HEADER
                const Text(
                  "My Proposals",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 4),

                const Text(
                  "Track bids, monitor progress, and manage your earnings.",
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                ),

                const SizedBox(height: 18),

                /// STATS
                _statsRow(controller),

                const SizedBox(height: 18),

                /// SEARCH + FILTER
                Row(
                  children: [
                    Expanded(child: _searchField(controller)),
                    const SizedBox(width: 12),
                    _statusDropdown(controller),
                  ],
                ),

                const SizedBox(height: 20),

                /// PROPOSALS
                if (controller.filteredProposals.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Center(
                      child: Text(
                        "No proposals found",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.filteredProposals.length,
                    itemBuilder: (context, index) {
                      final p = controller.filteredProposals[index];

                      print("📄 Building Card → ${p.jobTitle}");
                      print("🆔 Proposal ID → ${p.id}");

                      return _proposalCard(
                        proposal: p,
                        title: p.jobTitle,
                        price: "£${p.price}",
                        days: "${p.days} days",
                        status: p.status.toUpperCase(),
                        statusColor: _getStatusColor(p.status),
                      );
                    },
                  ),

                const SizedBox(height: 40),
              ],
            ),
          );
        }),
      ),
    );
  }

  /// STATUS COLOR
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "completed":
        return Colors.green;
      case "active":
        return Colors.blue;
      case "pending":
      default:
        return Colors.orange;
    }
  }

  /// STATS ROW
  Widget _statsRow(ProposalController controller) {
    int total = controller.proposals.length;

    int active = controller.proposals
        .where((e) => e.status.toLowerCase() == "active")
        .length;

    int completed = controller.proposals
        .where((e) => e.status.toLowerCase() == "completed")
        .length;

    int pending = controller.proposals
        .where((e) => e.status.toLowerCase() == "pending")
        .length;

    print("📊 Stats → total:$total active:$active completed:$completed pending:$pending");

    return Row(
      children: [
        Expanded(child: _statBox("Total", total.toString())),
        const SizedBox(width: 8),
        Expanded(child: _statBox("Active", active.toString())),
        const SizedBox(width: 8),
        Expanded(child: _statBox("Completed", completed.toString())),
        const SizedBox(width: 8),
        Expanded(child: _statBox("Pending", pending.toString())),
      ],
    );
  }

  Widget _statBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
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
        children: [
          Text(title, style: const TextStyle(color: Colors.black54, fontSize: 12)),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }

  /// SEARCH FIELD
  Widget _searchField(ProposalController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) {
          print("🔍 SEARCH → $value");
          controller.search(value);
        },
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.black45),
          hintText: "Search job title...",
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  /// STATUS DROPDOWN
  Widget _statusDropdown(ProposalController controller) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: Obx(() => DropdownButton<String>(
              value: controller.selectedStatus.value,
              items: const [
                DropdownMenuItem(value: "All", child: Text("All Status")),
                DropdownMenuItem(value: "pending", child: Text("Pending")),
                DropdownMenuItem(value: "completed", child: Text("Completed")),
                DropdownMenuItem(value: "active", child: Text("Active")),
              ],
              onChanged: (v) {
                print("🔽 Status Filter Selected → $v");
                controller.filterStatus(v ?? "All");
              },
            )),
      ),
    );
  }

  /// PROPOSAL CARD
  Widget _proposalCard({
    required dynamic proposal,
    required String title,
    required String price,
    required String days,
    required String status,
    required Color statusColor,
  }) {
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(days, style: const TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),

          const SizedBox(height: 6),

          Row(
            children: [
              Text(price, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _blueButton("View Proposal", () {
                print("➡ View Proposal Clicked → ${proposal.id}");
                Get.toNamed('/view-proposal', arguments: proposal);
              }),
              _outlineButton("View Job", () {
                print("➡ View Job Clicked → ${proposal.jobTitle}");
                Get.toNamed('/view-job', arguments: proposal);
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _blueButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryStart,
              AppColors.primaryEnd,
            ],
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _outlineButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black26),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}