cmake_minimum_required(VERSION 3.18..3.24)

project(
    "Project Name"
    VERSION 0.1.0
    DESCRIPTION "Template project"
    LANGUAGES CXX)

# -----------------------------------------------------------------------------
# general project settings
# -----------------------------------------------------------------------------
if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    # include module path
    set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

    # cpp settings
    set(CMAKE_CXX_STANDARD 20)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
    set(CMAKE_CXX_EXTENSIONS OFF)

    # ide support
    set_property(GLOBAL PROPERTY USE_FOLDERS ON)

    include(FetchContent)
    include(BuildTesting)
    include(BuildDocumentation)
endif()

# -----------------------------------------------------------------------------
# test generation
# -----------------------------------------------------------------------------
option(BUILD_TESTING "Enables building tests." OFF)

if(${BUILD_TESTING} AND CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    # prepare for testing
    # Note: makes generate_testing(...) available to use
    set(PROJECT_ENABLE_TESTING ON)
    initialise_testing()
endif(${BUILD_TESTING} AND CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)

# -----------------------------------------------------------------------------
# documentation generation
# -----------------------------------------------------------------------------
option(BUILD_DOCUMENTATION "Enables target for documentation" OFF)

if(${BUILD_DOCUMENTATION} AND CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    set(PROJECT_ENABLE_DOCUMENTATION ON)
    initialise_docs()

    # Addition options:
    # - OUTPUT_DIRECTORY of the doxygen html
    # - STYLESHEET of the html
    generate_docs(
        TARGET "docs"
        "./libname" "./README.md"
    )
endif(${BUILD_DOCUMENTATION} AND CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)

# -----------------------------------------------------------------------------
# include external dependencies
# -----------------------------------------------------------------------------
FetchContent_Declare(
    fmt
    GIT_REPOSITORY https://github.com/fmtlib/fmt.git
    GIT_TAG 9.1.0
)
FetchContent_MakeAvailable(fmt)

# - for installed libraries: find_package(...)
# - for submodules: add_subdirectory(...)
# - for comfort: FetchContent_Declare(...) and FetchContent_MakeAvailable(...)

# -----------------------------------------------------------------------------
# project targets
# -----------------------------------------------------------------------------

# library target
add_subdirectory(libname)

# executable target
add_subdirectory(app)
