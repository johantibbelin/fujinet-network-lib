#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "fujinet-fuji.h"
#include "fujinet-fuji-cbm.h"

bool fuji_get_host_slots(HostSlot *h, size_t size)
{
	uint8_t *hs_data;
	int bytes_read;
	int max_hs_data_size = 8 * sizeof(HostSlot); // 1 page, as 8 * 32 = 256
	uint8_t pl[1];

	pl[0] = FUJICMD_READ_HOST_SLOTS;
	if (fuji_cbm_open(FUJI_CMD_CHANNEL, FUJI_CBM_DEV, FUJI_CMD_CHANNEL, 1, pl) != 0) {
		return false;
	}

	// this needs work. At the moment, the FN has a limit of 8 host slots. But if we want to be more flexible going forward, we
	// shouldn't have to force the entire list into memory, and applications should loop through each one, so we can make the
	// limit to be anything we want in FN (e.g. 100 hosts!) and not affect the hosts memory because we "get all hosts" here
	hs_data = malloc(max_hs_data_size);
	if (hs_data == NULL) {
		return false;
	}

	bytes_read = cbm_read(FUJI_CMD_CHANNEL, max_hs_data_size, hs_data);
	cbm_close(FUJI_CMD_CHANNEL);
	if (bytes_read != sizeof(HostSlot) * size) {
		// we didn't get the right amount of data back.
		// frankly this whole thing is a bit shit, we're using fixed sized strings because 'atari'.
		// The contract of this function is copy no data if the size doesn't match what was asked for.
		free(hs_data);
		return false;
	}

	// matched the size expecting, so copy it into the target array, and release the memory we used as a buffer
	memcpy(h, hs_data, bytes_read);
	free(hs_data);

	return true;
}
