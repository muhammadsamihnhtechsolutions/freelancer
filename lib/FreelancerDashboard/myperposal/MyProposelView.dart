import 'package:flutter/material.dart';
import 'package:freelancer_app/theme/AppColors.dart';

class MyProposalsView extends StatelessWidget {
  const MyProposalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------- HEADER ----------------
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

              // ---------------- STATS ROW ----------------
              _statsRow(),

              const SizedBox(height: 18),

              // ---------------- SEARCH + STATUS FILTER ----------------
              Row(
                children: [
                  Expanded(child: _searchField()),
                  const SizedBox(width: 12),
                  _statusDropdown(),
                ],
              ),

              const SizedBox(height: 20),

              // ---------------- PROPOSAL CARDS ----------------
              _proposalCard(
                title: "Example Job 1111",
                price: "£12",
                days: "3 days",
                status: "PENDING",
                statusColor: Colors.orange,
              ),

              _proposalCard(
                title: "Dasdasd1111",
                price: "£2",
                days: "21 days",
                status: "COMPLETED",
                statusColor: Colors.green,
              ),

              _proposalCard(
                title: "This is job a786",
                price: "£12",
                days: "42 days",
                status: "COMPLETED",
                statusColor: Colors.green,
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // STATS ROW
  // ----------------------------------------------------------
  Widget _statsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _statBox("Total", "25"),
        _statBox("Active", "2"),
        _statBox("Completed", "18"),
        _statBox("Pending", "1"),
        _statBox("Earnings", "£5,891"),
      ],
    );
  }

  Widget _statBox(String title, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 8),
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
            Text(
              title,
              style: const TextStyle(color: Colors.black54, fontSize: 12),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // SEARCH BAR
  // ----------------------------------------------------------
  Widget _searchField() {
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
      child: const TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.black45),
          hintText: "Search job title...",
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // FILTER DROPDOWN
  // ----------------------------------------------------------
  Widget _statusDropdown() {
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
        child: DropdownButton<String>(
          value: "All Status",
          items: const [
            DropdownMenuItem(value: "All Status", child: Text("All Status")),
            DropdownMenuItem(value: "Pending", child: Text("Pending")),
            DropdownMenuItem(value: "Completed", child: Text("Completed")),
            DropdownMenuItem(value: "Active", child: Text("Active")),
          ],
          onChanged: (v) {},
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // PROPOSAL CARD
  // ----------------------------------------------------------
  Widget _proposalCard({
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
          // TITLE ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                days,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // PRICE + STATUS BADGE
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

          // BUTTONS ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _blueButton("View Proposal"),
              _outlineButton("View Job"),
            ],
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // BUTTONS
  // ----------------------------------------------------------
  Widget _blueButton(String label) {
    return Container(
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
    );
  }

  Widget _outlineButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black26),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
      ),
    );
  }
}