# Online Medical Store - Android Application

This is the Android version of the Online Medical Store, built with Kotlin and Jetpack Compose.

## Features
- User Login (Mocked)
- Medicine List View
- Modern UI with Material 3

## Project Structure
- `app/src/main/java/com/medical/store/ui`: UI components and screens.
- `app/src/main/java/com/medical/store/data`: Data models and API services.
- `android_app/build.gradle`: Project-level configuration.

## How to Run & Install on Phone

### 1. Open in Android Studio
- Open the `android_app` folder in **Android Studio**.
- Wait for Gradle to sync.

### 2. Prepare Your Phone
- Go to **Settings > About Phone**.
- Tap **Build Number** 7 times until you see "You are now a developer".
- Go to **Settings > System > Developer Options**.
- Enable **USB Debugging**.

### 3. Install the App
- Connect your phone to your Linux PC via USB.
- In Android Studio, select your phone from the device dropdown (next to the Run button).
- Click the green **Run** button (or press `Shift + F10`).
- The app will be built and installed on your phone automatically.

### 4. (Optional) Generate APK
If you want to share the app file:
- In Android Studio, go to **Build > Build Bundle(s) / APK(s) > Build APK(s)**.
- Once finished, click "Locate" to find the `.apk` file and transfer it to your phone.

## Future Integration
To connect this app to the Java backend, the backend needs to implement REST API endpoints that return JSON.
