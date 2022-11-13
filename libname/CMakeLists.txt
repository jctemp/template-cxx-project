# Alternative (requires CMake 3.12+):
# file(GLOB LIBRARY_HDRS CONFIGURE_DEPENDS "../include/libname/*.hpp")
# file(GLOB LIBRARY_SRCS CONFIGURE_DEPENDS "./*.cpp")

set(LIBRARY "libname")
set(LIBRARY_INCL "./include")
set(LIBRARY_HRDS "./include/libname/lib.hpp")
set(LIBRARY_SRCS "./src/lib.cpp")

# creates a static library
add_library(${LIBRARY} STATIC "${LIBRARY_HRDS}" "${LIBRARY_SRCS}")

# set the include directory (important for other targets)
target_include_directories(${LIBRARY} PUBLIC ${LIBRARY_INCL})

# set properties
set_target_properties(${LIBRARY} PROPERTIES
    POSITION_INDEPENDENT_CODE ON)

generate_testing(
    TARGET ${LIBRARY}_demo
    SOURCES ./src/lib_test.cpp
    DEPENDENCIES ${LIBRARY}
)
