# Alternative (requires CMake 3.12+):
# file(GLOB LIBNAME_HDRS CONFIGURE_DEPENDS "../include/libname/*.hpp")
# file(GLOB LIBNAME_SRCS CONFIGURE_DEPENDS "./*.cpp")

set(LIBNAME_SRCS "./lib.cpp")
set(LIBNAME_HDRS "../include/libname/lib.hpp")

# creates a static library
add_library(libname ${LIBNAME_HDRS} ${LIBNAME_SRCS})

# set the include directory (important for other targets)
target_include_directories(libname PUBLIC "../include")

# set properties
set_target_properties(libname PROPERTIES
    POSITION_INDEPENDENT_CODE ON)

# # link against other libraries
# target_link_libraries(libname PUBLIC ...)
