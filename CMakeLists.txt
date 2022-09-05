cmake_minimum_required(VERSION 3.18..3.24)

project(
    ProjectName
    VERSION 0.1.0
    DESCRIPTION "Template project"
    LANGUAGES CXX)

# -----------------------------------------------------------------------------
#                              project options
# -----------------------------------------------------------------------------

option(BUILD_TESTING "Enables building tests." ON)

# -----------------------------------------------------------------------------
#                          general project settings
# -----------------------------------------------------------------------------

if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    # cpp settings
    set(CMAKE_CXX_STANDARD 20)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
    set(CMAKE_CXX_EXTENSIONS OFF)

    # ide support
    set_property(GLOBAL PROPERTY USE_FOLDERS ON)

    # prepare for testing
    include(CTest)

    # doxygen
    # TODO: allow for docs generation
endif()

# requires min. CMake 3.14
include(FetchContent)

# -----------------------------------------------------------------------------
#                       include external dependencies
# -----------------------------------------------------------------------------

# Alternatives
# - for installed libraries: find_package(...)
# - for submodules: add_subdirectory(...)

# formatting library
FetchContent_Declare(
    fmt
    GIT_REPOSITORY https://github.com/fmtlib/fmt.git
    GIT_TAG 9.1.0)
FetchCOntent_MakeAvailable(fmt)

# -----------------------------------------------------------------------------
#                           project targets
# -----------------------------------------------------------------------------

# library target
add_subdirectory(src)

# executable target
add_subdirectory(app)

# testing
if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME AND BUILD_TESTING)
  add_subdirectory(tests)
endif()

