#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <doctest/doctest.h>

#include <libname/lib.hpp>

TEST_CASE("add and sub two values")
{
    uint32_t a = 4;
    uint32_t b = 3;

    INFO("The values are ", a, " and ", b, ".");

    SUBCASE("It works")
    {
        auto const res = add(a, b);
        CHECK_EQ(res, 7);
    }

    SUBCASE("Ohh no.")
    {
        auto const res = sub(a, b);
        CHECK_EQ(res, 1);
    }
}