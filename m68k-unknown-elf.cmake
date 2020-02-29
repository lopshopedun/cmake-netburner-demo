set(CMAKE_SYSTEM_NAME Generic)

set(CMAKE_C_COMPILER m68k-elf-gcc.exe)
set(CMAKE_CXX_COMPILER m68k-elf-g++.exe)
set(CMAKE_ASM_COMPILER m68k-elf-as.exe)
set(CMAKE_AR m68k-elf-ar.exe)
set(CMAKE_OBJCOPY m68k-elf-objcopy.exe)
set(CMAKE_OBJDUMP m68k-elf-objdump.exe)

if ($ENV{PLATFORM} STREQUAL "MOD5441X")
    set(CPUFLAG mcpu=54415)
    set(CPU_TYPE MCF5441X)
endif()

if ($ENV{NBROOT} STREQUAL "C:\\nburn")
    set(CMAKE_NBROOT "C:/nburn")
endif()

set(C_NBINCLUDE "-I${CMAKE_NBROOT}/gcc-m68k/m68k-unknown-elf/include -I${CMAKE_NBROOT}/include -I${CMAKE_NBROOT}/$ENV{PLATFORM}/include")
set(CXX_NBINCLUDE "${C_NBINCLUDE} -I${CMAKE_NBROOT}/gcc-m68k/m68k-unknown-elf/include/c++/5.2.0")

set(CMAKE_CXX_FLAGS_DEBUG "-${CPUFLAG} -malign-int --std=gnu++14 -gdwarf-2 -Wall -Wextra -pedantic -fno-rtti -fno-exceptions -D_DEBUG -falign-functions=4 -g -ffunction-sections -fdata-sections -D$ENV{PLATFORM} -D${CPU_TYPE} -DNBMINGW ${CXX_NBINCLUDE} ${EXTRADBCXXFLAGS}" CACHE STRING "C++ Debug Flags")

set(CMAKE_CXX_FLAGS_RELEASE "-${CPUFLAG} -malign-int --std=gnu++14 -gdwarf-2 -Wall -Wextra -pedantic -fno-rtti -fno-exceptions -falign-functions=4 -O2 -ffunction-sections -fdata-sections -D$ENV{PLATFORM} -D${CPU_TYPE} -DNBMINGW ${CXX_NBINCLUDE} ${EXTRACXXFLAGS}" CACHE STRING "C++ Release Flags")

set(CMAKE_C_FLAGS_DEBUG "-${CPUFLAG} -malign-int --std=gnu11 -gdwarf-2 -Wall -Wextra -pedantic -D_DEBUG -g -falign-functions=4 -O2 -D$ENV{PLATFORM} -D${CPU_TYPE} -DNBMINGW ${C_NBINCLUDE} ${EXTRADBCFLAGS}" CACHE STRING "C Debug Flags")

set(CMAKE_C_FLAGS_RELEASE "-${CPUFLAG} -malign-int --std=gnu11 -gdwarf-2 -Wall -Wextra -pedantic -falign-functions=4 -O2 -D$ENV{PLATFORM} -D${CPU_TYPE} -DNBMINGW ${C_NBINCLUDE} ${EXTRACFLAGS}" CACHE STRING "C Release Flags")

set(CMAKE_CXX_LINK_FLAGS "-${CPUFLAG} -Wl,-n -T${CMAKE_NBROOT}/$ENV{PLATFORM}/lib/$ENV{PLATFORM}.ld -Wl,-R${CMAKE_NBROOT}/$ENV{PLATFORM}/lib/sys.ld ${EXTRALINKFLAGS}" CACHE STRING "C++ Linker Flags")

# cmake built-in settings to use find_xxx() functions
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)



