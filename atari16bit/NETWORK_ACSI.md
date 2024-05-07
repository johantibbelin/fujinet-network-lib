#Network ACSI commands

Network commands is sent with ACSI command 0x09

Since computer always is in control of the ACSI-bus pooling is required.

ACSI command byte 0: | | | <-ID 0x09
ACSI command byte 1: Network command
ACSI command byte 2: connection id
ACSI command byte 3: Number of bytes high
ACSI command byte 4: Number of bytes low
ACSI command byte 5: Control byte

cmd 0xFF pool for network traffic 
