cmake_minimum_required(VERSION 3.1)

set(MAJ 0)
set(MIN 0)
set(PATCH 4)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_BUILD_TYPE})
project(cmake-netburner-hello-world VERSION ${MAJ}.${MIN}.${PATCH})

set(SOURCES ${PROJECT_SOURCE_DIR}/main.cpp)
add_definitions(-DPROJECT_NAME="${CMAKE_PROJECT_NAME}_${PROJECT_VERSION}")
set(PROJECT_NAME "${CMAKE_PROJECT_NAME}_${PROJECT_VERSION}")

# NetBurner-related stuff
include(${PROJECT_SOURCE_DIR}/netburner-internal.cmake)

netburner_app(${PROJECT_NAME}.elf ${CMAKE_RUNTIME_OUTPUT_DIRECTORY} ${SOURCES})
