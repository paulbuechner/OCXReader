cmake_minimum_required(VERSION 3.24 FATAL_ERROR)

project(ocx-test VERSION ${OCXREADER_VERSION} LANGUAGES CXX)

# Define helper functions and macros used by ocx-test
include(cmake/internal_utils.cmake)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Set libs to link against
list(APPEND ocx_test_libs
     ocxreader::ocx
     occutils::occutils
     GTest::gtest
     GTest::gtest_main
     ${OpenCASCADE_LIBRARIES}
     )

# Add executable
cxx_executable("ocx-test-all" src "${ocx_test_libs}")

# Add target_include_directories
target_include_directories("ocx-test-all" PRIVATE SYSTEM
                           ${OpenCASCADE_INCLUDE_DIR}
                           )

target_include_directories("ocx-test-all" PRIVATE
                           ${ocx_test_SOURCE_DIR}
                           )

add_test(NAME ${PROJECT_NAME} COMMAND "ocx-test-all")
