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

    /* Reset DMA */
    move.w #$190,dma
    move.w #$090,dma

    /* Load sector count register */
    move.w #$01,data

    move.w #$088,dma
    
    move.b #4,d2

.loop:    
    move.b (a1)+,d1
    swap d1
    move.w #$008a,d1
    move.l d1,data

    moveq.l #2,d3
    add.l hz200,d3

del20mic:
    cmp.l hz200,d3
    bge del200mic

    move.l #600,d3
    add.l hz200,d3
del3sec:
    btst.b #5,gpip
    beq exit
    cmp.l hz200,d3
    bge del3sec

    move.l #-1,d0
    bra err
exit:
    

    dbra d2,.loop
    
    /* Send last byte */
    move.b (a1)+,d1
    swap d1
    move.w #$0000,d1
    move.l d1,data

    /* Get status byte */
    move.b #$8a,dma
    move.b data,d0


err:
    /* restore flock */
    move.w #$00,flock
    move.l a6,-(sp) /* Put return adr back */
    
    rts

txt:
    .asciz "Send ACSI cmd."
