# Defines functions and macros useful for making *_APP.s19 executables

# netburner_app(project_name outdir libraries...)
#
# creates a named target *_APP.s19 that depends on the given project name and sources
function(netburner_app project_name outdir)

  set(OBJCOPY_OPTS --output-target=srec)

  if (CMAKE_BUILD_TYPE STREQUAL "Release" OR CMAKE_BUILD_TYPE STREQUAL "MinSizeRel")
      set(OBJCOPY_OPTS --output-target=srec --strip-all)
  endif()

  if(EXISTS "${PROJECT_SOURCE_DIR}/html/index.htm" AND IS_DIRECTORY "${PROJECT_SOURCE_DIR}/html")
      MESSAGE(STATUS "Generating htmldata.cpp" )
      execute_process(
          COMMAND comphtml ${PROJECT_SOURCE_DIR}/html -o${PROJECT_SOURCE_DIR}/htmldata.cpp
            )
      MESSAGE(STATUS "Generating htmldata.cpp - done" )
      add_custom_target(htmldata ALL
          DEPENDS ${PROJECT_SOURCE_DIR}/htmldata.cpp ${PROJECT_SOURCE_DIR}/html/index.htm
          COMMAND comphtml ${PROJECT_SOURCE_DIR}/html -o${PROJECT_SOURCE_DIR}/htmldata.cpp
      )
      target_sources(${project_name} PRIVATE ${PROJECT_SOURCE_DIR}/htmldata.cpp)
  endif()

  add_custom_target(${project_name}_app ALL DEPENDS ${project_name})
  add_custom_command(
      TARGET ${project_name}_app
      POST_BUILD
      COMMAND ${CMAKE_OBJCOPY} ${OBJCOPY_OPTS} ${project_name}.elf ${project_name}.s19
      COMMAND compcode ${project_name}.s19 ${project_name}_APP.s19 -M ${project_name}.map -R 0xC0040000 0xC2000000 -P$ENV{PLATFORM}
      WORKING_DIRECTORY ${outdir}
      VERBATIM
  )

  set(FS_LIBS "${CMAKE_NBROOT}/lib/FatFile.a ${CMAKE_NBROOT}/lib/StdFFile.a")

  set(NBLIBS
      "${NBLIBS} ${CMAKE_NBROOT}/lib/$ENV{PLATFORM}.a \
      ${CMAKE_NBROOT}/lib/NetBurner.a \
      ${FS_LIBS}"
  )

  set(DBNBLIBS
      "${DBNBLIBS} ${CMAKE_NBROOT}/lib/DB$ENV{PLATFORM}.a \
      ${CMAKE_NBROOT}/lib/DBNetBurner.a \
      ${FS_LIBS}"
  )

  if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_link_libraries(${project_name} 
        debug ${ARGN} "-Wl,-Map=${outdir}/${project_name}.map ${EXTRALINKFLAGS} -Wl,--start-group ${DBNBLIBS} -lstdc++ ${EXTRADBLIBS} -Wl,--end-group -Wl,--gc-sections"
    )
  elseif (CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo")
    target_link_libraries(${project_name}
        general ${ARGN} "-Wl,-Map=${outdir}/${project_name}.map ${EXTRALINKFLAGS} -Wl,--start-group ${DBNBLIBS} -lstdc++ ${EXTRADBLIBS} -Wl,--end-group -Wl,--gc-sections"
    )
  else()
    target_link_libraries(${project_name}
        optimized ${ARGN} "-Wl,-Map=${outdir}/${project_name}.map ${EXTRALINKFLAGS} -Wl,--start-group ${NBLIBS} -lstdc++ ${EXTRALIBS} -Wl,--end-group -Wl,--gc-sections"
    )
  endif()
endfunction()