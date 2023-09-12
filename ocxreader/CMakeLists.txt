cmake_minimum_required(VERSION 3.24 FATAL_ERROR)

project(ocxreader VERSION ${OCXREADER_VERSION} LANGUAGES CXX)

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

# warning options
option(OCX_BUILD_WARNINGS "Enable compiler warnings" OFF)

# Define helper functions and macros used by ocxreader
include(cmake/internal_utils.cmake)

# Set compile definitions
add_compile_definitions(
  $<$<CONFIG:DEBUG>:OCXREADER_CONFIG_DEBUG>
  $<$<CONFIG:RELEASE>:OCXREADER_CONFIG_RELEASE>
)

# Set libs to link against
list(APPEND ocxreader_libs
     ocxreader::ocx
     ocxreader::shipxml
     occutils::occutils
     spdlog::spdlog
     Boost::boost
     Boost::program_options
     ${OpenCASCADE_LIBRARIES})

# Add executable
cxx_executable(${PROJECT_NAME} src "${ocxreader_libs}")

# Add target_include_directories
target_include_directories(${PROJECT_NAME} SYSTEM PRIVATE
                           ${OpenCASCADE_INCLUDE_DIR}
                           "${SUBMODULE_DIR}/spdlog_setup/include"
                           )

target_include_directories(${PROJECT_NAME} PRIVATE
                           "${ocxreader_SOURCE_DIR}/include"
                           "${ocxreader_SOURCE_DIR}"
                           )

# Install
include(InstallRequiredSystemLibraries)
install(TARGETS ${PROJECT_NAME}
        DESTINATION ${CMAKE_INSTALL_BINDIR})
install(FILES ${CMAKE_SOURCE_DIR}/README.md ${CMAKE_SOURCE_DIR}/LICENSE
        DESTINATION ${CMAKE_INSTALL_DOCDIR})
install(FILES ${CMAKE_BINARY_DIR}/LICENSE-3RD-PARTY.txt
        DESTINATION ${CMAKE_INSTALL_DOCDIR})
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/config
        DESTINATION ${CMAKE_INSTALL_DOCDIR})

if (WIN32)
  install(FILES $<TARGET_RUNTIME_DLLS:${PROJECT_NAME}>
          DESTINATION ${CMAKE_INSTALL_BINDIR})
else ()
  install_target_deps()
endif ()

# Packaging
set(CPACK_PACKAGE_NAME "OCXReader")
set(CPACK_PACKAGE_VENDOR "PROSTEP")
set(CPACK_PACKAGE_DESCRIPTION
    "A tool to convert vessels in OCX format into 3D geometry and export them to
     different formats.")
set(CPACK_PACKAGE_VERSION "${OCXREADER_VERSION}")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/LICENSE")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "${CPACK_PACKAGE_NAME}")
set(CPACK_PACKAGE_DIRECTORY "${CMAKE_SOURCE_DIR}/packages")

# Set the package types to create
list(APPEND CPACK_GENERATOR "ZIP" "TGZ")

# Optionally add NSIS if it's available
find_program(NSIS_MAKENSIS_EXECUTABLE makensis)

if (NSIS_MAKENSIS_EXECUTABLE)
  list(APPEND CPACK_GENERATOR "NSIS")
  set(CPACK_NSIS_MODIFY_PATH ON) # Does not work always
endif ()

include(CPack) # Must be included last

# Adjust runtime environment for Visual Studio
set_property(
  TARGET ${PROJECT_NAME}
  PROPERTY
  VS_DEBUGGER_ENVIRONMENT
  "PATH=$<$<CONFIG:DEBUG>:${OpenCASCADE_BINARY_DIR}d>$<$<NOT:$<CONFIG:DEBUG>>:${OpenCASCADE_BINARY_DIR}>;%PATH%"
)
