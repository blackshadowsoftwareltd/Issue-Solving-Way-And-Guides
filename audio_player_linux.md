```
Launching lib/main.dart on Linux in debug mode...
CMake Error at /snap/flutter/141/usr/share/cmake-3.16/Modules/FindPkgConfig.cmake:463 (message):
A required package was not found
Call Stack (most recent call first):
/snap/flutter/141/usr/share/cmake-3.16/Modules/FindPkgConfig.cmake:643 (_pkg_check_modules_internal)
flutter/ephemeral/.plugin_symlinks/audioplayers_linux/linux/CMakeLists.txt:24 (pkg_check_modules)
```

Here's the relevant bit showing which packages are required:
https://github.com/bluefireteam/audioplayers/blob/2333cb7f5a9fcd84bdd477120d1f53f346c3b10d/packages/audioplayers_linux/linux/CMakeLists.txt#L20C1-L26C64


- installe

'gstreamer-audio' ,'gstreamer-audio-sys' , & 'gstreamer-app'
