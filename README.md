nme-state
=========

Support files for building nme

Before building, make sure you have the latest version of hxcpp installed.

Common
------
For fresh build, start with:
```
cd build
neko build.n clean
```

Linux
-----
```
neko build.n -DHXCPP_M64
neko build.n -DHXCPP_M32
```

Windows
-------
```
neko build.n
```

Mac
---
```
neko build.n -DHXCPP_M64
neko build.n -DHXCPP_M32
neko build.n -Diphonesim
neko build.n -Diphoneos
neko build.n -Diphoneos -DHXCPP_ARMV7
```

Android
-------
From Mac, Windows or Linux with the compiler correctly set,
```
neko build.n -Dandroid
neko build.n -Dandroid -DHXCPP_ARMV7
neko build.n -Dandroid -DHXCPP_X86
```
