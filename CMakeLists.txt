cmake_minimum_required(VERSION 3.0)

set(MAJ 0)
set(MIN 0)
set(PATCH 1)

# NetBurner related makefile variables
set(NAME cmake-netburner-hello-world)
set(PLATFORM MOD5441X)
set(NBINCLUDE "C:/nburn/gcc-m68k/m68k-unknown-elf/include/c++/5.2.0")

project(${NAME} VERSION ${MAJ}.${MIN}.${PATCH})


# However, the file(GLOB...) allows for wildcard additions:
file(GLOB SOURCES "./*.cpp")

add_executable(testStudent ${SOURCES})
