import 'package:flutter/material.dart';
import 'package:freelancer_app/theme/AppColors.dart';

class ProposalDetailsView extends StatelessWidget {
  const ProposalDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Proposal Details",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Manage your proposal efficiently",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 18),

            // USER CARD
            _userInfoCard(),

            const SizedBox(height: 18),

            // BID INFO
            Row(
              children: [
                Expanded(child: _infoTile("Bid Amount", "£12.00", Icons.attach_money)),
                const SizedBox(width: 12),
                Expanded(child: _infoTile("Delivery", "3 days", Icons.access_time)),
              ],
            ),

            const SizedBox(height: 22),

            // COVER LETTER SECTION
            const Text(
              "Cover Letter",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                "Aenean aliquam orci eu nisl varius feugiat.",
                style: TextStyle(color: Colors.black87),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // -------------------- UI COMPONENTS -----------------------

  Widget _userInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 26,
            backgroundColor: AppColors.primaryStart,
            child: const Text(
              "Ar",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Name + Email
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Abdul Rahim",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "abdulraheem9425@gmail.com",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // STATUS BADGE
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryEnd.withOpacity(0.18),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "SUBMITTED",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.primaryStart,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTile(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primaryStart),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                    fontWeight: FontWeight.w900, fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}