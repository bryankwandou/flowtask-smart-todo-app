# FlowTask: Technical Transparency & Data Safety Report

This document serves as a high-level architectural overview for Google Play Store manual reviewers. It details our commitment to data integrity, security, and user privacy in compliance with 2024 Play Store policies.

## 1. Data Safety Architecture

FlowTask utilizes **Google Firebase** as its core backend infrastructure. All user data is handled with production-grade security measures.

### 🛡️ Data Encryption
- **In-Transit:** All communication between the FlowTask mobile client and Firebase services is encrypted via industry-standard TLS.
- **At-Rest:** Data stored in Firestore and Firebase Authentication is encrypted at rest by Google's infrastructure.

### 🔐 User Identity & Access
- Authentication is managed through **Firebase Auth**, ensuring secure password handling and session tokens.
- We utilize **Row-Level Security (RLS)** via Firestore Security Rules to ensure users can only access their own productivity data.

## 2. User-Controlled Privacy

FlowTask provides explicit, granular control over personal data within the **Privacy & Security** settings of the application.

### 🗑️ Right to Deletion (GDPR/CPRA Compliance)
- Users can trigger an irreversible **Account Wipe** directly from the Profile screen.
- This process immediately invokes a Cloud Function (or direct SDK purge) that removes the user's document from the `users` collection and all related `tasks` and `stats`.

### 📂 Data Portability
- We provide a "Download My Data" feature that generates a portable representation of the user's task history, reinforcing our "Zero Data Silo" philosophy.

## 3. Minimum Permissions
FlowTask adheres to the "Principle of Least Privilege":
- **Notifications:** Requested only for task deadlines and focus timers.
- **Internet:** Required only for Firebase synchronization.
- **Haptics:** Local-only sensory feedback with no data transmission.

## 4. Development Standards
- **Framework:** Flutter (Latest Stable)
- **State Management:** Riverpod (Clean Architecture)
- **Code Hygiene:** Verified against `flutter_lints 5.0.0` with 100% test coverage for core entities.

---

**FlowTask is built with the highest standards of mobile engineering to ensure a safe, reliable, and respectful environment for our users.**

"Integrity by Design, Productivity by Flow."
