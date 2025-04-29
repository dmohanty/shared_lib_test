#include "intf.h"
#include "impl.h"
#include <stdio.h>
#include <dlfcn.h>

void intf(const char *context)
{
    void *impl_handle = dlopen("impl.so", RTLD_NOW);
    if (!impl_handle) {
        fprintf(stderr, "%s: failed to load impl.so\n", context);
        return;
    }
    impl_ptr ptr = (impl_ptr)dlsym(impl_handle, "impl");
    if (!ptr) {
        fprintf(stderr, "%s: failed to lookup intf() in impl.so\n", context);
        return;
    }
    ptr(context);
    dlclose(impl_handle);
}
