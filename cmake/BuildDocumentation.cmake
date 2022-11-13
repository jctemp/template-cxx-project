# Prepares documentation generation. Needs to be called before generate_docs().
# You have to set the variable PROJECT_ENABLE_DOCUMENTATION to ON to enable process.
function(initialise_docs)
    if(NOT ${PROJECT_ENABLE_DOCUMENTATION})
        return()
    endif()

    message(STATUS "Initialising doxygen.")

    find_package(Doxygen)

    if(NOT DOXYGEN_FOUND)
        message(FATAL_ERROR "Cannot initalise docs generation.")
    endif()
endfunction(initialise_docs)

# Generates a target to build documentation files with doxygen. You have to set
# the variable PROJECT_ENABLE_DOCUMENTATION to ON to enable process.
#
# Required arguments
# TARGET: name of the documentation target
# SOURCES: specify folders or files that should have generated docs.
#
# Optional arguments
# OUTPUT_DIRECTORY: specify a output directory (default: project-dir/docs)
# STYLESHEET: specify custom styling (default: see project dir.)
function(generate_docs)
    if(NOT ${PROJECT_ENABLE_DOCUMENTATION})
        return()
    endif()

    message(STATUS "Generate documentation target.")

    set(PREFIX DOCS)
    set(OPTIONS_ARGS)
    set(VALUE_ARGS TARGET OUTPUT_DIRECTORY STYLESHEET)
    set(MULTIVALUE_ARGS SOURCES)
    cmake_parse_arguments(${PREFIX} "${OPTIONS_ARGS}" "${VALUE_ARGS}"
        "${MULTIVALUE_ARGS}" ${ARGN})

    if(NOT DEFINED ${PREFIX}_TARGET)
        message(WARNING "-- Docs Target is missing a name. (Key: TARGET)")
        return()
    endif()

    if(NOT DEFINED ${PREFIX}_SOURCES)
        message(WARNING "-- Input files are undefined. (Key: SOURCES)")
        return()
    endif()

    if(DEFINED ${PREFIX}_OUTPUT_DIRECTORY)
        set(DOXYGEN_OUTPUT_DIRECTORY ${${PREFIX}_OUTPUT_DIRECTORY})
    else()
        set(DOXYGEN_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/docs)
    endif()

    message(STATUS "-- Documentation output directory: ${DOXYGEN_OUTPUT_DIRECTORY}")

    if(DEFINED ${PREFIX}_STYLESHEET AND EXISTS ${${PREFIX}_STYLESHEET})
        set(DOXYGEN_HTML_EXTRA_STYLESHEET ${${PREFIX}_STYLESHEET})
    else()
        set(DOXYGEN_STYLES_PATH ${CMAKE_CURRENT_BINARY_DIR}/doxygen-awesome-css)

        if(NOT EXISTS ${DOXYGEN_STYLES_PATH})
            find_package(Git QUIET)

            if(NOT Git_FOUND)
                message(FATAL_ERROR "Cannot find git for dependencies.")
            endif(NOT Git_FOUND)

            message(STATUS "-- Clone dependencies")
            execute_process(
                COMMAND ${GIT_EXECUTABLE} clone "https://github.com/jothepro/doxygen-awesome-css.git"
                WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                RESULT_VARIABLE GIT_CLONE_RESULT)

            if(NOT GIT_CLONE_RESULT EQUAL "0")
                message(FATAL_ERROR "git failed with: ${GIT_CLONE_RESULT}")
            endif(NOT GIT_CLONE_RESULT EQUAL "0")
        endif(NOT EXISTS ${DOXYGEN_STYLES_PATH})

        message(STATUS "-- Set doxygen variables")
        set(DOXYGEN_HTML_EXTRA_STYLESHEET
            ${DOXYGEN_STYLES_PATH}/doxygen-awesome.css
            ${DOXYGEN_STYLES_PATH}/doxygen-awesome-sidebar-only.css)
        set(DOXYGEN_DISABLE_INDEX NO)
        set(DOXYGEN_GENERATE_TREEVIEW YES)
        set(DOXYGEN_FULL_SIDEBAR NO)
    endif()

    doxygen_add_docs(${${PREFIX}_TARGET} ${${PREFIX}_SOURCES})
endfunction(generate_docs)
