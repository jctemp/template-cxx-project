# Alternative:
# FetchContent_Declare(
# catch
# GIT_REPOSITORY https://github.com/catchorg/Catch2.git
# GIT_TAG v3.1.0)
# FetchContent_MakeAvailable(catch)

FetchContent_Declare(
    doctest
    GIT_REPOSITORY https://github.com/doctest/doctest.git
    GIT_TAG v2.4.9)
FetchContent_MakeAvailable(doctest)

add_executable(testlib testlib.cpp)
target_link_libraries(testlib PRIVATE 
    libname    
    doctest::doctest)

# register to run test with ctest or make test
add_test(NAME testlibtest COMMAND testlib)