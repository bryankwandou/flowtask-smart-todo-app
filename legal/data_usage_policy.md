# Data Usage Policy

**How FlowTask Handles Your Data**

At FlowTask, we believe in transparency. This policy outlines exactly how your data flows through our infrastructure.

## 1. Data Flow Overview
1.  **Input:** User creates a task in the Flutter App.
2.  **Storage:** Task is encrypted and synced to **Firebase Cloud Firestore**.
3.  **Processing:** **Firebase Cloud Functions** analyze task completion speed once a day.
4.  **Feedback:** Results are displayed in the "Intelligence" tab of the App.

## 2. Infrastructure Details
All data is hosted on **Google Firebase (GCP)**. We benefit from Google's high-level security infrastructure, including:
*   End-to-end encryption (TLS).
*   Data redundacy across server clusters.
*   Strict IAM (Identity and Access Management) controls.

## 3. Analytics Usage
We use **Firebase Analytics** to understand:
*   Which features are most popular.
*   Where users encounter friction in the UI.
*   App stability and crash rates.
*No personally identifiable information (PII) is sold to third parties.*

## 4. Permission Usage
*   **Notifications:** Used for task reminders and focus alerts.
*   **Internet Access:** Required for cloud synchronization.
*   **Background Tasks:** Required to maintain the Focus Timer persistence.

## 5. Your Choices
You can opt-out of notifications via system settings. You can purge all data by deleting your account within the app.

---
**FlowTask Team**
*Focusing on your privacy.*
