option(ENABLE_UNIT_TESTS "Enable unit tests" ON)
message(STATUS "Enable testing: ${ENABLE_UNIT_TESTS}")
if(ENABLE_UNIT_TESTS)
  # all the remaining CMake code will be placed here
endif()

include(FetchContent)
FetchContent_Declare(
  googletest
  GIT_REPOSITORY https://github.com/google/googletest.git
  GIT_TAG release-1.10.0
)
FetchContent_GetProperties(googletest)

if(NOT googletest_POPULATED)
	FetchContent_Populate(googletest)
	# Prevent GoogleTest from overriding our compiler/linker options
	# when building with Visual Studio
	set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
	# Prevent GoogleTest from using PThreads
	set(gtest_disable_pthreads ON CACHE BOOL "" FORCE)

	# adds the targers: gtest, gtest_main, gmock, gmock_main
	add_subdirectory(
		${googletest_SOURCE_DIR}
		${googletest_BINARY_DIR}
    )

	# Silence std::tr1 warning on MSVC
	if(MSVC)
		foreach(_tgt gtest gtest_main gmock gmock_main)
			target_compile_definitions(${_tgt}
				PRIVATE
					"_SILENCE_TR1_NAMESPACE_DEPRECATION_WARNING"
				)
		endforeach()
	endif()
endif()

# Test test_json_reader
add_executable(test_json_reader 
	"test_json_reader.cpp"
	"${CMAKE_SOURCE_DIR}/src/sgutils/json_reader.cpp"
)
target_include_directories(test_json_reader PRIVATE
	"${CMAKE_SOURCE_DIR}/include/sgutils"
	"${SGLIB_INCLUDEDIR}"
)
target_link_libraries(test_json_reader PRIVATE
	gtest_main
)


enable_testing()

add_test(
  NAME google_test
  COMMAND $<TARGET_FILE:test_json_reader>
  )