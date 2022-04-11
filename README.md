# cmake-netburner-hello-world

Demonstration of how to build the project for NetBurner MOD5441X using CMake.
Tested on NNDK 2.8.7, 2.8.8 and 2.9.0.

## Motivation

At my job we develop some cross-platform CMake-based application that should run on different hardware: Windows x86 desktop, NetBurner MOD5441X, ARM cpus in linux, etc. Use regular makefiles was inconvenient. The lack of CMake build scripts on the [NetBurner's forum](https://forum.embeddedethernet.com/index.php) and github was the reason for creation this repository.

## Building

```bash
mkdir build && cd build
cmake -Wdev -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=../cmake/m68k-unknown-elf.cmake ..
# or
cmake -Wdev -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE=../cmake/m68k-unknown-elf.cmake ..
# or
cmake --build . --target cmake-netburner-hello-world_0.0.6_app -- VERBOSE=1
```

Also you can build the project in `MinSizeRel` and `RelWithDebInfo` standard build configurations.

## Demonstration

On my installation:

<details>
  <summary>Click to expand</summary>
  
  ```bash
  Boost@Boost-PC MINGW64 /g/cmake-netburner-hello-world (develop)
  $ mkdir build_relwithdebinfo && cd build_relwithdebinfo/

  Boost@Boost-PC MINGW64 /g/cmake-netburner-hello-world/build_relwithdebinfo (develop)
  $ cmake -Wdev -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_TOOLCHAIN_FILE=../cmake/m68k-unknown-elf.cmake ..
  -- The C compiler identification is GNU 8.1.0
  -- The CXX compiler identification is GNU 8.1.0
  -- Detecting C compiler ABI info
  -- Detecting C compiler ABI info - done
  -- Check for working C compiler: C:/nburn/gcc-m68k/bin/m68k-elf-gcc.exe - skipped
  -- Detecting C compile features
  -- Detecting C compile features - done
  -- Detecting CXX compiler ABI info
  -- Detecting CXX compiler ABI info - done
  -- Check for working CXX compiler: C:/nburn/gcc-m68k/bin/m68k-elf-g++.exe - skipped
  -- Detecting CXX compile features
  -- Detecting CXX compile features - done
  -- Generating htmldata.cpp
  Reading files from G:/cmake-netburner-hello-world/html and compressing them into G:/cmake-netburner-hello-world/htmldata.cpp
  Ignoring files and directories: CVS, cvs, .SVN, .svn, .git, .GIT
  MIME_file: C:/nburn/pcbin/MIME_magic.txt
  Building MIME list..... Done
  Processing /index.htm 94 bytes
  Result counts = 61 total_ends :31
  43 bytes out of 77 original encode out of 94 total original
  Processing /index.htm 94 bytes
  -- Generating htmldata.cpp - done
  -- Configuring done
  -- Generating done
  -- Build files have been written to: G:/cmake-netburner-hello-world/build_relwithdebinfo

  Boost@Boost-PC MINGW64 /g/cmake-netburner-hello-world/build_relwithdebinfo (develop)
  $ cmake --build . --target cmake-netburner-hello-world_0.0.6_app -- VERBOSE=1
  "C:/Program Files/CMake/bin/cmake.exe" -SG:/cmake-netburner-hello-world -BG:/cmake-netburner-hello-world/build_relwithdebinfo --check-build-system CMakeFiles/Makefile.cmake 0
  C:/nburn/gcc-m68k/bin/make.exe  -f CMakeFiles/Makefile2 cmake-netburner-hello-world_0.0.6_app
  make.exe[1]: Entering directory 'G:/cmake-netburner-hello-world/build_relwithdebinfo'
  "C:/Program Files/CMake/bin/cmake.exe" -SG:/cmake-netburner-hello-world -BG:/cmake-netburner-hello-world/build_relwithdebinfo --check-build-system CMakeFiles/Makefile.cmake 0
  "C:/Program Files/CMake/bin/cmake.exe" -E cmake_progress_start G:/cmake-netburner-hello-world/build_relwithdebinfo/CMakeFiles 3
  C:/nburn/gcc-m68k/bin/make.exe  -f CMakeFiles/Makefile2 CMakeFiles/cmake-netburner-hello-world_0.0.6_app.dir/all
  make.exe[2]: Entering directory 'G:/cmake-netburner-hello-world/build_relwithdebinfo'
  C:/nburn/gcc-m68k/bin/make.exe  -f CMakeFiles/cmake-netburner-hello-world_0.0.6.dir/build.make CMakeFiles/cmake-netburner-hello-world_0.0.6.dir/depend
  make.exe[3]: Entering directory 'G:/cmake-netburner-hello-world/build_relwithdebinfo'
  "C:/Program Files/CMake/bin/cmake.exe" -E cmake_depends "Unix Makefiles" G:/cmake-netburner-hello-world G:/cmake-netburner-hello-world G:/cmake-netburner-hello-world/build_relwithdebinfo G:/cmake-netburner-hello-world/build_relwithdebinfo G:/cmake-netburner-hello-world/build_relwithdebinfo/CMakeFiles/cmake-netburner-hello-world_0.0.6.dir/DependInfo.cmake --color=
  Dependee "G:/cmake-netburner-hello-world/build_relwithdebinfo/CMakeFiles/cmake-netburner-hello-world_0.0.6.dir/DependInfo.cmake" is newer than depender "G:/cmake-netburner-hello-world/build_relwithdebinfo/CMakeFiles/cmake-netburner-hello-world_0.0.6.dir/depend.internal".
  Scanning dependencies of target cmake-netburner-hello-world_0.0.6
  make.exe[3]: Leaving directory 'G:/cmake-netburner-hello-world/build_relwithdebinfo'
  C:/nburn/gcc-m68k/bin/make.exe  -f CMakeFiles/cmake-netburner-hello-world_0.0.6.dir/build.make CMakeFiles/cmake-netburner-hello-world_0.0.6.dir/build
  make.exe[3]: Entering directory 'G:/cmake-netburner-hello-world/build_relwithdebinfo'
  [ 33%] Building CXX object CMakeFiles/cmake-netburner-hello-world_0.0.6.dir/htmldata.cpp.obj
  C:/nburn/gcc-m68k/bin/m68k-elf-g++.exe --sysroot=C:/nburn/gcc-m68k/bin/../m68k-unknown-elf/sysroot -DPROJECT_NAME=\"cmake-netburner-hello-world_0.0.6\"  -mcpu=54415 -gdwarf-2 -falign-functions=4 -ffunction-sections -fmessage-length=0 -fdata-sections -fno-rtti -DMOD5441X -DMCF5441X -DNBMINGW -IC:/nburn/gcc-m68k/m68k-unknown-elf/include        -IC:/nburn/include      -IC:/nburn/MOD5441X/include -IC:/nburn/gcc-m68k/m68k-unknown-elf/include/c++/8.1.0      -O2     -g      -D_DEBUG         -Wall -Wextra -Wshadow -Wcast-align -Wunused -Wpedantic -Wconversion -Wsign-conversion -Wnull-dereference -Wdouble-promotion -Wformat=2 -Wmisleading-indentation -Wduplicated-cond -Wduplicated-branches -Wlogical-op -fno-strict-aliasing -std=gnu++14 -o CMakeFiles/cmake-netburner-hello-world_0.0.6.dir/htmldata.cpp.obj -c G:/cmake-netburner-hello-world/htmldata.cpp
  In file included from C:/nburn/include/htmlfiles.h:34,
                   from G:/cmake-netburner-hello-world/htmldata.cpp:2:
  C:/nburn/include/nettypes.h: In constructor 'IPADDR4::IPADDR4(uint8_t, uint8_t, uint8_t, uint8_t)':
  C:/nburn/include/nettypes.h:131:51: warning: conversion to 'DWORD' {aka 'long unsigned int'} from 'int' may change the sign of the result [-Wsign-conversion]
           ip_val = (a << 24) | (b << 16) | (c << 8) | d;
                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
  C:/nburn/include/nettypes.h: At global scope:
  C:/nburn/include/nettypes.h:211:77: warning: extra ';' [-Wpedantic]
   inline IPADDR4 IPV4FromConst(DWORD d) {IPADDR4 i4; i4.ip_val=d; return i4; };
                                                                               ^
  C:/nburn/include/nettypes.h:214:114: warning: extra ';' [-Wpedantic]
   inline IPADDR4 LocalBroadCast(IPADDR4 ifip,IPADDR4 ipmask) {return IPV4FromConst(ifip.ip_val|~(ipmask.ip_val)); };
                                                                                                                    ^
  C:/nburn/include/nettypes.h:241:15: warning: ISO C++ forbids flexible array member 'pData' [-Wpedantic]
      BYTE pData[];
                 ^
  C:/nburn/include/nettypes.h:251:15: warning: ISO C++ forbids flexible array member 'pData' [-Wpedantic]
      BYTE pData[];
                 ^
  G:/cmake-netburner-hello-world/htmldata.cpp: In function 'int DoHtmlFunction(int, PCSTR, WORD)':
  G:/cmake-netburner-hello-world/htmldata.cpp:56:24: warning: unused parameter 'fd' [-Wunused-parameter]
   int DoHtmlFunction(int fd, PCSTR url,WORD n) { return 0; };
                      ~~~~^~
  G:/cmake-netburner-hello-world/htmldata.cpp:56:34: warning: unused parameter 'url' [-Wunused-parameter]
   int DoHtmlFunction(int fd, PCSTR url,WORD n) { return 0; };
                              ~~~~~~^~~
  G:/cmake-netburner-hello-world/htmldata.cpp:56:43: warning: unused parameter 'n' [-Wunused-parameter]
   int DoHtmlFunction(int fd, PCSTR url,WORD n) { return 0; };
                                        ~~~~~^
  G:/cmake-netburner-hello-world/htmldata.cpp: At global scope:
  G:/cmake-netburner-hello-world/htmldata.cpp:56:59: warning: extra ';' [-Wpedantic]
   int DoHtmlFunction(int fd, PCSTR url,WORD n) { return 0; };
                                                             ^
  G:/cmake-netburner-hello-world/htmldata.cpp: In function 'int DoHtmlVariable(int, WORD)':
  G:/cmake-netburner-hello-world/htmldata.cpp:58:24: warning: unused parameter 'fd' [-Wunused-parameter]
   int DoHtmlVariable(int fd,WORD n) { return 0; };
                      ~~~~^~
  G:/cmake-netburner-hello-world/htmldata.cpp:58:32: warning: unused parameter 'n' [-Wunused-parameter]
   int DoHtmlVariable(int fd,WORD n) { return 0; };
                             ~~~~~^
  G:/cmake-netburner-hello-world/htmldata.cpp: At global scope:
  G:/cmake-netburner-hello-world/htmldata.cpp:58:48: warning: extra ';' [-Wpedantic]
   int DoHtmlVariable(int fd,WORD n) { return 0; };
                                                  ^
  [ 66%] Linking CXX executable RelWithDebInfo/cmake-netburner-hello-world_0.0.6.elf
  C:/nburn/gcc-m68k/bin/m68k-elf-g++.exe --sysroot=C:/nburn/gcc-m68k/bin/../m68k-unknown-elf/sysroot -mcpu=54415 -gdwarf-2 -falign-functions=4 -ffunction-sections -fmessage-length=0 -fdata-sections -fno-rtti -DMOD5441X -DMCF5441X -DNBMINGW -IC:/nburn/gcc-m68k/m68k-unknown-elf/include      -IC:/nburn/include      -IC:/nburn/MOD5441X/include -IC:/nburn/gcc-m68k/m68k-unknown-elf/include/c++/8.1.0      -O2     -g      -D_DEBUG         -mcpu=54415 -Wl,-n -TC:/nburn/MOD5441X/lib/MOD5441X.ld         -Wl,-RC:/nburn/MOD5441X/lib/sys.ld       "CMakeFiles/cmake-netburner-hello-world_0.0.6.dir/main.cpp.obj" "CMakeFiles/cmake-netburner-hello-world_0.0.6.dir/htmldata.cpp.obj"  -o RelWithDebInfo/cmake-netburner-hello-world_0.0.6.elf  -Wl,-Map=G:/cmake-netburner-hello-world/build_relwithdebinfo/RelWithDebInfo/cmake-netburner-hello-world_0.0.6.map  -Wl,--start-group  C:/nburn/lib/DBMOD5441X.a       C:/nburn/lib/DBNetBurner.a       C:/nburn/lib/FatFile.a C:/nburn/lib/StdFFile.a -lstdc++  -Wl,--end-group -Wl,--gc-sections
  make.exe[3]: Leaving directory 'G:/cmake-netburner-hello-world/build_relwithdebinfo'
  [100%] Built target cmake-netburner-hello-world_0.0.6
  C:/nburn/gcc-m68k/bin/make.exe  -f CMakeFiles/cmake-netburner-hello-world_0.0.6_app.dir/build.make CMakeFiles/cmake-netburner-hello-world_0.0.6_app.dir/depend
  make.exe[3]: Entering directory 'G:/cmake-netburner-hello-world/build_relwithdebinfo'
  "C:/Program Files/CMake/bin/cmake.exe" -E cmake_depends "Unix Makefiles" G:/cmake-netburner-hello-world G:/cmake-netburner-hello-world G:/cmake-netburner-hello-world/build_relwithdebinfo G:/cmake-netburner-hello-world/build_relwithdebinfo G:/cmake-netburner-hello-world/build_relwithdebinfo/CMakeFiles/cmake-netburner-hello-world_0.0.6_app.dir/DependInfo.cmake --color=
  Dependee "G:/cmake-netburner-hello-world/build_relwithdebinfo/CMakeFiles/cmake-netburner-hello-world_0.0.6_app.dir/DependInfo.cmake" is newer than depender "G:/cmake-netburner-hello-world/build_relwithdebinfo/CMakeFiles/cmake-netburner-hello-world_0.0.6_app.dir/depend.internal".
  Dependee "G:/cmake-netburner-hello-world/build_relwithdebinfo/CMakeFiles/CMakeDirectoryInformation.cmake" is newer than depender "G:/cmake-netburner-hello-world/build_relwithdebinfo/CMakeFiles/cmake-netburner-hello-world_0.0.6_app.dir/depend.internal".
  Scanning dependencies of target cmake-netburner-hello-world_0.0.6_app
  make.exe[3]: Leaving directory 'G:/cmake-netburner-hello-world/build_relwithdebinfo'
  C:/nburn/gcc-m68k/bin/make.exe  -f CMakeFiles/cmake-netburner-hello-world_0.0.6_app.dir/build.make CMakeFiles/cmake-netburner-hello-world_0.0.6_app.dir/build
  make.exe[3]: Entering directory 'G:/cmake-netburner-hello-world/build_relwithdebinfo'
  cd G:/cmake-netburner-hello-world/build_relwithdebinfo/RelWithDebInfo && C:/nburn/gcc-m68k/bin/m68k-elf-objcopy.exe --output-target=srec cmake-netburner-hello-world_0.0.6.elf cmake-netburner-hello-world_0.0.6.s19
  cd G:/cmake-netburner-hello-world/build_relwithdebinfo/RelWithDebInfo && compcode cmake-netburner-hello-world_0.0.6.s19 cmake-netburner-hello-world_0.0.6_APP.s19 -M cmake-netburner-hello-world_0.0.6.map -R 0xC0040000 0xC2000000 -PMOD5441X

  Block starts at 40000400
  Block ends at 4008e0fc
  Block size= 567K
  Execution starts at 40001860
  compressed 580860 bytes into 289576 bytes
  Code CheckSum= 5821e931
  Struct CheckSum= 6a260499
  S records output with a base address of c0040000
  S records output with a final address of c0086b40
  About to write S7...
  ******************************Build summary ******************************
  Used 289600 bytes of 33292288 available flash (0.87%)
  Used 2245488 bytes of 67108095 available ram (3.35%)
  NNDK release tag version:2.9.0
  make.exe[3]: Leaving directory 'G:/cmake-netburner-hello-world/build_relwithdebinfo'
  [100%] Built target cmake-netburner-hello-world_0.0.6_app
  make.exe[2]: Leaving directory 'G:/cmake-netburner-hello-world/build_relwithdebinfo'
  "C:/Program Files/CMake/bin/cmake.exe" -E cmake_progress_start G:/cmake-netburner-hello-world/build_relwithdebinfo/CMakeFiles 0
  make.exe[1]: Leaving directory 'G:/cmake-netburner-hello-world/build_relwithdebinfo'

  Boost@Boost-PC MINGW64 /g/cmake-netburner-hello-world/build_relwithdebinfo (develop)
  $
  ```
</details>

## Known Issues

Under Win 7 x64 the steps `Detecting C/CXX compiler ABI info` always fail if Windows Cmd or `cmake-gui` tool are used.