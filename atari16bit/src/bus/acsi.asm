#NO_APP
	.text
	.even
	.globl	_main
_main:
	lea (-12,%sp),%sp
	jsr ___main
	move.b #9,1(%sp)
	move.b #1,2(%sp)
	clr.b 3(%sp)
	clr.b 4(%sp)
	clr.b 5(%sp)
	clr.b 6(%sp)
	lea (12,%sp),%a0
	lea (-11,%a0),%a0
	move.l %a0,8(%sp)
	move.l 8(%sp),-(%sp)
	jsr _acsi_send_command
	addq.l #4,%sp
	move.b %d0,7(%sp)
	moveq #0,%d0
	lea (12,%sp),%sp
	rts
