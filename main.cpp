#include <iostream>
#include <errno.h>

int main()
{
    auto e = errno;
    std::cout << "Hello, World!" << e << std::endl;
    return 0;
}
