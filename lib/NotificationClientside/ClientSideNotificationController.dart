// import 'package:freelancer_app/NotificationClientside/NotificationModel.dart';
// import 'package:freelancer_app/service/Repo.dart';
// import 'package:get/get.dart';


// class ClientSideNotificationController extends GetxController {

//   RxBool loading = false.obs;
//   RxList<ClientNotificationModel> notifications =
//       <ClientNotificationModel>[].obs;

//   RxInt unreadCount = 0.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchNotifications();
//   }

//   Future<void> fetchNotifications() async {

//     try {

//       print("=================================");
//       print("🔵 CONTROLLER → FETCH NOTIFICATIONS");
//       print("=================================");

//       loading.value = true;

//       final res =
//           await ClientSideNotificationRepo.fetchNotifications();

//       if (res != null && res["success"] == true) {

//         final data = res["data"] as List;

//         notifications.value =
//             data.map((e) =>
//                 ClientNotificationModel.fromJson(e)).toList();

//         unreadCount.value =
//             notifications.where((n) => n.isRead == 0).length;

//         print("✅ TOTAL NOTIFICATIONS → ${notifications.length}");
//         print("🔔 UNREAD COUNT → ${unreadCount.value}");

//       } else {

//         print("❌ NOTIFICATION API FAILED");
//       }

//     } catch (e) {

//       print("❌ NOTIFICATION CONTROLLER ERROR → $e");

//     } finally {

//       loading.value = false;
//       print("🟢 LOADING FALSE");
//       print("=================================");
//     }
//   }
// }

import 'package:freelancer_app/NotificationClientside/NotificationModel.dart';
import 'package:freelancer_app/service/Repo.dart';
import 'package:get/get.dart';

class ClientSideNotificationController extends GetxController {

  RxBool loading = false.obs;

  RxList<ClientNotificationModel> notifications =
      <ClientNotificationModel>[].obs;

  RxInt unreadCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  /// ===============================
  /// FETCH NOTIFICATIONS
  /// ===============================
  Future<void> fetchNotifications() async {

    try {

      print("=================================");
      print("🔵 CONTROLLER → FETCH NOTIFICATIONS");
      print("=================================");

      loading.value = true;

      final res =
          await ClientSideNotificationRepo.fetchNotifications();

      if (res != null && res["success"] == true) {

        final data = res["data"] as List;

        notifications.value =
            data.map((e) =>
                ClientNotificationModel.fromJson(e)).toList();

        unreadCount.value =
            notifications.where((n) => n.isRead == 0).length;

        print("✅ TOTAL NOTIFICATIONS → ${notifications.length}");
        print("🔔 UNREAD COUNT → ${unreadCount.value}");

      } else {

        print("❌ NOTIFICATION API FAILED");
      }

    } catch (e) {

      print("❌ NOTIFICATION CONTROLLER ERROR → $e");

    } finally {

      loading.value = false;
      print("🟢 LOADING FALSE");
      print("=================================");
    }
  }

  /// ===============================
  /// MARK AS READ (MODEL SAFE VERSION)
  /// ===============================
  void markAsRead(String notificationId) {

    try {

      print("=================================");
      print("📖 MARK AS READ START");
      print("➡️ ID → $notificationId");
      print("=================================");

      final index =
          notifications.indexWhere((n) => n.id == notificationId);

      if (index == -1) {

        print("❌ NOTIFICATION NOT FOUND");
        return;
      }

      final oldNotification = notifications[index];

      if (oldNotification.isRead == 1) {

        print("ℹ️ ALREADY READ");
        return;
      }

      /// CREATE UPDATED OBJECT (Because fields are final)
      final updatedNotification = ClientNotificationModel(
        id: oldNotification.id,
        userId: oldNotification.userId,
        userRole: oldNotification.userRole,
        type: oldNotification.type,
        message: oldNotification.message,
        referenceId: oldNotification.referenceId,
        isRead: 1,
        createdAt: oldNotification.createdAt,
      );

      /// REPLACE IN LIST
      notifications[index] = updatedNotification;
      notifications.refresh();

      /// UPDATE UNREAD COUNT
      unreadCount.value =
          notifications.where((n) => n.isRead == 0).length;

      print("✅ MARKED AS READ SUCCESS");
      print("🔔 NEW UNREAD COUNT → ${unreadCount.value}");

      /// OPTIONAL: Backend API call yahan laga sakte ho
      // await ClientSideNotificationRepo.markAsRead(notificationId);

    } catch (e) {

      print("❌ MARK AS READ ERROR → $e");
    }
  }
}