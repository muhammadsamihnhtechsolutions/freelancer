// import 'package:flutter/material.dart';
// import 'package:freelancer_app/NotificationClientside/NotificationModel.dart';
// import 'package:get/get.dart';
// import 'ClientSideNotificationController.dart';


// class cleintsidenotification extends StatelessWidget {

//   const cleintsidenotification({super.key});

//   @override
//   Widget build(BuildContext context) {

//     final controller =
//         Get.put(ClientSideNotificationController());

//     return Scaffold(
//       backgroundColor: const Color(0xfff5f6fa),

//       appBar: AppBar(
//         title: const Text("Notifications"),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),

//       body: Obx(() {

//         if (controller.loading.value) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }

//         if (controller.notifications.isEmpty) {
//           return const Center(
//             child: Text("No notifications yet"),
//           );
//         }

//         return ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: controller.notifications.length,
//           itemBuilder: (context, index) {

//             final notification =
//                 controller.notifications[index];

//             return _NotificationCard(notification);
//           },
//         );
//       }),
//     );
//   }
// }
// class _NotificationCard extends StatelessWidget {

//   final ClientNotificationModel notification;

//   const _NotificationCard(this.notification);

//   @override
//   Widget build(BuildContext context) {

//     print("🔔 BUILDING NOTIFICATION → ${notification.id}");

//     return Container(
//       margin: const EdgeInsets.only(bottom: 14),
//       padding: const EdgeInsets.all(16),

//       decoration: BoxDecoration(
//         color: notification.isRead == 0
//             ? const Color(0xffeef2ff)
//             : Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(.05),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           )
//         ],
//       ),

//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [

//           /// TYPE BADGE
//           Row(
//             children: [

//               Container(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 10, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   notification.type.toUpperCase(),
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 11,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),

//               const Spacer(),

//               Text(
//                 "${notification.createdAt.hour}:${notification.createdAt.minute}",
//                 style: const TextStyle(
//                   fontSize: 12,
//                   color: Colors.black45,
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 10),

//           /// MESSAGE
//           Text(
//             notification.message,
//             style: const TextStyle(
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:freelancer_app/NotificationClientside/NotificationModel.dart';
import 'package:freelancer_app/theme/AppColors.dart';
import 'ClientSideNotificationController.dart';

class ClientSideNotificationPage extends StatelessWidget {
  const ClientSideNotificationPage({super.key});

  String getGroup(DateTime date) {
    final now = DateTime.now();

    if (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year) {
      return "Today";
    }

    if (date.day == now.subtract(const Duration(days: 1)).day &&
        date.month == now.month &&
        date.year == now.year) {
      return "Yesterday";
    }

    return "Older";
  }

  @override
  Widget build(BuildContext context) {
    print("📲 OPEN CLIENT NOTIFICATION PAGE");

    final controller = Get.put(ClientSideNotificationController());

    return Scaffold(
      backgroundColor: const Color(0xfff6f7fb),

      appBar: AppBar(
        title: const Text("Notifications"),
      ),

      body: Obx(() {
        print("📡 NOTIFICATION STATE UPDATE");

        if (controller.loading.value) {
          print("⏳ LOADING NOTIFICATIONS...");
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.notifications.isEmpty) {
          print("⚠️ NO NOTIFICATIONS FOUND");
          return const Center(
            child: Text(
              "No notifications yet",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          );
        }

        final Map<String, List<ClientNotificationModel>> grouped = {};

        for (var n in controller.notifications) {
          final group = getGroup(n.createdAt);

          if (!grouped.containsKey(group)) {
            grouped[group] = [];
          }

          grouped[group]!.add(n);
        }

        print("📦 GROUPED NOTIFICATIONS → ${grouped.keys}");

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
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryStart,
                    ),
                  ),
                ),

                ...entry.value.map((notification) {
                  return AnimatedNotificationCard(
                    notification: notification,
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

class AnimatedNotificationCard extends StatefulWidget {
  final ClientNotificationModel notification;
  final ClientSideNotificationController controller;

  const AnimatedNotificationCard({
    super.key,
    required this.notification,
    required this.controller,
  });

  @override
  State<AnimatedNotificationCard> createState() =>
      _AnimatedNotificationCardState();
}

class _AnimatedNotificationCardState extends State<AnimatedNotificationCard>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();

    print("🎬 START CARD ANIMATION → ${widget.notification.id}");

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    fadeAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);

    slideAnimation = Tween<Offset>(
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

  IconData _getIcon() {
    switch (widget.notification.type) {
      case "proposal_status":
        return Icons.work_outline;

      case "message":
        return Icons.chat_bubble_outline;

      case "payment":
        return Icons.attach_money;

      case "job":
        return Icons.business_center_outlined;

      default:
        return Icons.notifications_none;
    }
  }

  Color _getIconColor() {
    switch (widget.notification.type) {
      case "proposal_status":
        return Colors.orange;

      case "message":
        return Colors.blue;

      case "payment":
        return Colors.green;

      case "job":
        return Colors.purple;

      default:
        return AppColors.primaryStart;
    }
  }

  @override
  Widget build(BuildContext context) {
    final notification = widget.notification;

    print("🔔 RENDER CARD → ${notification.message}");

    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,

        child: Dismissible(
          key: Key(notification.id),

          direction: DismissDirection.startToEnd,

          onDismissed: (_) {
            print("👉 SWIPE MARK READ → ${notification.id}");

            widget.controller.markAsRead(notification.id);
          },

          background: Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.only(left: 20),

            alignment: Alignment.centerLeft,

            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(18),
            ),

            child: const Icon(
              Icons.done,
              color: Colors.white,
              size: 26,
            ),
          ),

          child: Container(
            margin: const EdgeInsets.only(bottom: 14),

            decoration: BoxDecoration(
              gradient: notification.isRead == 0
                  ? LinearGradient(
                      colors: [
                        AppColors.primaryStart.withOpacity(.08),
                        Colors.white,
                      ],
                    )
                  : null,
              color: notification.isRead == 1 ? Colors.white : null,

              borderRadius: BorderRadius.circular(18),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.06),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),

            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ICON
                  Container(
                    height: 44,
                    width: 44,

                    decoration: BoxDecoration(
                      color: _getIconColor().withOpacity(.12),
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Icon(
                      _getIcon(),
                      color: _getIconColor(),
                      size: 22,
                    ),
                  ),

                  const SizedBox(width: 14),

                  /// CONTENT
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// TYPE + TIME
                        Row(
                          children: [
                            Text(
                              notification.type
                                  .replaceAll("_", " ")
                                  .toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryStart,
                                letterSpacing: .5,
                              ),
                            ),

                            const Spacer(),

                            Text(
                              "${notification.createdAt.hour}:${notification.createdAt.minute}",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        /// MESSAGE
                        Text(
                          notification.message,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.4,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 6),

                        if (notification.isRead == 0)
                          Row(
                            children: [
                              Container(
                                height: 8,
                                width: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryStart,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                "New",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}