#include <libname/lib.hpp>
#include <fmt/core.h>

int main()
{
    auto const value = add(1, 2);
    fmt::print("The value is {}.\n", value);
}
