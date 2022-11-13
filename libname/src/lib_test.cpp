#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <doctest/doctest.h>

#include <libname/lib.hpp>

TEST_CASE("Adding two numbers") {
    int32_t a{5};
    int32_t b{3};

    int32_t result{add(a, b)};
    CHECK_EQ(result, 8);
}

TEST_CASE("Subtracting two number.") {
    int32_t a{5};
    int32_t b{3};

    int32_t result{sub(a, b)};
    CHECK_EQ(result, 2);
}
