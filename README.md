# S-Mate 

S-Mate is a Flutter mobile app that serves as your intelligent travel companion. Plan trips with AI, explore maps, connect with fellow travelers, and stay safe abroad.

---

## Features

| Feature | Description |
|---|---|
| AI Trip Planner | Generate personalized itineraries with destination, dates, budget, and preferences |
| Itinerary View | Day-by-day checkpoints with progress tracking |
| Map Explorer | Browse nearby places with search and zoom controls |
| AI Chat | 24/7 travel assistant with suggested questions |
| Find Travelers | Search and filter fellow travelers, connect via chat |
| Traveler Chat | Real-time messaging with voice/video call UI |
| Travel Forum | Tabbed forum (Latest/Popular/Following) with likes and comments |
| Trip Camera | Capture photos or upload from gallery, save to albums |
| Trip Albums | Organize travel photos with like/unlike feedback |
| Profile | Edit profile, manage language, notifications, privacy, password |
| Emergency Support | Emergency contacts with direct call, quick phrases, safety tips |

---

## Tech Stack

- Flutter 3.x / Dart
- [go_router](https://pub.dev/packages/go_router) — navigation
- [url_launcher](https://pub.dev/packages/url_launcher) — phone calls
- Material 3 design system

---

## Project Structure

```
lib/
├── main.dart
├── core/
│   ├── router.dart        # GoRouter navigation
│   └── theme.dart         # App-wide theme & colors
├── features/
│   ├── intro/             # Onboarding screen
│   ├── auth/              # Login / Register
│   ├── home/              # Home dashboard
│   ├── trip_planner/      # AI trip planning form
│   ├── itinerary/         # Day-by-day itinerary view
│   ├── map/               # Map explorer
│   ├── ai_chat/           # AI travel assistant chat
│   ├── travelers/         # Find travelers + chat
│   ├── forum/             # Travel forum
│   ├── camera/            # Trip camera
│   ├── albums/            # Trip photo albums
│   ├── profile/           # User profile & settings
│   └── quick_action/      # Emergency support
└── shared/
    ├── models/models.dart  # Data models & mock data
    └── widgets/            # Reusable UI components
```

---

## Requirements

- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.x+
- [Android Studio](https://developer.android.com/studio)
- Android emulator or real device (API 21+)
- [Git](https://git-scm.com)

---

## Setup & Run

### Clone the repo
```bash
git clone https://github.com/carol82475/s-mate.git
cd s-mate
```

### Install dependencies
```bash
flutter pub get
```

### Run on emulator or device
```bash
flutter run
```

### Build release APK
```bash
flutter build apk --release
```

---

## Team Workflow

```bash
# Before starting work — always pull latest
git pull

# After making changes
git add .
git commit -m "describe your change"
git push
```

### Hot reload while running
| Key | Action |
|---|---|
| `r` | Hot reload (updates UI, keeps state) |
| `R` | Hot restart (resets state) |
| `q` | Stop app |
