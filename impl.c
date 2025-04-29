#include "impl.h"
#include <stdio.h>

void impl(const char *context)
{
    printf("%s: Executed impl(), wich is provided by impl.so\n", context);
}
