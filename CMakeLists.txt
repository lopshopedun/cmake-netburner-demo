cmake_minimum_required(VERSION 3.0)

set(MAJ 0)
set(MIN 0)
set(PATCH 1)

set(CMAKE_BUILD_TYPE Release)
set(NBCOMPCODE compcode)
set(COMPCODEFLAGS 0xC0040000 0xC2000000)

if ($ENV{NBROOT} STREQUAL "C:\\nburn")
    set(CMAKE_NBROOT "C:/nburn")
endif()

set(NBLIBS "${NBLIBS} ${CMAKE_NBROOT}/lib/$ENV{PLATFORM}.a ${CMAKE_NBROOT}/lib/NetBurner.a ${CMAKE_NBROOT}/lib/FatFile.a")
set(DBNBLIBS "${CMAKE_NBROOT}/lib/DB$ENV{PLATFORM}.a ${CMAKE_NBROOT}/lib/DBNetBurner.a ${CMAKE_NBROOT}/lib/FatFile.a ${LDEXTRA}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_BUILD_TYPE})
set(NAME cmake-netburner-hello-world)
project(${NAME} VERSION ${MAJ}.${MIN}.${PATCH})
set(SOURCES ${PROJECT_SOURCE_DIR}/main.cpp)

add_definitions(-DPROJECT_NAME="${CMAKE_PROJECT_NAME}_${PROJECT_VERSION}")
add_executable(elf ${SOURCES})
add_custom_target(app DEPENDS elf)
add_custom_command(
    TARGET app
    POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} --strip-all --output-target=srec ${PROJECT_NAME}.elf ${PROJECT_NAME}.s19
    COMMAND ${NBCOMPCODE} ${PROJECT_NAME}.s19 ${PROJECT_NAME}_APP.s19 -M ${PROJECT_NAME}.map -R ${COMPCODEFLAGS} -P$ENV{PLATFORM}
    WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
    VERBATIM
)

target_link_libraries(elf 
    "-Wl,-Map=${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${PROJECT_NAME}.map ${EXTRALINKFLAGS} -Wl,--gc-sections -Wl,--start-group,${NBLIBS} -lstdc++ ${EXTRALIBS} -Wl,--end-group"
)

target_link_libraries(elf 
    ${CMAKE_NBROOT}/lib/$ENV{PLATFORM}.a 
    ${CMAKE_NBROOT}/lib/NetBurner.a 
    ${CMAKE_NBROOT}/lib/FatFile.a
)