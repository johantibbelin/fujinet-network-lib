#ifdef _DEBUG_
#include <osbind.h>
#include <stdio.h>
void debug_println(char *s)
{
    char t;
    while (*s != 0)
    {
        t=*(s)++;
        Bconout(1,t);
    }
}

#else
void debug_println(char *s) {}
#endif /* _DEBUG_ */