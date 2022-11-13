# Prepares documentation generation. Needs to be called before generate_docs().
# You have to set the variable PROJECT_ENABLE_DOCUMENTATION to ON to enable process.
function(initialise_docs)
    if(NOT ${PROJECT_ENABLE_DOCUMENTATION})
        return()
    endif()

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

    if(NOT ${DOXYGEN_FOUND})
        message(WARNING "Doxygen need to be installed to generate documentation.")
        return()
    endif()

    message(STATUS "Generate documentation target.")

    set(PREFIX DOCS)
    set(OPTIONS_ARGS STYLESHEET OUTPUT_DIRECTORY)
    set(VALUE_ARGS TARGET)
    set(MULTIVALUE_ARGS SOURCES)
    cmake_parse_arguments(${PREFIX} "${OPTIONS_ARGS}" "${VALUE_ARGS}"
        "${MULTIVALUE_ARGS}" ${ARGN})

    if(NOT DEFINED DOCS_TARGET)
        message(WARNING "-- Docs Target is missing a name. (Key: TARGET)")
        return()
    endif()

    if(NOT DEFINED DOCS_SOURCES)
        message(WARNING "-- Input files are undefined. (Key: SOURCES)")
        return()
    endif()

    if(DEFINED DOCS_OUTPUT_DIRECTORY)
        set(DOXYGEN_OUTPUT_DIRECTORY ${DOCS_OUTPUT_DIRECTORY})
    else()
        set(DOXYGEN_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/docs)
    endif()

    message(STATUS "-- Documentation output directory: ${DOXYGEN_OUTPUT_DIRECTORY}")

    if(DEFINED DOCS_STYLESHEET AND EXISTS ${DOCS_STYLESHEET})
        set(DOXYGEN_HTML_EXTRA_STYLESHEET ${DOCS_STYLESHEET})
    else()
        set(DOXYGEN_HTML_EXTRA_STYLESHEET
            ${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.css
            ${CMAKE_CURRENT_SOURCE_DIR}/DoxyfileSidebar.css)
        set(DOXYGEN_DISABLE_INDEX NO)
        set(DOXYGEN_GENERATE_TREEVIEW YES)
        set(DOXYGEN_FULL_SIDEBAR NO)
    endif()

    message(STATUS "-- Applying following CSS: ${DOXYGEN_HTML_EXTRA_STYLESHEET}")

    doxygen_add_docs(${DOCS_TARGET} ${DOCS_SOURCES})
endfunction(generate_docs)
