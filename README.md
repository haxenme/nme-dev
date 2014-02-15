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
```
