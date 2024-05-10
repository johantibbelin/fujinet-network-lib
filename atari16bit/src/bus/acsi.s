    .cpu        m68000
    .globl     _acsi_send_command

/* EQUs */
    flock   = $43e
    dma     = $ff8606
    data    = $ff8604
    gpip    = $fffa01
    hz200   = $4ba

    dma_lo  = $ff8609
    dma_mid = $ff860b
    dma_hi  = $ff860d

/* uint8_t sio_read(uint8_t unit, void * buffer, uint16_t len)*/

_acsi_send_command:
    move.l (sp)+,a6
    move.l (sp)+,a1 /* adr for ACSI command */
    move.l #txt,-(sp)
    move.w #9,-(sp)
    trap #1
    addq.l #6,sp
 
    move.w #$ff,flock



    move.w #$190,dma
    move.w #$090,dma

    move.w #$088,dma
    move.l #$0009008a,data



    move.l a6,-(sp) /* Put return adr back */
    clr.b d0 /* return 0 */
    rts

txt:
    .asciz "Send ACSI cmd."
