# 📱 QR Attendance Verification App

A **Flutter-based mobile application** built for college clubs and events to **verify participant registrations** using **QR / barcode scanning**.  
The app fetches the **official list of registered participants from an API** and enables **fast, reliable entry verification** at the venue.

---

## ✨ Features

- 📷 Fast QR / Barcode Scanning
- 🔐 Real-time Participant Verification
- 🌐 API-based Participant Sync
- 📴 Offline Support using Hive
- 🚫 Duplicate Scan Prevention
- 📳 Haptic Feedback on Successful Scan
- 🎨 Material 3 UI with Dynamic Seed Colors
- ⚡ Optimized for High-Traffic Events

---

## 🧠 Workflow

1. 📡 Fetch registered participant data from an API  
2. 💾 Store participant data locally using Hive  
3. 📷 Scan participant registration QR / barcode  
4. ✅ Verify scanned code against local data  
5. ❌ Reject unregistered or invalid entries instantly  

---

## 🛠️ Tech Stack

| Technology | Purpose |
|-----------|--------|
| Flutter | Mobile App Development |
| Dart | Programming Language |
| mobile_scanner | QR / Barcode Scanning |
| Hive | Local Offline Storage |
| HTTP | API Communication |
| Material 3 | UI & Theming |
| flutter_dotenv | Environment Configuration |

---

## 📦 Dependencies

```yaml
mobile_scanner
hive
hive_flutter
http
connectivity_plus
internet_connection_checker
flutter_dotenv
google_fonts

```
---

## 🚀Getting Started
- 1️⃣ Clone the Repository
  ```
  git clone https://github.com/your-username/qr-attendance-app.git
  cd qr-attendance-app
  ```
- 2️⃣ Install Dependencies
  ```
  flutter pub get
  ```
- 3️⃣ Setup Environment Variables
  Create a .env file in the project root:
  ```
  API_BASE_URL=https://your-api-url.com
  ```
  Add it to pubspec.yaml:
  ```
  flutter:
  assets:
    - .env
  ```
- 4️⃣ Generate Hive Adapters
  ```
  flutter pub run build_runner build --delete-conflicting-outputs
  ```
- 5️⃣ Run the App
  ```
  flutter run
  ```
---
## ⚠️ Permissions
The app requires the following permissions:
  - 📷 Camera access (QR scanning)
  - 🌐 Internet access (API sync)
--- 
## 🎯 Use Cases
- 🎓 College Fests & Tech Events
- 🏫 Club Registrations
- 🎟️ Entry Verification
- 🧑‍💼 Volunteer-managed Check-ins
---

## 🧪 Tested On
- Android 10+
- Physical devices
---
