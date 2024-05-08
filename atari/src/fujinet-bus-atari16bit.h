#ifndef FUJINET_BUS_ATARI16BIT_H
#define FUJINET_BUS_ATARI16BIT_H

#include <stdint.h>

// These are for Atari ACSI C headers for internal and not exposed in the normal fujinet header files

uint8_t acsi_read(uint8_t unit, void * buffer, uint16_t len);

#endif
