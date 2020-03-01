# cmake-netburner-hello-world

Demo that demonstrates how to build the project for NetBurner MOD5441X using CMake.

## Motivation

At my job we develop some cross-platform CMake-based application that should run on different hardware: Windows x86 desktop (as simulator), NetBurner MOD5441X, ARM cpus in linux, etc. Use regular makefiles was inconvenient. The lack of CMake build scripts on the [NetBurner's forum](https://forum.embeddedethernet.com/index.php) and github was the reason for creation this repository.

## Building

```bash
mkdir build && cd build
cmake -Wdev -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=../m68k-unknown-elf.cmake ..
# or
cmake -Wdev -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE=../m68k-unknown-elf.cmake ..
cmake --build .
```

## Demonstration

