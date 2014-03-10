Project Barbosa iOS
===================
[![Build Status](https://api.travis-ci.org/yuriydyrenko/Project-Barbosa-iOS.png?branch=master)](https://travis-ci.org/yuriydyrenko/Project-Barbosa-iOS)

####CocoaPods Notes:
1. You can use CocoaPods to get all of the required dependencies (you must be in the project folder).
```
pod install
```
2. Important: CocoaPods will create an Xcode Workspace file (.xcworkspace) use this file instead of the normal .xcodeproj project file.

####CocoaPods Requirements:
1. Ruby https://www.ruby-lang.org/en/installation/
2. Ruby Games http://rubygems.org/pages/download
3. Install CocoaPods via Gem:
```
sudo gem install cocoapods
```

####Screenshots:
######Main View:
![Main View](http://i.imgur.com/RRwNN9D.png)

######Trip View:
![Trip View](http://i.imgur.com/BKI6kHA.png)

####Useful Git Commands:
1. Add remote if needed:
```
git remote add origin git@github.com:yuriydyrenko/Project-Barbosa-iOS.git
```
2. Push to GitHub (must be in Project Folder)
```
git push -u origin master
```

####XCode Notes:
2. When adding files to the project:
    - Check "Copy items into detination group's folder (if needed)"
    - Select "Create groups for any added folders"
    - Add files to both targets
