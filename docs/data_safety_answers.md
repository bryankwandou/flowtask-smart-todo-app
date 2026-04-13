# Google Play Data Safety Questionnaire: FlowTask Answers

To ensure your 8th submission is accepted, copy these exact answers into the Google Play Console "Data Safety" section.

## 1. Data Collection and Security
- **Does your app collect or share any of the required user data types?** -> **Yes**
- **Is all of the user data collected by your app encrypted in transit?** -> **Yes**
- **Do you provide a way for users to request that their data is deleted?** -> **Yes**

## 2. Data Types Collected

### Personal Information
- **Name**: 
    - Collected? **Yes**
    - Shared? **No**
    - Processed ephemerally? **No**
    - Required? **Yes**
    - Purpose: **App Functionality**
- **Email Address**: 
    - Collected? **Yes**
    - Shared? **No**
    - Processed ephemerally? **No**
    - Required? **Yes**
    - Purpose: **App Functionality, Account Management**
- **User IDs**:
    - Collected? **Yes**
    - Shared? **No**
    - Processed ephemerally? **No**
    - Required? **Yes**
    - Purpose: **App Functionality**

### App Performance
- **Crash Logs**: 
    - Collected? **Yes**
    - Shared? **No**
    - Purpose: **Analytics**
- **Diagnostics**: 
    - Collected? **Yes**
    - Shared? **No**
    - Purpose: **Analytics**

### Device or Other IDs
- **Device or Other IDs**: 
    - Collected? **Yes** (For Firebase Cloud Messaging)
    - Shared? **No**
    - Purpose: **App Functionality**

## 3. Data Usage and Sharing
- **Data Sharing**: FlowTask does not share user data with any third-party "Data Brokers". Data is only "collected" to provide the core service via Google Firebase.

## 4. Account Deletion Link
When prompted for the URL where users can request account deletion:
**URL**: `https://flowtask-smart-todo-app.vercel.app/delete-account`

---
**Note to Developer**: Ensure your internal "Data Safety" labels in the CSV import match these exactly. Discrepancies between this list and the app's actual behavior (which I have hardened) are the #1 cause of rejection.
