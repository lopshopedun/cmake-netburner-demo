cmake_minimum_required(VERSION 3.0)

set(MAJ 0)
set(MIN 0)
set(PATCH 1)

set(NBCOMPCODE compcode)
set(COMPCODEFLAGS 0xC0040000 0xC2000000)

if ($ENV{NBROOT} STREQUAL "C:\\nburn")
    set(CMAKE_NBROOT "C:/nburn")
endif()

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_BUILD_TYPE})
project(cmake-netburner-hello-world VERSION ${MAJ}.${MIN}.${PATCH})

set(SOURCES ${PROJECT_SOURCE_DIR}/main.cpp)
add_definitions(-DPROJECT_NAME="${CMAKE_PROJECT_NAME}_${PROJECT_VERSION}")

set(OBJCOPY_OPTS --strip-all --output-target=srec)

if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(PROJECT_NAME DB${PROJECT_NAME}.elf)
    set(OBJCOPY_OPTS --output-target=srec)
endif()

add_executable(${PROJECT_NAME}.elf ${SOURCES})
add_custom_target(app ALL DEPENDS ${PROJECT_NAME}.elf)
add_custom_command(
    TARGET app
    POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} ${OBJCOPY_OPTS} ${PROJECT_NAME}.elf ${PROJECT_NAME}.s19
    COMMAND ${NBCOMPCODE} ${PROJECT_NAME}.s19 ${PROJECT_NAME}_APP.s19 -M ${PROJECT_NAME}.map -R ${COMPCODEFLAGS} -P$ENV{PLATFORM}
    WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
    VERBATIM
)

set(NBLIBS "${NBLIBS} ${CMAKE_NBROOT}/lib/$ENV{PLATFORM}.a ${CMAKE_NBROOT}/lib/NetBurner.a ${CMAKE_NBROOT}/lib/FatFile.a")
set(DBNBLIBS "${CMAKE_NBROOT}/lib/DB$ENV{PLATFORM}.a ${CMAKE_NBROOT}/lib/DBNetBurner.a ${CMAKE_NBROOT}/lib/FatFile.a")

target_link_libraries(${PROJECT_NAME}.elf 
    optimized "-Wl,-Map=${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${PROJECT_NAME}.map ${EXTRALINKFLAGS} -Wl,--gc-sections -Wl,--start-group,${NBLIBS} -lstdc++ ${EXTRALIBS} -Wl,--end-group"
)

target_link_libraries(${PROJECT_NAME}.elf 
    optimized ${CMAKE_NBROOT}/lib/$ENV{PLATFORM}.a 
    optimized ${CMAKE_NBROOT}/lib/NetBurner.a 
    optimized ${CMAKE_NBROOT}/lib/FatFile.a
)

target_link_libraries(${PROJECT_NAME}.elf 
    debug "-Wl,-Map=${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${PROJECT_NAME}.map ${EXTRALINKFLAGS} -Wl,--gc-sections -Wl,--start-group,${DBNBLIBS} -lstdc++ ${EXTRALIBS} -Wl,--end-group"
)

target_link_libraries(${PROJECT_NAME}.elf 
    debug ${CMAKE_NBROOT}/lib/DB$ENV{PLATFORM}.a 
    debug ${CMAKE_NBROOT}/lib/DBNetBurner.a 
    debug ${CMAKE_NBROOT}/lib/FatFile.a
)