# FaithPadAppForChurch

Welcome!!
This project is to create an app for those who have difficulty attending church due to the Corona-19 virus.
The target device was set with the TECLAST P80X tablet, and we intend to make it to play the past worship video and the video of the church channel currently being screened in real time with one click.

The execution environment:
Android 9.0
Resolution 1280*800
Memory 2.0 GB

The development environment:
Android Studio 4.1 or VSCode 1.50.1
flutter 1.22.2
flutter plugin for android studio 4.3
dart plugin for android studio 4.3

How to Build:
1. With the environment ready, load the project

2. After open pubspec.yaml file, add 4 lines to install dependancies automatically.
  cupertino_icons: ^1.0.0
  http: ^0.12.0+2
  youtube_player_flutter: ^7.0.0+7
  cached_network_image: ^2.2.0+1
  
3. If it not installed automatically, run >flutter pub get in terminal.

4. from the menu of android studio Run build->flutter->build APK.

** 2020-11-11 update **

if channel is now realtime broadcasting, play directly current live broadcast.

** 2020-11-13 update **

Apply App Icon, App Name (Jonggyo church icon & name)
Automatically change to full screen when playing video.

** 2020-11-15 update **

Fullscreen Bugfix
