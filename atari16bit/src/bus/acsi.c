#include <stdio.h>
#include <stdint.h>

#include "acsi.h"

int main(int argc, char **argv) 
{
    uint8_t buf[6] = {0x09,0x01,0x00,0x00,0x00,0x00};
    uint8_t *b=buf;
    uint8_t ret = acsi_send_command(b);
    return 0;
}