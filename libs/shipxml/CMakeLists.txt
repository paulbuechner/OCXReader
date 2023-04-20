cmake_minimum_required(VERSION 3.24 FATAL_ERROR)

project(shipxml VERSION ${OCXREADER_VERSION} LANGUAGES CXX)

# Needed to set the namespace for both the export targets and the
# alias libraries
set(cmake_package_name ocxreader CACHE INTERNAL "")

# Set default build to release
if (NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose Release or Debug" FORCE)
endif ()

# Compiler config
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if (CMAKE_SYSTEM_NAME MATCHES "CYGWIN" OR CMAKE_SYSTEM_NAME MATCHES "MSYS")
  set(CMAKE_CXX_EXTENSIONS ON)
endif ()

# These commands only run if this is the main project
if (CMAKE_PROJECT_NAME STREQUAL "shipxml")
  # BUILD_SHARED_LIBS is a standard CMake variable, but we declare it here to
  # make it prominent in the GUI.
  option(BUILD_SHARED_LIBS "Build shared libraries (DLLs)." OFF)
endif ()

# warning options
option(SHIPXML_BUILD_WARNINGS "Enable compiler warnings" OFF)

# Define helper functions and macros used by ocx
include(cmake/internal_utils.cmake)

# Set compile definitions
add_compile_definitions(
  $<$<CONFIG:DEBUG>:SHIPXML_CONFIG_DEBUG>
  $<$<CONFIG:RELEASE>:SHIPXML_CONFIG_RELEASE>
)

cxx_library(${PROJECT_NAME} src/shipxml-all.cc)

# Add target_include_directories
target_include_directories(${PROJECT_NAME} SYSTEM PRIVATE
                           ${OpenCASCADE_INCLUDE_DIR}
                           )

if (SHIPXML_BUILD_WARNINGS)
  target_enable_warnings(${PROJECT_NAME})
endif ()

# If the CMake version supports it, attach header directory information
# to the targets for when we are part of a parent build (ie being pulled
# in via add_subdirectory() rather than being a standalone build).
if (DEFINED CMAKE_VERSION AND NOT "${CMAKE_VERSION}" VERSION_LESS "2.8.11")
  target_include_directories(${PROJECT_NAME} PUBLIC
                             "$<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include>"
                             "$<INSTALL_INTERFACE:$<INSTALL_PREFIX>/${CMAKE_INSTALL_INCLUDEDIR}>"
                             )
endif ()

# Set target link libraries
target_link_libraries(${PROJECT_NAME} PRIVATE
                      ocxreader::ocx
                      magic_enum::magic_enum
                      spdlog::spdlog
                      occutils::occutils
                      )

# Adjust runtime environment for Visual Studio
set_property(
  TARGET ${PROJECT_NAME}
  PROPERTY
  VS_DEBUGGER_ENVIRONMENT
  "PATH=$<$<CONFIG:DEBUG>:${OpenCASCADE_BINARY_DIR}d>$<$<NOT:$<CONFIG:DEBUG>>:${OpenCASCADE_BINARY_DIR}>;%PATH%"
)
