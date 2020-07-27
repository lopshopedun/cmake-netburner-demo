# Defines functions and macros useful for making *_APP.s19 executables

# netburner_app(project_name outdir srcs...)
#
# creates a named target *_APP.s19 that depends on the given project name and sources
function(netburner_app project_name outdir)

  set(OBJCOPY_OPTS --strip-all --output-target=srec)

  if (CMAKE_BUILD_TYPE STREQUAL "Debug")
      set(project_name DB${project_name})
      set(OBJCOPY_OPTS --output-target=srec)
  endif()

  add_executable(${project_name} ${ARGN})

  if(EXISTS "${PROJECT_SOURCE_DIR}/html" AND IS_DIRECTORY "${PROJECT_SOURCE_DIR}/html")
      if( NOT EXISTS ${PROJECT_SOURCE_DIR}/htmldata.cpp )
        MESSAGE( "-- Generating htmldata.cpp" )
        execute_process(
            COMMAND comphtml ${PROJECT_SOURCE_DIR}/html -o${PROJECT_SOURCE_DIR}/htmldata.cpp
              )
        MESSAGE( "-- Generating htmldata.cpp - done" )
      endif()
      add_custom_target(htmldata ALL
          DEPENDS ${PROJECT_SOURCE_DIR}/htmldata.cpp ${PROJECT_SOURCE_DIR}/html/index.htm
          COMMAND comphtml ${PROJECT_SOURCE_DIR}/html -o${PROJECT_SOURCE_DIR}/htmldata.cpp
      )
      target_sources(${project_name} PRIVATE ${PROJECT_SOURCE_DIR}/htmldata.cpp)
  endif()

  add_custom_target(app ALL DEPENDS ${project_name})
  add_custom_command(
      TARGET app
      POST_BUILD
      COMMAND ${CMAKE_OBJCOPY} ${OBJCOPY_OPTS} ${project_name} ${project_name}.s19
      COMMAND compcode ${project_name}.s19 ${project_name}_APP.s19 -M ${project_name}.map -R 0xC0040000 0xC2000000 -P$ENV{PLATFORM}
      WORKING_DIRECTORY ${outdir}
      VERBATIM
  )

  set(NBLIBS "${NBLIBS} ${CMAKE_NBROOT}/lib/$ENV{PLATFORM}.a ${CMAKE_NBROOT}/lib/NetBurner.a ${CMAKE_NBROOT}/lib/FatFile.a ${CMAKE_NBROOT}/lib/StdFFile.a")
  set(DBNBLIBS "${CMAKE_NBROOT}/lib/DB$ENV{PLATFORM}.a ${CMAKE_NBROOT}/lib/DBNetBurner.a ${CMAKE_NBROOT}/lib/FatFile.a ${CMAKE_NBROOT}/lib/StdFFile.a")

  target_link_libraries(${project_name} 
      optimized "-Wl,-Map=${outdir}/${project_name}.map ${EXTRALINKFLAGS} -Wl,--gc-sections -Wl,--start-group,${NBLIBS} -lstdc++ ${EXTRALIBS} -Wl,--end-group"
  )

  target_link_libraries(${project_name} 
      optimized ${CMAKE_NBROOT}/lib/$ENV{PLATFORM}.a 
      optimized ${CMAKE_NBROOT}/lib/NetBurner.a 
      optimized ${CMAKE_NBROOT}/lib/FatFile.a
      optimized ${CMAKE_NBROOT}/lib/StdFFile.a
  )

  target_link_libraries(${project_name} 
      debug "-Wl,-Map=${outdir}/${project_name}.map ${EXTRALINKFLAGS} -Wl,--gc-sections -Wl,--start-group,${DBNBLIBS} -lstdc++ ${EXTRADBLIBS} -Wl,--end-group"
  )

  target_link_libraries(${project_name} 
      debug ${CMAKE_NBROOT}/lib/DB$ENV{PLATFORM}.a 
      debug ${CMAKE_NBROOT}/lib/DBNetBurner.a 
      debug ${CMAKE_NBROOT}/lib/FatFile.a
      debug ${CMAKE_NBROOT}/lib/StdFFile.a
  )
  
endfunction()