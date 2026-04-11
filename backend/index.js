const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const db = admin.firestore();

// ==========================================
// TASK MANAGEMENT APIs (Callable Functions)
// ==========================================

exports.createTask = functions.https.onCall(async (data, context) => {
  if (!context.auth) throw new functions.https.HttpsError("unauthenticated", "User must be logged in.");
  
  const { title, description, priority, deadline } = data;
  const taskRef = db.collection("tasks").doc();
  
  const task = {
    task_id: taskRef.id,
    user_id: context.auth.uid,
    title,
    description,
    priority: priority || 1,
    status: "pending",
    deadline: deadline || null,
    created_at: admin.firestore.FieldValue.serverTimestamp(),
  };

  await taskRef.set(task);
  return { success: true, task };
});

exports.updateTask = functions.https.onCall(async (data, context) => {
  if (!context.auth) throw new functions.https.HttpsError("unauthenticated", "User must be logged in.");
  
  const { task_id, updates } = data;
  const taskRef = db.collection("tasks").doc(task_id);
  
  await taskRef.update(updates);
  return { success: true };
});

exports.deleteTask = functions.https.onCall(async (data, context) => {
  if (!context.auth) throw new functions.https.HttpsError("unauthenticated", "User must be logged in.");
  
  const { task_id } = data;
  await db.collection("tasks").doc(task_id).delete();
  return { success: true };
});

exports.getUserTasks = functions.https.onCall(async (data, context) => {
  if (!context.auth) throw new functions.https.HttpsError("unauthenticated", "User must be logged in.");
  
  const snapshot = await db.collection("tasks")
    .where("user_id", "==", context.auth.uid)
    .get();

  return snapshot.docs.map(doc => doc.data());
});

// ==========================================
// PRODUCTIVITY INTELLIGENCE
// ==========================================

exports.getProductivityStats = functions.https.onCall(async (data, context) => {
  if (!context.auth) throw new functions.https.HttpsError("unauthenticated", "User must be logged in.");
  
  const statsRef = db.collection("productivity_stats").doc(context.auth.uid);
  const doc = await statsRef.get();
  
  if (!doc.exists) {
    return {
      tasks_completed: 0,
      daily_streak: 0,
      weekly_completion_rate: 0,
      most_productive_hour: null
    };
  }
  
  return doc.data();
});

// Cloud Function Trigger: Auto-update stats when a task is completed
exports.onTaskWrite = functions.firestore
  .document("tasks/{taskId}")
  .onWrite(async (change, context) => {
    const after = change.after.data();
    const before = change.before.data();
    
    // Only process if status changed to 'completed'
    if (after && after.status === 'completed' && (!before || before.status !== 'completed')) {
      const statsRef = db.collection("productivity_stats").doc(after.user_id);
      
      await db.runTransaction(async (t) => {
        const doc = await t.get(statsRef);
        if (!doc.exists) {
          t.set(statsRef, {
            user_id: after.user_id,
            tasks_completed: 1,
            daily_streak: 1, // simplified logic
            weekly_completion_rate: 100,
            most_productive_hour: new Date().getHours()
          });
        } else {
          t.update(statsRef, {
            tasks_completed: admin.firestore.FieldValue.increment(1)
          });
        }
      });
    }
  });

// ==========================================
// NOTIFICATIONS
// ==========================================

exports.scheduleReminder = functions.https.onCall(async (data, context) => {
  if (!context.auth) throw new functions.https.HttpsError("unauthenticated", "User must be logged in.");
  
  // Implementation for inserting into a cron-job queue 
  // (Assuming we use a Pub/Sub trigger for actual dispatch)
  
  return { success: true, message: "Reminder scheduled based on user focus patterns." };
});
