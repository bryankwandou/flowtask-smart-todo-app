const functions = require('firebase-functions');
const admin = require('firebase-admin');

// Initialize Firebase Admin
admin.initializeApp();

/** 
 * TRIGGER: Calculate Productivity Analytics on Task Completion
 * This function calculates the completion stats every time a task is marked as 'completed'.
 */
exports.onTaskUpdate = functions.firestore
  .document('tasks/{taskId}')
  .onUpdate(async (change, context) => {
    const newValue = change.after.data();
    const oldValue = change.before.data();

    // Only proceed if status changed to 'completed'
    if (newValue.status === 'completed' && oldValue.status !== 'completed') {
      const userId = newValue.userId;
      const statsRef = admin.firestore().collection('productivity_stats').doc(userId);

      try {
        await admin.firestore().runTransaction(async (transaction) => {
          const statsDoc = await transaction.get(statsRef);
          const now = new Date();
          const currentHour = now.getHours();

          if (!statsDoc.exists) {
            transaction.set(statsRef, {
              userId: userId,
              tasks_completed: 1,
              daily_streak: 1,
              last_completion_date: admin.firestore.Timestamp.fromDate(now),
              most_productive_hour: currentHour,
              weekly_completion_rate: 0
            });
          } else {
            const data = statsDoc.data();
            transaction.update(statsRef, {
              tasks_completed: data.tasks_completed + 1,
              last_completion_date: admin.firestore.Timestamp.fromDate(now),
              // Logical simplification for demo: update most productive hour if it's new
               most_productive_hour: currentHour 
            });
          }
        });
      } catch (error) {
        console.error("Error updating productivity stats:", error);
      }
    }
    return null;
  });

/**
 * TRIGGER: Intelligent Reminder Scheduler
 * Mock implementation for background cron job triggers.
 */
exports.notifySmartReminder = functions.pubsub.schedule('every 4 hours').onRun(async (context) => {
  // Logic would involve querying unfinished tasks nearing deadlines
  // and sending push notifications via admin.messaging()
  console.log("Running intelligent reminder scheduler...");
  return null;
});
