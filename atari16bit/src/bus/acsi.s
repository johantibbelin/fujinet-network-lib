        .cpu        m68000
        .globl     _acsi_send_command


/* uint8_t sio_read(uint8_t unit, void * buffer, uint16_t len)*/

_acsi_send_command:
    move.l (sp)+,a6
    move.l (sp)+,a1 /* adr for ACSI command */
    move.l #txt,-(sp)
    move.w #9,-(sp)
    trap #1
    addq.l #6,sp
 
    move.l a6,-(sp) /* Put return adr back */
    clr.b d0 /* return 0 */
    rts

txt:
    .asciz "Send ACSI cmd."
