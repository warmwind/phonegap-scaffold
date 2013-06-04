## This is a scaffold for building phonegap application

## Prepare

* If you want to build ios, make sure you have Xcode installed - with command line tools. 
* If you want to build android, make sure you have latest android SDK installed. Set ANDROID_HOME in your environment and adb/android can be found in command line.
* Install qt to run jasmine:headless. brew install qt 

## Development

### Auto Compile
Run guard to auto compile coffee, scss, haml
  ```bash
  guard
  ```

### Different Environment
  Maybe you are responable to build backend api as well as mobile, and your api has different urls for deveolopment, uat and production. Run the following task to set env for phonegap application

  ```bash
  rake set_env[http://uat.com]
  ```

### Coding
* edit code under `www/`
* `rake -T` to see available tasks. Frequent tasks might be: 

  ```bash
  rake ios:build         # run platform/ios/cordova/build
  rake ios:run           # run platform/ios/cordova/run
  rake android:build     # run platform/android/cordova/build
  rake android:run       # run platform/android/cordova/run
  rake jasmine:headless  # Run Jasmine specs headlessly
  ```

