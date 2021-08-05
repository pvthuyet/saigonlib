cmake_minimum_required (VERSION 3.8 FATAL_ERROR)

project(sgutility LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# show all warnings
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -pedantic")

# Set compiler flags that don't work on Windows
if(NOT MSVC)
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wextra")
endif()

# set name
set(GSL_NAME "GSL-3.1.0")
set(NLOHMANN_NAME "nlohmann-3.9.1")
##### saigonlib ROOT
set(SGLIB_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/../../saigonlib")

## Boost library
set(BOOST_ROOT "${SGLIB_ROOT}/boost_1_74_0")
set(BOOST_INCLUDEDIR "${BOOST_ROOT}")
set(BOOST_LIBRARYDIR "${BOOST_ROOT}/stage/lib")
set(Boost_NO_SYSTEM_PATHS ON)
set(Boost_USE_STATIC_LIBS        ON)  # only find static libs
set(Boost_USE_DEBUG_LIBS         ON)  # ignore debug libs and
set(Boost_USE_RELEASE_LIBS       ON)  # only find release libs
set(Boost_USE_MULTITHREADED      ON)
set(Boost_USE_STATIC_RUNTIME    OFF)
# Note boost 1.75.0 error
find_package(Boost 1.74.0 REQUIRED COMPONENTS date_time regex thread filesystem context coroutine serialization)
if(NOT Boost_FOUND)
	message(FATAL_ERROR "Not found Boost version 1.74.0")
endif()

# Result
message(STATUS "Boost_INCLUDE_DIRS: ${Boost_INCLUDE_DIRS}")
message(STATUS "Boost_LIBRARY_DIRS: ${Boost_LIBRARY_DIRS}")
message(STATUS "Boost_LIBRARIES: ${Boost_LIBRARIES}")
message(STATUS "Boost_VERSION: ${Boost_VERSION}")
message(STATUS "Boost_LIB_VERSION: ${Boost_LIB_VERSION}")
message(STATUS "Boost_MAJOR_VERSION: ${Boost_MAJOR_VERSION}")
message(STATUS "Boost_MINOR_VERSION: ${Boost_MINOR_VERSION}")
message(STATUS "Boost_SUBMINOR_VERSION: ${Boost_SUBMINOR_VERSION}")
message(STATUS "Boost_LIB_DIAGNOSTIC_DEFINITIONS: ${Boost_LIB_DIAGNOSTIC_DEFINITIONS}")

## set include
set(GSL_INCLUDEDIR "${SGLIB_ROOT}/${GSL_NAME}/include")
set(NLOHMANN_INCLUDEDIR "${SGLIB_ROOT}/${NLOHMANN_NAME}/include")

## set lib

## SG library
set(SGLIB_INCLUDEDIR "${GSL_INCLUDEDIR};${Boost_INCLUDE_DIRS};${NLOHMANN_INCLUDEDIR}")
if (CMAKE_BUILD_TYPE STREQUAL "Debug")
	set(SGLIB_LIBRARIES "${Boost_LIBRARIES}")
else()
	set(SGLIB_LIBRARIES "${Boost_LIBRARIES}")
endif()
message(STATUS "SGLIB_INCLUDEDIR: ${SGLIB_INCLUDEDIR}")
message(STATUS "SGLIB_LIBRARIES: ${SGLIB_LIBRARIES}")

## sgutils library
set(HEADER_DIR "${CMAKE_CURRENT_SOURCE_DIR}/include/sgutils")
set (SGUTILS_SOURCES
	"src/sgutils/json_reader.cpp"
)
add_library(sgutils 
	STATIC
	${SGUTILS_SOURCES}
)

target_include_directories(sgutils PRIVATE ${SGLIB_INCLUDEDIR} ${HEADER_DIR})
target_link_libraries(sgutils PRIVATE ${SGLIB_LIBRARIES})

## test project
add_subdirectory("src/tests")

## Install
set(INSTALL_TARGETS_LIST "sgutils")
install(TARGETS ${INSTALL_TARGETS_LIST}
	LIBRARY DESTINATION lib
)