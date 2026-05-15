# S-Mate 
> Version 1.0.0 · Flutter · Material 3 · Android

S-Mate is an AI-powered mobile travel companion app built with Flutter. It helps travelers plan trips, explore destinations, connect with fellow travelers, and stay safe abroad — all in one app.

---

## Screenshots

> Run the app on an emulator to see all screens in action.

---

## Features

| Screen | Description |
|---|---|
| Intro | Onboarding with feature overview and "Learn More" detail sheet |
| Login / Register | Email + password auth, Google sign-in UI, forgot password flow |
| Home | Dashboard with quick actions, current trip card, popular destinations, notification bell |
| AI Trip Planner | Form-based trip generator — destination, dates, budget, traveler count, preferences |
| Itinerary | Day-by-day checkpoints with progress bar and toggle completion |
| Map Explorer | Nearby places list, search filter, zoom controls, location pin |
| AI Chat | Conversational travel assistant with suggested questions and typing indicator |
| Find Travelers | Search + filter travelers by name, country, or interest |
| Traveler Chat | Real-time messaging UI with voice/video call dialogs |
| Travel Forum | Tabbed posts (Latest / Popular / Following), likes, comment sheet, share |
| Trip Camera | Camera capture and gallery upload flows with save-to-album sheet |
| Trip Albums | Photo album grid with like/unlike animation, create album |
| Profile | Stats, trip history, edit profile, language, notifications, privacy, password |
| Emergency Support | Emergency call buttons, quick Vietnamese phrases, safety tips |

---

## Tech Stack

| Package | Version | Purpose |
|---|---|---|
| [go_router](https://pub.dev/packages/go_router) | ^14.2.7 | Declarative routing |
| [provider](https://pub.dev/packages/provider) | ^6.1.2 | State management |
| [shared_preferences](https://pub.dev/packages/shared_preferences) | ^2.3.2 | Local storage |
| [cached_network_image](https://pub.dev/packages/cached_network_image) | ^3.4.1 | Image caching |
| [image_picker](https://pub.dev/packages/image_picker) | ^1.1.2 | Camera / gallery access |
| [url_launcher](https://pub.dev/packages/url_launcher) | ^6.3.0 | Phone calls |
| [flutter_animate](https://pub.dev/packages/flutter_animate) | ^4.5.0 | Animations |
| [intl](https://pub.dev/packages/intl) | ^0.19.0 | Date formatting |

---

## Project Structure

```
s_mate/
├── lib/
│   ├── main.dart                    # App entry point (SMateApp)
│   ├── core/
│   │   ├── router.dart              # GoRouter — all app routes
│   │   └── theme.dart               # AppTheme — colors, buttons, inputs
│   ├── features/
│   │   ├── intro/
│   │   │   └── intro_screen.dart
│   │   ├── auth/
│   │   │   └── login_screen.dart
│   │   ├── home/
│   │   │   └── home_screen.dart
│   │   ├── trip_planner/
│   │   │   └── trip_planner_screen.dart
│   │   ├── itinerary/
│   │   │   └── itinerary_screen.dart
│   │   ├── map/
│   │   │   └── map_screen.dart
│   │   ├── ai_chat/
│   │   │   └── ai_chat_screen.dart
│   │   ├── travelers/
│   │   │   ├── find_travelers_screen.dart
│   │   │   └── traveler_chat_screen.dart
│   │   ├── forum/
│   │   │   └── forum_screen.dart
│   │   ├── camera/
│   │   │   └── trip_camera_screen.dart
│   │   ├── albums/
│   │   │   └── trip_albums_screen.dart
│   │   ├── profile/
│   │   │   └── profile_screen.dart
│   │   └── quick_action/
│   │       └── quick_action_screen.dart
│   └── shared/
│       ├── models/
│       │   └── models.dart          # Traveler, ForumPost, ItineraryDay, Checkpoint, ChatMessage
│       └── widgets/
│           ├── main_scaffold.dart   # Bottom NavigationBar shell
│           └── app_card.dart        # AppCard, GradientAvatar, SectionHeader, PrimaryButton
├── assets/
│   └── images/
├── android/
├── test/
│   └── widget_test.dart
└── pubspec.yaml
```

---

## Navigation Routes

| Route | Screen |
|---|---|
| `/` | IntroScreen |
| `/login` | LoginScreen |
| `/home` | HomeScreen |
| `/trip-planner` | TripPlannerScreen |
| `/itinerary/:id` | ItineraryScreen |
| `/map` | MapScreen |
| `/ai-chat` | AiChatScreen |
| `/find-travelers` | FindTravelersScreen |
| `/traveler-chat/:id` | TravelerChatScreen |
| `/forum` | ForumScreen |
| `/trip-camera` | TripCameraScreen |
| `/trip-albums` | TripAlbumsScreen |
| `/profile` | ProfileScreen |
| `/quick-action` | QuickActionScreen |

---

## Requirements

- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.5.0+
- [Android Studio](https://developer.android.com/studio) with Flutter plugin
- Android emulator or real device (API 21+)
- [Git](https://git-scm.com)

---

## Getting Started

### 1. Clone the repo
```bash
git clone https://github.com/carol82475/s-mate.git
cd s-mate
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Run on emulator or device
```bash
flutter run
```

### 4. Build release APK
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

---



### Useful keys while app is running

| Key | Action                                                        |
| --- | ------------------------------------------------------------- |
| `r` | Hot reload — cập nhật UI, giữ nguyên state                    |
| `R` | Hot restart — restart app, reset state                        |
| `q` | Stop app — dừng ứng dụng                                      |
| `p` | Toggle debug paint — hiện/ẩn đường viền widget (debug layout) |
| `o` | Toggle platform — chuyển đổi iOS/Android rendering            |
| `s` | Screenshot — chụp màn hình app                                |
| `w` | Dump widget tree — in cây widget ra console                   |
| `t` | Dump render tree — in render tree                             |
| `l` | Dump layer tree                                               |
| `f` | Dump focus tree                                               |
| `L` | Toggle performance overlay                                    |
| `S` | Dump accessibility tree                                       |
| `U` | Dump semantics tree                                           |
| `h` | Show help — xem toàn bộ phím tắt                              |

---

## Data Models

All mock data lives in `lib/shared/models/models.dart`.

- `Traveler` — id, name, country, distance, interests, status
- `ChatMessage` — id, senderId, text, timestamp, isOwn
- `ItineraryDay` — day number, title, list of Checkpoints
- `Checkpoint` — time, title, description, completed (mutable)
- `ForumPost` — id, userName, destination, content, likes, comments, timestamp
- `MockData` — static lists of travelers, forum posts, itinerary days

---

## Color Palette

| Name | Hex |
|---|---|
| Primary | `#FFB088` |
| Primary Dark | `#FF9E7D` |
| Secondary | `#607D8B` |
| Accent | `#FFE0B2` |
| Background | `#FCF8F4` |
| Destructive | `#D4183D` |
| Success | `#27AE60` |
