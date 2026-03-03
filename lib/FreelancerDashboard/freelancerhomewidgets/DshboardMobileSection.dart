import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardMobileSection extends StatelessWidget {
  const DashboardMobileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _proposalActivityCard(),
        const SizedBox(height: 16),
        _profileStrengthCard(),
      ],
    );
  }

  // -------------------------
  // Proposal Activity (Real Graph)
  // -------------------------
  Widget _proposalActivityCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          Row(
            children: const [
              Icon(Icons.insert_chart, size: 18),
              SizedBox(width: 6),
              Text(
                "Proposal Activity",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // REAL GRAPH USING fl_chart
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                titlesData: FlTitlesData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 5),
                      FlSpot(1, 4),
                      FlSpot(2, 3),
                      FlSpot(3, 2),
                      FlSpot(4, 1),
                    ],
                    isCurved: false,
                    color: const Color(0xFF5A5BFF),
                    barWidth: 2,
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF5A5BFF).withOpacity(0.15),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------
  // Profile Strength (Fixed)
  // -------------------------
  Widget _profileStrengthCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "Profile Strength",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 14),

          // FIXED PERFECT CENTERED CIRCLE
          
          SizedBox(
            height: 120,
            width: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
           Transform.scale(
  scale: 1.4, // ← inner circle ko bada karta hai (increase this value)
  child: CircularProgressIndicator(
    value: 0.75,
    strokeWidth: 10,
    backgroundColor: Colors.grey.shade200,
    valueColor: const AlwaysStoppedAnimation(Color(0xFF5A5BFF)),
  ),
),
                const Text(
                  "100%",
                  style: TextStyle(
                      fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),


          const SizedBox(height: 10),

          Text(
            "Complete profile →",
            style: TextStyle(
              color: Colors.indigo.shade600,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}