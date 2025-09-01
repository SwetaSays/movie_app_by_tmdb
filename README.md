# Movies App (Flutter + TMDB API)

A Flutter app to view trending & now playing movies, search, bookmark, share, and deep link.

## Features

- Home: Trending & Now Playing movies
- Search with live debounce
- Movie details screen
- Bookmark favorite movies (offline storage with Hive)
- Share movies with deep link
- Offline cache

## Installation

1. Clone the repo
2. Run `flutter pub get`
3. Add your TMDB API key in `lib/core/constants.dart`
4. Generate Retrofit code: `flutter pub run build_runner build`
5. Run the app: `flutter run`

## Deep Linking

- Android: add intent filter in `AndroidManifest.xml`
- iOS: add URL schemes in `Info.plist`
- Example link: `myapp://movie?id=12345`

## Build APK

```bash
flutter build apk --release
