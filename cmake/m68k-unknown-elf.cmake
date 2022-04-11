set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR m68k)

if ($ENV{PLATFORM} STREQUAL "MOD5441X")
    set(CPUFLAG mcpu=54415)
    set(CPU_TYPE MCF5441X)
endif()

set(CMAKE_NBROOT "$ENV{NBROOT}")
if ($ENV{NBROOT} STREQUAL "C:\\nburn")
    set(CMAKE_NBROOT "C:/nburn")
endif()

set(COMPILER_PATH "${CMAKE_NBROOT}/gcc-m68k/bin")
set(CMAKE_SYSROOT "${COMPILER_PATH}/../m68k-unknown-elf/sysroot")

set(CMAKE_C_COMPILER   ${COMPILER_PATH}/m68k-elf-gcc.exe)
set(CMAKE_CXX_COMPILER ${COMPILER_PATH}/m68k-elf-g++.exe)
set(CMAKE_ASM_COMPILER ${COMPILER_PATH}/m68k-elf-as.exe)
set(CMAKE_AR           ${COMPILER_PATH}/m68k-elf-ar.exe)
set(CMAKE_OBJCOPY      ${COMPILER_PATH}/m68k-elf-objcopy.exe)
set(CMAKE_OBJDUMP      ${COMPILER_PATH}/m68k-elf-objdump.exe)
set(CMAKE_RANLIB       ${COMPILER_PATH}/m68k-elf-ranlib.exe)

set(C_NBINCLUDE
	"-I${CMAKE_NBROOT}/gcc-m68k/m68k-unknown-elf/include \
	-I${CMAKE_NBROOT}/include \
	-I${CMAKE_NBROOT}/$ENV{PLATFORM}/include"
)

set(GCC_5_2_0_DIR ${CMAKE_NBROOT}/gcc-m68k/m68k-unknown-elf/include/c++/5.2.0)
set(GCC_8_1_0_DIR ${CMAKE_NBROOT}/gcc-m68k/m68k-unknown-elf/include/c++/8.1.0)

if (EXISTS "${GCC_5_2_0_DIR}" AND IS_DIRECTORY "${GCC_5_2_0_DIR}")
	set(CXX_NBINCLUDE
		"${C_NBINCLUDE} -I${GCC_5_2_0_DIR}"
	)
endif()

if (EXISTS "${GCC_8_1_0_DIR}" AND IS_DIRECTORY "${GCC_8_1_0_DIR}")
	set(CXX_NBINCLUDE
		"${C_NBINCLUDE} -I${GCC_8_1_0_DIR}"
	)
endif()

set(C_FLAGS
	"-${CPUFLAG} -gdwarf-2 -falign-functions=4 -ffunction-sections -fmessage-length=0 -fdata-sections -D$ENV{PLATFORM} -D${CPU_TYPE} -DNBMINGW ${C_NBINCLUDE}"
)

set(CXX_FLAGS
	"-${CPUFLAG} -gdwarf-2 -falign-functions=4 -ffunction-sections -fmessage-length=0 -fdata-sections -fno-rtti -D$ENV{PLATFORM} -D${CPU_TYPE} -DNBMINGW ${CXX_NBINCLUDE}"
)

# CMake C++ flags
set(CMAKE_CXX_FLAGS_DEBUG
	"${CXX_FLAGS} \
	-g \
	-D_DEBUG \
	${EXTRADBCXXFLAGS}"
	CACHE STRING "C++ Debug Flags"
)
set(CMAKE_CXX_FLAGS_RELEASE
	"${CXX_FLAGS} \
	-O3 \
	-DNDEBUG \
	${EXTRACXXFLAGS}"
	CACHE STRING "C++ Release Flags"
)
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO
	"${CXX_FLAGS} \
	-O2 \
	-g \
	-D_DEBUG \
	${EXTRACXXFLAGS}"
	CACHE STRING "C++ Release with Debug Info Flags"
)
set(CMAKE_CXX_FLAGS_MINSIZEREL
	"${CXX_FLAGS} \
	-Os \
	-DNDEBUG \
	${EXTRACXXFLAGS}"
	CACHE STRING "C++ Minimum Size Release Flags"
)

# CMake C flags
set(CMAKE_C_FLAGS_DEBUG
	"${C_FLAGS} \
	-D_DEBUG \
	-g \
	${EXTRADBCFLAGS}"
	CACHE STRING "C Debug Flags"
)
set(CMAKE_C_FLAGS_RELEASE
	"${C_FLAGS} \
	-O3 \
	-DNDEBUG \
	${EXTRACFLAGS}"
	CACHE STRING "C Release Flags"
)
set(CMAKE_C_FLAGS_RELWITHDEBINFO
	"${C_FLAGS} \
	-O2 \
	-g \
	-D_DEBUG \
	${EXTRACFLAGS}"
	CACHE STRING "C Release with Debug Info Flags"
)
set(CMAKE_C_FLAGS_MINSIZEREL
	"${C_FLAGS} \
	-Os \
	-DNDEBUG \
	${EXTRACFLAGS}"
	CACHE STRING "C Minimum Size Release Flags"
)

set(CMAKE_CXX_LINK_FLAGS
	"-${CPUFLAG} -Wl,-n -T${CMAKE_NBROOT}/$ENV{PLATFORM}/lib/$ENV{PLATFORM}.ld \
	-Wl,-R${CMAKE_NBROOT}/$ENV{PLATFORM}/lib/sys.ld \
	${EXTRALINKFLAGS}"
	CACHE STRING "C++ Linker Flags"
)

# cmake built-in settings to use find_xxx() functions
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)