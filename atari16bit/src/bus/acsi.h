#ifndef _ACSI_H_
#define _ACSI_H_
/**
 * ACSI functions. commands and DMA.
*/

#include <stdint.h>


uint8_t acsi_send_command(uint8_t *cmd);

uint8_t acsi_dma_send();

uint8_t acsi_dma_recive();

#endif /* _ACSI_H_ */
