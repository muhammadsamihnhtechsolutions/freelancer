import 'package:freelancer_app/FreelancerNotification.dart/FreelancerNotificationModel.dart';
import 'package:freelancer_app/service/Repo.dart';
import 'package:get/get.dart';

class FreelancerNotificationController extends GetxController {

  var notifications = <NotificationModel>[].obs;
  var isLoading = false.obs;

  // ---------------- INIT ----------------
  @override
  void onInit() {
    print("=================================");
    print("🚀 FreelancerNotificationController INIT");
    print("=================================");
    fetchNotifications();
    super.onInit();
  }

  // ---------------- FETCH ----------------
  Future<void> fetchNotifications() async {
    try {
      print("=================================");
      print("🔵 CONTROLLER: FETCH NOTIFICATIONS START");
      print("=================================");

      isLoading.value = true;

      final res = await FreelancerSideNotificationRepo.fetchNotifications();

      print("⬇️ CONTROLLER RESPONSE → $res");

      // ✅ FIXED RESPONSE HANDLING
      if (res != null && res['data'] != null) {

        final List dataList = res['data'];

        print("📦 RAW DATA LENGTH → ${dataList.length}");

        final data = dataList.map((e) {
          print("📥 PARSING ITEM → $e");
          return NotificationModel.fromJson(e);
        }).toList();

        notifications.assignAll(data);

        print("✅ NOTIFICATIONS LOADED → ${notifications.length}");

      } else {
        print("⚠️ INVALID RESPONSE FORMAT");
      }

    } catch (e) {
      print("❌ FETCH ERROR → $e");
    } finally {
      isLoading.value = false;

      print("🔚 FETCH COMPLETE");
      print("=================================");
    }
  }

  // ---------------- MARK SINGLE READ ----------------
  Future<void> markAsRead(String id) async {
    try {
      print("=================================");
      print("🟢 MARK AS READ START");
      print("➡️ ID → $id");
      print("=================================");

      await FreelancerSideNotificationRepo.markNotificationRead(id as int);

      final index = notifications.indexWhere((n) => n.id == id);

      if (index != -1) {
        final old = notifications[index];

        notifications[index] = NotificationModel(
          id: old.id,
          title: old.title,
          isRead: true,
          extra: old.extra,
        );

        notifications.refresh();

        print("✅ MARKED AS READ → $id");
      } else {
        print("⚠️ NOTIFICATION NOT FOUND");
      }

    } catch (e) {
      print("❌ MARK READ ERROR → $e");
    } finally {
      print("🔚 MARK READ COMPLETE");
      print("=================================");
    }
  }

  // ---------------- MARK ALL READ ----------------
  Future<void> markAllRead() async {
    try {
      print("=================================");
      print("🟣 MARK ALL AS READ START");
      print("=================================");

      await FreelancerSideNotificationRepo.markAllNotificationsRead();

      notifications.value = notifications.map((n) {
        return NotificationModel(
          id: n.id,
          title: n.title,
          isRead: true,
          extra: n.extra,
        );
      }).toList();

      print("✅ ALL NOTIFICATIONS MARKED AS READ");

    } catch (e) {
      print("❌ MARK ALL ERROR → $e");
    } finally {
      print("🔚 MARK ALL COMPLETE");
      print("=================================");
    }
  }

  // ---------------- UNREAD COUNT ----------------
  int get unreadCount {
    final count = notifications.where((n) => !n.isRead).length;

    print("🔔 UNREAD COUNT → $count");

    return count;
  }
}
