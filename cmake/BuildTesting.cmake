# Prepares documentation generation. Needs to be called before generate_testing().
# You have to set the variable PROJECT_ENABLE_TESTING to ON to enable process.
function(initialise_testing)
    if(NOT ${PROJECT_ENABLE_TESTING})
        return()
    endif()

    include(CTest)
    enable_testing()
    FetchContent_Declare(
        doctest
        GIT_REPOSITORY https://github.com/doctest/doctest.git
        GIT_TAG v2.4.9)
    FetchContent_MakeAvailable(doctest)
endfunction(initialise_testing)

# Generates a specified test target. You have to set the variable
# PROJECT_ENABLE_TESTING to ON to enable process. Note: One test file is required
# to have `#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN` as definition.
#
# Required arguments
# TARGET: name of the testing target. Note: test_ will be added as prefix.
# SOURCES: source files associated with the testing target.
#
# Optional arguments
# DEPENDENCIES: define dependencies of a testing target.
function(generate_testing)
    if(NOT ${PROJECT_ENABLE_TESTING})
        return()
    endif()

    message(STATUS "Generate testing target.")

    set(PREFIX TESTS)
    set(VALUE_ARGS TARGET)
    set(MULTIVALUE_ARGS SOURCES DEPENDENCIES)
    cmake_parse_arguments(TESTS "${OPTION_ARGS}" "${VALUE_ARGS}"
        "${MULTIVALUE_ARGS}" ${ARGN})

    if(NOT DEFINED ${PREFIX}_TARGET)
        message(WARNING "-- Testing target name was not defined. (Key: TARGET)")
        return()
    endif(NOT DEFINED ${PREFIX}_TARGET)

    if(NOT DEFINED ${PREFIX}_SOURCES)
        message(WARNING "-- Input source files not defined. (Key: SOURCES)")
        return()
    endif(NOT DEFINED ${PREFIX}_SOURCES)

    if(NOT DEFINED ${PREFIX}_DEPENDENCIES)
        message(STATUS "-- Tests has not dependencies specified. (Key: DEPENDENCIES)")
    endif(NOT DEFINED ${PREFIX}_DEPENDENCIES)

    message(STATUS "-- Prepare test target.")

    set(TEST_NAME "test_${${PREFIX}_TARGET}")
    add_executable(${TEST_NAME} ${${PREFIX}_SOURCES})
    target_link_libraries(${TEST_NAME} PRIVATE
        doctest::doctest ${${PREFIX}_DEPENDENCIES})
    target_compile_definitions(${TEST_NAME} PRIVATE DOCTEST_GUARD_FOR_SRC)

    message(STATUS "-- Register test for ctest.")

    add_test(
        NAME ${TEST_NAME}
        COMMAND ${TEST_NAME})
endfunction(generate_testing)
