# FlowTask Developer Guide 🚀

Welcome to the engineering heartbeat of FlowTask. This repository is built for scale, performance, and sensory excellence.

## 🏗 Architecture
FlowTask follows **Clean Architecture** principles with **Riverpod 2.0** for functional reactive state management.

- **Core**: Theme, networking, and common utilities.
- **Features**: Domain-driven feature sets (Tasks, Analytics, Focus).
- **Services**: External integrations (Firebase, Notifications).

## 🛠 Tech Stack
- **Frontend**: Flutter (3.x)
- **State**: Riverpod (Generator supported)
- **Backend**: Firebase (Auth, Firestore, FCM)
- **Analytics**: Firebase Analytics + FL Charts
- **Persistence**: Hive (Offline-first support)

## 🏁 Getting Started

1. **Environment Setup**:
   ```bash
   flutter pub get
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

2. **Firebase Integration**:
   - Place `google-services.json` in `android/app/`
   - Place `GoogleService-Info.plist` in `ios/Runner/`

3. **Running the App**:
   - Standard run: `flutter run`
   - Hardened Production Test: `flutter run --release`

## 🧪 Testing Policy
- **Physical Devices Only**: Due to the high-fidelity haptics and notification persistence, emulator testing is discouraged for final QA.
- **Unit Testing**: Run `flutter test` for core logic validation.

## 📈 Roadmap
- [ ] AI-Powered Smart Scheduling
- [ ] Team Workspace Collaboration
- [ ] WearOS / Apple Watch Companion Apps

## ✨ Contributing
Please read our `CONTRIBUTING.md` before submitting PRs. Maintain a "Zen" aesthetic in all UI contributions.

---
**FlowTask Engineering Team**
"Turning chaos into order, one commit at a time."
