import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyActivityCard extends StatelessWidget {
  const WeeklyActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: const Color(0xFFEAECF0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.show_chart, size: 18, color: Color(0xFF101828)),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Weekly Activity",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF101828),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: LineChart(_chartData()),
          ),
        ],
      ),
    );
  }

  static LineChartData _chartData() {
    return LineChartData(
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 1,

      gridData: FlGridData(show: true),
      borderData: FlBorderData(show: true),

      titlesData: FlTitlesData(
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),

        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) {
              const days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
              final i = value.toInt();
              if (i < 0 || i > 6) return const SizedBox();
              return Text(days[i],
                  style: const TextStyle(fontSize: 10));
            },
          ),
        ),
      ),

      lineBarsData: [
        LineChartBarData(
          spots: List.generate(
              7, (index) => FlSpot(index.toDouble(), 0)),
          isCurved: false,
          color: Colors.blue,
          barWidth: 2,
          dotData: FlDotData(show: true),
        ),
      ],
    );
  }
}