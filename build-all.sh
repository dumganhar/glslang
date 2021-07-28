python update_glslang_sources.py

./build-android.sh x86
./build-android.sh x86_64
./build-android.sh armeabi-v7a
./build-android.sh arm64-v8a

./build-ios.sh x86_64 iphonesimulator
./build-ios.sh arm64  iphoneos
./build-lipo.sh build-ios-universal build-ios-x86_64-iphonesimulator build-ios-arm64-iphoneos

./build-osx.sh arm64
./build-osx.sh x86_64
./build-lipo.sh build-osx-universal build-osx-arm64 build-osx-x86_64

# Should be invoked from command prompt
# ./build-windows.bat win32
# ./build-windows.bat x64
