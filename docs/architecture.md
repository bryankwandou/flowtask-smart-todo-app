# System Architecture & Technical Flow

This document details the FlowTask architectural decisions and data flow logic.

## 1. Overall Architectural Model
**Client-Server Serverless Architecture**
- **Client:** Flutter Mobile Application (iOS/Android).
- **Backend:** Firebase (BaaS) providing Auth, Firestore, Cloud Functions.

## 2. Structural Layers (Clean Architecture in Flutter)

The `mobile_app/lib` directory is divided into domain-specific features rather than technical layers:
```text
lib/
 ├─ core/       # App-wide UI themes, constants, routing configuration.
 ├─ features/   # Divided by logical domain (auth, tasks, focus, analytics).
 ├─ services/   # Firebase interceptors, local database (Hive) wrappers.
 └─ widgets/    # Dumb, reusable app-wide UI components.
```
*Why this approach?* It allows features (like the focus timer and tasks) to evolve independently and scale safely as the codebase grows.

## 3. Database Schema Design (Firestore)

### `users` Collection
- Document ID: `uid` (from Firebase Auth)
- Fields:
  - `email` (string)
  - `displayName` (string)
  - `createdAt` (timestamp)
  - `subscriptionType` (string: "free" | "premium")
  - `timezone` (string)

### `tasks` Collection
- Document ID: Auto-generated
- Fields:
  - `taskId` (string)
  - `userId` (string, indexed for querying)
  - `title` (string)
  - `description` (string)
  - `priority` (integer: 1-low, 2-medium, 3-high)
  - `status` (string: "pending", "in_progress", "completed")
  - `deadline` (timestamp)
  - `createdAt` (timestamp)
  - `completedAt` (timestamp, nullable)

### `productivity_stats` Collection
*(Calculated offline or via Cloud Functions on task completion events)*
- Document ID: `userId`
- Fields:
  - `totalTasksCompleted` (integer)
  - `currentDailyStreak` (integer)
  - `longestStreak` (integer)
  - `mostProductiveHour` (integer: 0-23)
  - `weeklyCompletionRate` (float/percentage)

## 4. Logical Data Flow & State Management

**State Management Engine:** Riverpod (`flutter_riverpod`).
- We use Riverpod to inject dependencies (like Firestore repositories) into the UI seamlessly.

**Data Flow (Task Creation):**
1. **User Action:** Submits "New Task" form in Flutter UI.
2. **State Layer:** `TaskNotifier` validates data.
3. **Repository Layer:** `TaskRepository.createTask()` maps Dart objects to JSON.
4. **Network Layer:** Firebase SDK sends payload to `Firestore`.
5. **UI Update:** Firestore stream instantly updates the UI via Riverpod `.watch()`.

## 5. Background Operations & Notifications
- **Local:** Built-in Focus Timer uses `flutter_background_service` and standard isolated timers.
- **Remote:** Firebase Cloud Messaging (FCM) is triggered via Firebase Functions to remind users of due dates 1 hour before expiration.
