import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reminderServiceProvider = Provider<ReminderService>((ref) {
  return ReminderService();
});

class ReminderService {
  ReminderService() {
    _requestPermissions();
  }

  void _requestPermissions() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  Future<void> scheduleTaskReminder({
    required String taskId,
    required String title,
    required DateTime deadline,
  }) async {
    // Schedule 30 minutes before deadline
    final scheduleTime = deadline.subtract(const Duration(minutes: 30));

    // If scheduled time is in the past, don't schedule
    if (scheduleTime.isBefore(DateTime.now())) return;

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: taskId.hashCode,
        channelKey: 'task_reminders',
        title: 'Upcoming Task: $title',
        body: 'Your task is due in 30 minutes. Stay focused!',
        notificationLayout: NotificationLayout.Default,
        category: NotificationCategory.Reminder,
        payload: {'taskId': taskId},
      ),
      schedule: NotificationCalendar.fromDate(date: scheduleTime),
    );
  }

  Future<void> cancelReminder(String taskId) async {
    await AwesomeNotifications().cancel(taskId.hashCode);
  }
}
