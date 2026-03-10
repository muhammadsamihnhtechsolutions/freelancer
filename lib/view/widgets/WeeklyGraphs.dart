import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_app/graphweeklyrecntlyclient.dart/GraphActivityController.dart';
import 'package:get/get.dart';

class WeeklyActivityCard extends StatelessWidget {
  WeeklyActivityCard({super.key});

  final controller = Get.find<GraphActivityController>();

  @override
  Widget build(BuildContext context) {

    print("📊 WeeklyActivityCard BUILD CALLED");

    return Obx(() {

      print("📈 Weekly Graph Data → ${controller.weeklyGraph}");

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

            /// TITLE
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

            const SizedBox(height: 14),

            /// CHART
            SizedBox(
              height: 180,
              child: LineChart(_chartData()),
            ),
          ],
        ),
      );
    });
  }

  LineChartData _chartData() {

    print("📊 Preparing chart data...");

    return LineChartData(
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: _maxY(),

      /// GRID
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 1,
      ),

      /// BORDER
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xFFE4E7EC)),
      ),

      /// TITLES
      titlesData: FlTitlesData(
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),

        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) {

              const days = [
                "Sun",
                "Mon",
                "Tue",
                "Wed",
                "Thu",
                "Fri",
                "Sat"
              ];

              final i = value.toInt();

              if (i < 0 || i > 6) {
                return const SizedBox();
              }

              return Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  days[i],
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF667085),
                  ),
                ),
              );
            },
          ),
        ),
      ),

      /// LINE DATA
      lineBarsData: [
        LineChartBarData(
          spots: _generateSpots(),

          isCurved: true,
          color: const Color(0xFF2970FF),
          barWidth: 3,

          dotData: FlDotData(show: true),

          belowBarData: BarAreaData(
            show: true,
            color: const Color(0xFF2970FF).withOpacity(0.15),
          ),
        ),
      ],
    );
  }

  List<FlSpot> _generateSpots() {

    List<FlSpot> spots = List.generate(
      7,
      (index) {

        final value = controller.weeklyGraph.length > index
            ? controller.weeklyGraph[index]
            : 0;

        print("📍 Spot → Day: $index  Value: $value");

        return FlSpot(
          index.toDouble(),
          value.toDouble(),
        );
      },
    );

    return spots;
  }

  double _maxY() {

    if (controller.weeklyGraph.isEmpty) {

      print("⚠️ weeklyGraph empty → maxY = 5");

      return 5;
    }

    final maxValue =
        controller.weeklyGraph.reduce((a, b) => a > b ? a : b);

    print("📊 Max weekly value → $maxValue");

    if (maxValue == 0) {

      print("⚠️ All values 0 → maxY = 5");

      return 5;
    }

    final result = maxValue.toDouble() + 2;

    print("📈 Final maxY → $result");

    return result;
  }
}