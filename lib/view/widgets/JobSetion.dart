import 'package:flutter/material.dart';

class JobsEmptyStateWidget extends StatefulWidget {
  const JobsEmptyStateWidget({super.key});

  @override
  State<JobsEmptyStateWidget> createState() => _JobsEmptyStateWidgetState();
}

class _JobsEmptyStateWidgetState extends State<JobsEmptyStateWidget> {
  int selectedIndex = 1; // 0=All, 1=Open, 2=Closed

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FilterTabs(
          selectedIndex: selectedIndex,
          onChanged: (i) => setState(() => selectedIndex = i),
        ),
        const SizedBox(height: 14),
        _EmptyJobsCard(
          onPostJob: () {
            // TODO: navigate to Post Job screen
          },
        ),
      ],
    );
  }
}

/// -------------------------
/// FILTER TABS (All/Open/Closed)
/// -------------------------
class _FilterTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _FilterTabs({
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final labels = const ["All", "Open", "Closed"];

    return Wrap(
      spacing: 10,
      children: List.generate(labels.length, (i) {
        final isActive = selectedIndex == i;
        return InkWell(
          onTap: () => onChanged(i),
          borderRadius: BorderRadius.circular(20),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF2F6BFF) : const Color(0xFFF2F4F7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              labels[i],
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : const Color(0xFF344054),
              ),
            ),
          ),
        );
      }),
    );
  }
}

/// -------------------------
/// EMPTY CARD (No jobs yet + button)
/// -------------------------
class _EmptyJobsCard extends StatelessWidget {
  final VoidCallback onPostJob;

  const _EmptyJobsCard({required this.onPostJob});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon ($)
          Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F4F7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "\$",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF475467),
              ),
            ),
          ),
          const SizedBox(height: 10),

          const Text(
            "No jobs yet",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF101828),
            ),
          ),
          const SizedBox(height: 6),

          const Text(
            "Post a job to start hiring top talent.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              height: 1.3,
              color: Color(0xFF667085),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),

          // + Post Job Button
          ElevatedButton.icon(
            onPressed: onPostJob,
            icon: const Icon(Icons.add, size: 18),
            label: const Text("Post Job"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F6BFF),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              textStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}