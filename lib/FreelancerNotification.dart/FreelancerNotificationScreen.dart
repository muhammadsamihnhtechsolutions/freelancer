// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:freelancer_app/FreelancerNotification.dart/FreelancerNotificationController.dart';

// class FreelancerNotificationScreen extends StatelessWidget {

//   final controller = Get.put(FreelancerNotificationController());

//   FreelancerNotificationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     print("🖥️ Notification Screen Build");

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Notifications"),
//         actions: [

//           // 🔔 Unread Count
//           Obx(() {
//             final count = controller.unreadCount;

//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Center(
//                 child: Text(
//                   "Unread: $count",
//                   style: const TextStyle(fontSize: 14),
//                 ),
//               ),
//             );
//           }),

//           // ✅ Mark All Read
//           IconButton(
//             icon: const Icon(Icons.done_all),
//             onPressed: () {
//               print("🟣 UI: MARK ALL CLICKED");
//               controller.markAllRead();
//             },
//           )
//         ],
//       ),

//       // 🔄 Pull to refresh
//       body: Obx(() {
//         print("🔄 UI REBUILD");

//         return RefreshIndicator(
//           onRefresh: () async {
//             print("🔄 PULL TO REFRESH");
//             await controller.fetchNotifications();
//           },
//           child: _buildBody(),
//         );
//       }),
//     );
//   }

//   Widget _buildBody() {
//     // ⏳ Loading
//     if (controller.isLoading.value) {
//       print("⏳ LOADING...");
//       return const Center(child: CircularProgressIndicator());
//     }

//     // 📭 Empty State
//     if (controller.notifications.isEmpty) {
//       print("📭 NO NOTIFICATIONS");
//       return ListView(
//         physics: const AlwaysScrollableScrollPhysics(),
//         children: const [
//           SizedBox(height: 200),
//           Center(
//             child: Text(
//               "No Notifications",
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//         ],
//       );
//     }

//     // 📃 List
//     return ListView.builder(
//       physics: const AlwaysScrollableScrollPhysics(),
//       itemCount: controller.notifications.length,
//       itemBuilder: (context, index) {
//         final notif = controller.notifications[index];

//         return Container(
//           margin: const EdgeInsets.symmetric(
//             horizontal: 10,
//             vertical: 6,
//           ),
//           padding: const EdgeInsets.symmetric(vertical: 4),
//           decoration: BoxDecoration(
//             color: notif.isRead
//                 ? Colors.white
//                 : Colors.blue.shade50,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.grey.shade200),
//           ),
//           child: ListTile(
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 12,
//               vertical: 6,
//             ),

//             title: Text(
//               notif.title,
//               style: TextStyle(
//                 fontWeight: notif.isRead
//                     ? FontWeight.normal
//                     : FontWeight.bold,
//               ),
//             ),

//             // 🔴 Unread dot
//             trailing: notif.isRead
//                 ? null
//                 : const Icon(
//                     Icons.circle,
//                     size: 10,
//                     color: Colors.blue,
//                   ),

//             onTap: () async {
//               print("🟢 UI CLICK → ID: ${notif.id}");

//               await controller.markAsRead(notif.id);

//               final link = notif.extra?['link'];

//               if (link != null && link.toString().isNotEmpty) {
//                 print("➡️ NAVIGATE → $link");
//                 Get.toNamed(link);
//               } else {
//                 print("⚠️ NO LINK FOUND");
//               }
//             },
//           ),
//         );
//       },
//     );
//   }
// }
// // 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:freelancer_app/FreelancerNotification.dart/FreelancerNotificationController.dart';

class FreelancerNotificationScreen extends StatelessWidget {

  final controller = Get.put(FreelancerNotificationController());

  FreelancerNotificationScreen({super.key});

  String getGroup(DateTime date) {
    final now = DateTime.now();

    if (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year) {
      return "Today";
    }

    if (date.day ==
            now.subtract(const Duration(days: 1)).day &&
        date.month == now.month &&
        date.year == now.year) {
      return "Yesterday";
    }

    return "Older";
  }

  @override
  Widget build(BuildContext context) {
    print("📲 OPEN FREELANCER NOTIFICATION PAGE");

    return Scaffold(
      backgroundColor: const Color(0xfff6f7fb),

      appBar: AppBar(
        title: const Text("Notifications"),
      ),

      body: Obx(() {
        print("📡 STATE UPDATE");

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.notifications.isEmpty) {
          return const Center(
            child: Text("No Notifications"),
          );
        }

        /// GROUPING
        final Map<String, List> grouped = {};

        for (var n in controller.notifications) {
          final group = getGroup(
            DateTime.parse(n.extra?['created_at'] ?? DateTime.now().toString()),
          );

          grouped.putIfAbsent(group, () => []);
          grouped[group]!.add(n);
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: grouped.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// GROUP TITLE
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    entry.key,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                ...entry.value.map((notif) {
                  return _AnimatedCard(
                    notif: notif,
                    controller: controller,
                  );
                }).toList()
              ],
            );
          }).toList(),
        );
      }),
    );
  }
}

class _AnimatedCard extends StatefulWidget {
  final dynamic notif;
  final FreelancerNotificationController controller;

  const _AnimatedCard({
    required this.notif,
    required this.controller,
  });

  @override
  State<_AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<_AnimatedCard>
    with SingleTickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<double> fade;
  late Animation<Offset> slide;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    fade = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );

    slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(animationController);

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  IconData getIcon(String? type) {
    switch (type) {
      case "proposal_status":
        return Icons.work_outline;
      case "job_completed":
        return Icons.check_circle_outline;
      default:
        return Icons.notifications_none;
    }
  }

  @override
  Widget build(BuildContext context) {
    final n = widget.notif;

    return FadeTransition(
      opacity: fade,
      child: SlideTransition(
        position: slide,

        child: Dismissible(
          key: Key(n.id),

          onDismissed: (_) {
            print("👉 SWIPE READ → ${n.id}");
            widget.controller.markAsRead(n.id);
          },

          background: Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.done, color: Colors.white),
          ),

          child: Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: n.isRead
                  ? Colors.white
                  : Colors.blue.withOpacity(.08),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  blurRadius: 8,
                )
              ],
            ),

            child: Row(
              children: [

                /// ICON
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(getIcon(n.extra?['type']), color: Colors.blue),
                ),

                const SizedBox(width: 12),

                /// TEXT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        n.title,
                        style: TextStyle(
                          fontWeight: n.isRead
                              ? FontWeight.normal
                              : FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      if (!n.isRead)
                        const Text(
                          "New",
                          style: TextStyle(fontSize: 11),
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
