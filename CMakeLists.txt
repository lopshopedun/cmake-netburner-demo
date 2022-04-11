cmake_minimum_required(VERSION 3.1)

set(MAJ 0)
set(MIN 0)
set(PATCH 6)

project(cmake-netburner-hello-world
	VERSION ${MAJ}.${MIN}.${PATCH}
	LANGUAGES C CXX
)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_C_STANDARD 11)

set(CMAKE_PROJECT_NAME "${CMAKE_PROJECT_NAME}_${PROJECT_VERSION}")
add_definitions(-DPROJECT_NAME="${CMAKE_PROJECT_NAME}")
add_executable(${CMAKE_PROJECT_NAME}
	main.cpp
)

# standard compiler warnings
include(cmake/CompilerWarnings.cmake)

# Link the library "project_warnings" to use the warnings specified in CompilerWarnings.cmake
add_library(project_warnings INTERFACE)
set_project_warnings(project_warnings)
target_compile_options(${CMAKE_PROJECT_NAME} INTERFACE project_warnings)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_BUILD_TYPE})
set_target_properties(${CMAKE_PROJECT_NAME} 
	PROPERTIES
	RUNTIME_OUTPUT_DIRECTORY "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}"
	SUFFIX ".elf"
)

# NetBurner-related stuff
include(cmake/netburner-internal.cmake)
netburner_app(${CMAKE_PROJECT_NAME} 
			  ${CMAKE_RUNTIME_OUTPUT_DIRECTORY} 
			  ${SOURCES}
			  project_warnings
)
