# Data Usage Policy

## Core Principle
Your tasks and your productivity data belong to you. Our use of data is strictly limited to making the FlowTask experience better for you.

## 1. Firebase Processing
FlowTask uses Google's Firebase infrastructure. Your data is synchronized to the cloud (Firestore) to enable multi-device sync, analytics computation via Cloud Functions, and safe backups. App analytics are collected to track crashes and user engagement metrics (DAU/MAU).

## 2. Focus & Analytics Data
The productivity insights presented to you (such as "Most Productive Hour" or "Completion Streak") are calculated securely in the cloud. These statistics are not sold to marketing agencies or third-party data brokers.

## 3. Communication
Push notifications (via FCM) rely on device tokens. We do not use localized GPS tracking to send notifications; all reminders are strictly time-based relying on your device's timezone settings and explicit user scheduling.

## 4. Deletion
When a user deletes their account, all tasks, user metadata, and specific productivity stats mapped to the `user_id` are permanently removed from Firestore databases within 30 days.
