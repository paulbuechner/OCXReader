cmake_minimum_required(VERSION 3.24 FATAL_ERROR)

project(shipxml VERSION ${OCXREADER_VERSION} LANGUAGES CXX)

# Define helper functions and macros used by ocx
include(cmake/internal_utils.cmake)

# Set compile definitions
add_compile_definitions(
  $<$<CONFIG:DEBUG>:SHIPXML_CONFIG_DEBUG>
  $<$<CONFIG:RELEASE>:SHIPXML_CONFIG_RELEASE>
)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}
      -Wno-error=unused-variable -Wunused-variable
      -Wno-error=unused-parameter -Wunused-parameter")

if (CMAKE_SYSTEM_NAME MATCHES "CYGWIN" OR CMAKE_SYSTEM_NAME MATCHES "MSYS")
  set(CMAKE_CXX_EXTENSIONS ON)
endif ()

cxx_library(${PROJECT_NAME} src/shipxml-all.cc)

add_library(ocxreader::${PROJECT_NAME} ALIAS ${PROJECT_NAME})

# Add target_include_directories
target_include_directories(${PROJECT_NAME} PRIVATE SYSTEM
                           ${OpenCASCADE_INCLUDE_DIR}
                           )

target_include_directories(${PROJECT_NAME} PUBLIC
                           "${shipxml_SOURCE_DIR}/include"
                           "${shipxml_SOURCE_DIR}"
                           )

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
