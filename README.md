# FaithPadAppForChurch

Welcome!!
This project is to create an app for those who have difficulty attending church due to the Corona-19 virus.
The target device was set with the TECLAST P80X tablet, and we intend to make it to play the past worship video and the video of the church channel currently being screened in real time with one click.

The execution environment:
Android 9.0
Resolution 1280*800
Memory 2.0 GB

The development environment:
Android Studio 4.1.1 or VSCode 1.50.1

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

== How to customize to your church == 

1. change app label

file: android>app>src>nauk>AndroidManifest.xml

<manifest

 <application
 
  android:label="YOURCHURCH"  <-- Here

2. change channel id

file: >lib>utils>services.dart

class Services{
  
  static const CHANNEL_ID = 'UCfmySLZRhug4Hf1kE9zTauw';  <-- Here

3. change icons

Make your church icon 48 * 48, 72 * 72, 96 * 96, 144 * 144, 192 * 192
(It is easier to make icons at https://appicon.co/)

copy and overwrite icon files at

android / app / src / main / res / mipmap-hdpi

android / app / src / main / res / mipmap-mdpi

android / app / src / main / res / mipmap-xhdpi

android / app / src / main / res / mipmap-xxhdpi

android / app / src / main / res / mipmap-xxxhdpi


4. build 

At the Androidstudio menu build->flutter->build apk

output file "app-release.apk" placed at 

build / app / outputs / flutter-apk 

** 2020-11-11 update **

if channel is now realtime broadcasting, play directly current live broadcast.

** 2020-11-13 update **

Apply App Icon, App Name (Jonggyo church icon & name)
Automatically change to full screen when playing video.

** 2020-11-15 update **

Fullscreen Bugfix

** 2020-11-23 update **

Change orientation bug fix: both live and stock videos.

