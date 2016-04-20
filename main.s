	.cpu arm7tdmi
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
	.align	2
	.global	interruptHandler
	.type	interruptHandler, %function
interruptHandler:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r3, #67108864
	add	r3, r3, #512
	ldrh	r2, [r3, #2]
	tst	r2, #1
	mov	r2, #0	@ movhi
	strh	r2, [r3, #8]	@ movhi
	beq	.L2
	ldr	r3, .L9
	ldr	r2, [r3, #12]
	cmp	r2, #0
	beq	.L3
	ldr	r2, [r3, #28]
	ldr	r1, [r3, #20]
	cmp	r2, r1
	blt	.L4
	ldr	r1, [r3, #16]
	cmp	r1, #0
	bne	.L4
	ldr	r0, .L9+4
	ldr	ip, [r0, #0]
	mov	r0, #67108864
	add	ip, ip, #12
	add	r0, r0, #256
	str	r1, [ip, #8]
	strh	r1, [r0, #2]	@ movhi
	str	r1, [r3, #12]
.L4:
	add	r2, r2, #1
	str	r2, [r3, #28]
.L3:
	ldr	r3, .L9+8
	ldr	r2, [r3, #12]
	cmp	r2, #0
	bne	.L8
.L5:
	mov	r3, #67108864
	add	r3, r3, #512
	mov	r2, #1	@ movhi
	strh	r2, [r3, #2]	@ movhi
.L2:
	mov	r3, #67108864
	add	r3, r3, #512
	mov	r2, #1	@ movhi
	strh	r2, [r3, #8]	@ movhi
	bx	lr
.L8:
	ldr	r2, [r3, #28]
	ldr	r1, [r3, #20]
	cmp	r2, r1
	blt	.L6
	ldr	r1, [r3, #16]
	cmp	r1, #0
	bne	.L6
	ldr	r0, .L9+4
	ldr	ip, [r0, #0]
	mov	r0, #67108864
	add	ip, ip, #24
	add	r0, r0, #256
	str	r1, [ip, #8]
	strh	r1, [r0, #6]	@ movhi
	str	r1, [r3, #12]
.L6:
	add	r2, r2, #1
	str	r2, [r3, #28]
	b	.L5
.L10:
	.align	2
.L9:
	.word	soundA
	.word	dma
	.word	soundB
	.size	interruptHandler, .-interruptHandler
	.align	2
	.global	initialize
	.type	initialize, %function
initialize:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L15
	stmfd	sp!, {r4, r5}
	ldr	r1, [r3, #0]
	ldr	r3, .L15+4
	mov	r0, #1
	mov	r2, #0
	str	r0, [r3, #16]
	str	r0, [r3, #20]
	mov	r0, #64
	mov	ip, #16
	mov	r4, #32
	str	r0, [r3, #0]
	cmp	r1, r2
	mov	r0, #72
	str	r4, [r3, #24]
	str	ip, [r3, #28]
	str	r0, [r3, #4]
	str	r2, [r3, #32]
	str	r2, [r3, #48]
	str	r2, [r3, #36]
	ble	.L11
	ldr	r3, .L15+8
	rsb	r1, r1, r1, asl #3
	add	r5, r3, r1, asl #3
	mov	r4, #8
	mov	r0, #100
	mov	r1, r2
.L13:
	str	r2, [r3, #12]
	str	r4, [r3, #24]
	str	ip, [r3, #28]
	str	r0, [r3, #8]
	str	r1, [r3, #52]
	str	r1, [r3, #36]
	add	r3, r3, #56
	cmp	r3, r5
	add	r2, r2, #100
	bne	.L13
.L11:
	ldmfd	sp!, {r4, r5}
	bx	lr
.L16:
	.align	2
.L15:
	.word	.LANCHOR0
	.word	reggie
	.word	vase
	.size	initialize, .-initialize
	.align	2
	.global	splash
	.type	splash, %function
splash:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	mov	r4, #1040
	mov	r6, #67108864
	add	r4, r4, #4
	ldr	r3, .L20
	ldr	r0, .L20+4
	strh	r4, [r6, #0]	@ movhi
	mov	lr, pc
	bx	r3
	ldr	r5, .L20+8
	ldr	r0, .L20+12
	mov	lr, pc
	bx	r5
	ldr	r3, .L20+16
	mov	lr, pc
	bx	r3
	ldr	r0, .L20+12
	mov	lr, pc
	bx	r5
	ldr	r3, .L20+20
	ldr	r2, .L20+24
	ldr	r0, [r3, #0]
	ldr	r2, [r2, #0]
	add	r0, r0, #1
	tst	r2, #8
	str	r0, [r3, #0]
	beq	.L17
	ldr	r3, .L20+28
	ldr	r3, [r3, #0]
	ands	r3, r3, #8
	beq	.L19
.L17:
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
.L19:
	ldr	r1, .L20+32
	add	r2, r6, #256
	strh	r3, [r2, #2]	@ movhi
	str	r3, [r1, #12]
	strh	r3, [r2, #6]	@ movhi
	ldr	r2, .L20+36
	str	r3, [r2, #12]
	ldr	r3, .L20+40
	mov	lr, pc
	bx	r3
	ldr	r3, .L20+44
	mov	r2, #1
	strh	r4, [r6, #0]	@ movhi
	str	r2, [r3, #0]
	b	.L17
.L21:
	.align	2
.L20:
	.word	loadPalette
	.word	splashPal
	.word	drawBackgroundImage4
	.word	splashBitmap
	.word	flipPage
	.word	.LANCHOR1
	.word	oldButtons
	.word	buttons
	.word	soundA
	.word	soundB
	.word	srand
	.word	state
	.size	splash, .-splash
	.align	2
	.global	win
	.type	win, %function
win:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	ldr	r3, .L24
	ldr	r0, .L24+4
	mov	lr, pc
	bx	r3
	ldr	r4, .L24+8
	ldr	r0, .L24+12
	mov	lr, pc
	bx	r4
	ldr	r3, .L24+16
	mov	lr, pc
	bx	r3
	ldr	r0, .L24+12
	mov	lr, pc
	bx	r4
	ldr	r3, .L24+20
	ldr	r3, [r3, #0]
	tst	r3, #8
	beq	.L22
	ldr	r3, .L24+24
	ldr	r3, [r3, #0]
	ands	r3, r3, #8
	bne	.L22
	mov	r2, #1040
	add	r2, r2, #4
	mov	r1, #67108864
	strh	r2, [r1, #0]	@ movhi
	ldr	r2, .L24+28
	str	r3, [r2, #0]
.L22:
	ldmfd	sp!, {r4, lr}
	bx	lr
.L25:
	.align	2
.L24:
	.word	loadPalette
	.word	winPal
	.word	drawBackgroundImage4
	.word	winBitmap
	.word	flipPage
	.word	oldButtons
	.word	buttons
	.word	state
	.size	win, .-win
	.align	2
	.global	lose
	.type	lose, %function
lose:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r0, #50
	stmfd	sp!, {r3, lr}
	mov	r1, r0
	mov	r3, #4
	ldr	r2, .L28
	ldr	ip, .L28+4
	mov	lr, pc
	bx	ip
	ldr	r3, .L28+8
	ldr	r3, [r3, #0]
	tst	r3, #8
	beq	.L26
	ldr	r3, .L28+12
	ldr	r3, [r3, #0]
	ands	r3, r3, #8
	bne	.L26
	mov	r2, #1040
	add	r2, r2, #4
	mov	r1, #67108864
	strh	r2, [r1, #0]	@ movhi
	ldr	r2, .L28+16
	str	r3, [r2, #0]
.L26:
	ldmfd	sp!, {r3, lr}
	bx	lr
.L29:
	.align	2
.L28:
	.word	.LC0
	.word	drawString4
	.word	oldButtons
	.word	buttons
	.word	state
	.size	lose, .-lose
	.align	2
	.global	animate
	.type	animate, %function
animate:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L38
	ldr	r1, .L38+4
	ldr	r2, [r3, #32]
	smull	r0, r1, r2, r1
	mov	r0, r2, asr #31
	rsb	r1, r0, r1, asr #3
	add	r1, r1, r1, asl #2
	mov	r0, #2
	subs	r2, r2, r1, asl #2
	str	r0, [r3, #36]
	bne	.L31
	ldr	r1, [r3, #48]
	cmp	r1, r0
	addne	r1, r1, #1
	str	r2, [r3, #32]
	streq	r2, [r3, #48]
	strne	r1, [r3, #48]
.L31:
	mov	r2, #67108864
	ldr	r2, [r2, #304]
	tst	r2, #16
	moveq	r2, #0
	streq	r2, [r3, #36]
	mov	r2, #67108864
	ldr	r2, [r2, #304]
	mvn	r2, r2
	ands	r2, r2, #32
	movne	r1, #1
	strne	r1, [r3, #36]
	bne	.L35
	ldr	r1, [r3, #36]
	cmp	r1, #2
	ldr	r0, .L38
	beq	.L37
.L35:
	ldr	r2, [r3, #32]
	add	r2, r2, #1
	str	r1, [r3, #40]
	str	r2, [r3, #32]
	bx	lr
.L37:
	ldr	r3, [r0, #40]
	str	r2, [r0, #48]
	str	r3, [r0, #36]
	bx	lr
.L39:
	.align	2
.L38:
	.word	reggie
	.word	1717986919
	.size	animate, .-animate
	.align	2
	.global	hideSprites
	.type	hideSprites, %function
hideSprites:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r2, .L43
	mov	r3, #0
.L41:
	mov	r1, #512	@ movhi
	strh	r1, [r2, r3]	@ movhi
	add	r3, r3, #8
	cmp	r3, #1024
	bne	.L41
	bx	lr
.L44:
	.align	2
.L43:
	.word	shadowOAM
	.size	hideSprites, .-hideSprites
	.align	2
	.global	updateOAM
	.type	updateOAM, %function
updateOAM:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L52
	str	r4, [sp, #-4]!
	ldr	r4, [r3, #4]
	mov	r4, r4, asl #23
	ldr	ip, [r3, #48]
	ldr	r2, .L52+4
	ldr	r1, [r3, #36]
	ldrb	r0, [r3, #0]	@ zero_extendqisi2
	mvn	r3, r4, lsr #6
	mvn	r3, r3, lsr #17
	strh	r3, [r2, #2]	@ movhi
	ldr	r3, .L52+8
	add	r1, r1, r1, asl #1
	add	r1, r1, ip, asl #6
	ldr	ip, [r3, #0]
	strh	r1, [r2, #4]	@ movhi
	mov	r1, #0
	orr	r0, r0, #16384
	cmp	r1, ip
	strh	r0, [r2, #0]	@ movhi
	ldr	r3, .L52+12
	bge	.L51
.L50:
	ldr	r4, [r3, #16]
	ldrb	r0, [r3, #-36]	@ zero_extendqisi2
	cmp	r4, #0
	orr	r0, r0, #32768
	strh	r0, [r2, #8]	@ movhi
	orrne	r0, r0, #512
	strneh	r0, [r2, #8]	@ movhi
	ldr	r4, [r3, #0]
	ldr	r0, [r3, #-32]
	cmp	r4, #0
	bic	r0, r0, #65024
	strh	r0, [r2, #10]	@ movhi
	add	r1, r1, #1
	moveq	r0, #8	@ movhi
	movne	r0, #9	@ movhi
	streqh	r0, [r2, #12]	@ movhi
	strneh	r0, [r2, #12]	@ movhi
	cmp	r1, ip
	add	r2, r2, #8
	add	r3, r3, #56
	blt	.L50
.L51:
	ldmfd	sp!, {r4}
	bx	lr
.L53:
	.align	2
.L52:
	.word	reggie
	.word	shadowOAM
	.word	.LANCHOR0
	.word	vase+36
	.size	updateOAM, .-updateOAM
	.align	2
	.global	setupSounds
	.type	setupSounds, %function
setupSounds:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mvn	r2, #1264
	mov	r3, #67108864
	sub	r2, r2, #1
	mov	r1, #128	@ movhi
	strh	r1, [r3, #132]	@ movhi
	strh	r2, [r3, #130]	@ movhi
	mov	r2, #0	@ movhi
	strh	r2, [r3, #128]	@ movhi
	bx	lr
	.size	setupSounds, .-setupSounds
	.align	2
	.global	playSoundA
	.type	playSoundA, %function
playSoundA:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	bx	lr
	.size	playSoundA, .-playSoundA
	.align	2
	.global	playSoundB
	.type	playSoundB, %function
playSoundB:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	bx	lr
	.size	playSoundB, .-playSoundB
	.align	2
	.global	pauseSound
	.type	pauseSound, %function
pauseSound:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r2, #67108864
	ldr	r1, .L58
	mov	r3, #0
	add	r2, r2, #256
	strh	r3, [r2, #2]	@ movhi
	str	r3, [r1, #12]
	strh	r3, [r2, #6]	@ movhi
	ldr	r2, .L58+4
	str	r3, [r2, #12]
	bx	lr
.L59:
	.align	2
.L58:
	.word	soundA
	.word	soundB
	.size	pauseSound, .-pauseSound
	.align	2
	.global	unpauseSound
	.type	unpauseSound, %function
unpauseSound:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r3, #67108864
	ldr	r0, .L61
	add	r3, r3, #256
	mov	r1, #128
	mov	r2, #1
	strh	r1, [r3, #2]	@ movhi
	str	r2, [r0, #12]
	strh	r1, [r3, #6]	@ movhi
	ldr	r3, .L61+4
	str	r2, [r3, #12]
	bx	lr
.L62:
	.align	2
.L61:
	.word	soundA
	.word	soundB
	.size	unpauseSound, .-unpauseSound
	.align	2
	.global	stopSound
	.type	stopSound, %function
stopSound:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L64
	ldr	r1, [r3, #0]
	mov	r3, #0
	add	r0, r1, #12
	str	r3, [r0, #8]
	mov	r2, #67108864
	ldr	r0, .L64+4
	add	r2, r2, #256
	add	r1, r1, #24
	strh	r3, [r2, #2]	@ movhi
	str	r3, [r0, #12]
	str	r3, [r1, #8]
	strh	r3, [r2, #6]	@ movhi
	ldr	r3, .L64+8
	mov	r2, #1
	str	r2, [r3, #12]
	bx	lr
.L65:
	.align	2
.L64:
	.word	dma
	.word	soundA
	.word	soundB
	.size	stopSound, .-stopSound
	.align	2
	.global	instruct
	.type	instruct, %function
instruct:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, lr}
	mov	r3, #67108864
	add	r3, r3, #256
	mov	r1, #128	@ movhi
	strh	r1, [r3, #2]	@ movhi
	ldr	r1, .L71
	mov	r2, #1
	str	r2, [r1, #12]
	mov	r1, #128	@ movhi
	strh	r1, [r3, #6]	@ movhi
	ldr	r3, .L71+4
	ldr	r0, .L71+8
	str	r2, [r3, #12]
	ldr	r5, .L71+12
	mov	lr, pc
	bx	r5
	ldr	r4, .L71+16
	ldr	r0, .L71+20
	mov	lr, pc
	bx	r4
	ldr	r3, .L71+24
	mov	lr, pc
	bx	r3
	ldr	r0, .L71+20
	mov	lr, pc
	bx	r4
	ldr	r3, .L71+28
	ldr	r3, [r3, #0]
	tst	r3, #4
	beq	.L67
	ldr	r2, .L71+32
	ldr	r2, [r2, #0]
	ands	r2, r2, #4
	beq	.L69
.L67:
	tst	r3, #8
	beq	.L66
	ldr	r3, .L71+32
	ldr	r3, [r3, #0]
	tst	r3, #8
	beq	.L70
.L66:
	ldmfd	sp!, {r3, r4, r5, lr}
	bx	lr
.L69:
	mov	r1, #1040
	add	r1, r1, #4
	mov	r0, #67108864
	strh	r1, [r0, #0]	@ movhi
	ldr	r1, .L71+36
	str	r2, [r1, #0]
	b	.L67
.L70:
	bl	stopSound
	mov	r2, #6912
	mov	r3, #67108864
	add	r2, r2, #4
	strh	r2, [r3, #8]	@ movhi
	mov	r1, #7424	@ movhi
	mov	r2, #4864	@ movhi
	strh	r2, [r3, #0]	@ movhi
	strh	r1, [r3, #10]	@ movhi
	ldr	r0, .L71+40
	mov	lr, pc
	bx	r5
	ldr	r4, .L71+44
	mov	r0, #3
	ldr	r1, .L71+48
	mov	r2, #100663296
	mov	r3, #64
	mov	lr, pc
	bx	r4
	mov	r2, #100663296
	mov	r0, #3
	ldr	r1, .L71+52
	add	r2, r2, #59392
	mov	r3, #1024
	mov	lr, pc
	bx	r4
	mov	r2, #100663296
	mov	r0, #3
	ldr	r1, .L71+56
	add	r2, r2, #16384
	mov	r3, #528
	mov	lr, pc
	bx	r4
	ldr	ip, .L71+60
	ldr	r0, .L71+64
	mov	r1, #1024
	mov	r2, #1
	mov	r3, #27
	mov	lr, pc
	bx	ip
	mov	r2, #100663296
	mov	r0, #3
	ldr	r1, .L71+68
	add	r2, r2, #65536
	mov	r3, #16384
	mov	lr, pc
	bx	r4
	mov	r2, #83886080
	add	r2, r2, #512
	mov	r3, #256
	mov	r0, #3
	ldr	r1, .L71+72
	mov	lr, pc
	bx	r4
	ldr	r3, .L71+36
	mov	r2, #2
	str	r2, [r3, #0]
	b	.L66
.L72:
	.align	2
.L71:
	.word	soundA
	.word	soundB
	.word	instructPal
	.word	loadPalette
	.word	drawBackgroundImage4
	.word	instructBitmap
	.word	flipPage
	.word	oldButtons
	.word	buttons
	.word	state
	.word	kitchen_floorPal
	.word	DMANow
	.word	kitchen_floorTiles
	.word	kitchen_floorMap
	.word	kitchenTiles
	.word	loadMap
	.word	kitchenMap
	.word	ReggieTiles
	.word	ReggiePal
	.size	instruct, .-instruct
	.align	2
	.global	setupInterrupts
	.type	setupInterrupts, %function
setupInterrupts:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r2, #67108864
	add	r3, r2, #512
	str	r4, [sp, #-4]!
	ldrh	r0, [r2, #4]
	ldrh	ip, [r3, #0]
	mov	r1, #50331648
	ldr	r4, .L74
	add	r1, r1, #28672
	orr	ip, ip, #1
	orr	r0, r0, #8
	str	r4, [r1, #4092]
	strh	ip, [r3, #0]	@ movhi
	strh	r0, [r2, #4]	@ movhi
	mov	r2, #1	@ movhi
	strh	r2, [r3, #8]	@ movhi
	ldmfd	sp!, {r4}
	bx	lr
.L75:
	.align	2
.L74:
	.word	interruptHandler
	.size	setupInterrupts, .-setupInterrupts
	.align	2
	.global	updateVasePos
	.type	updateVasePos, %function
updateVasePos:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L83
	stmfd	sp!, {r4, r5, r6, r7}
	ldr	r2, [r3, #0]
	cmp	r2, #0
	ble	.L76
	ldr	r1, .L83+4
	ldr	r3, .L83+8
	rsb	r2, r2, r2, asl #3
	ldr	r5, [r1, #4]
	ldr	r4, [r1, #8]
	add	ip, r3, r2, asl #3
	mov	r6, #1
	mov	r7, #0
.L81:
	ldr	r2, [r3, #-16]
	ldr	r1, [r3, #-12]
	rsb	r2, r5, r2
	rsb	r1, r4, r1
	cmp	r2, #0
	str	r2, [r3, #-24]
	str	r1, [r3, #-20]
	blt	.L78
	ldr	r0, [r3, #0]
	cmn	r1, r0
	bmi	.L78
	cmp	r2, #160
	bgt	.L78
	cmp	r1, #240
	strle	r7, [r3, #28]
	ble	.L80
.L78:
	str	r6, [r3, #28]
.L80:
	add	r3, r3, #56
	cmp	r3, ip
	bne	.L81
.L76:
	ldmfd	sp!, {r4, r5, r6, r7}
	bx	lr
.L84:
	.align	2
.L83:
	.word	.LANCHOR0
	.word	.LANCHOR1
	.word	vase+24
	.size	updateVasePos, .-updateVasePos
	.align	2
	.global	vaseCollision
	.type	vaseCollision, %function
vaseCollision:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L100
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl}
	ldr	r6, [r3, #0]
	cmp	r6, #0
	ble	.L85
	ldr	r3, .L100+4
	ldr	r5, [r3, #4]
	ldr	r7, [r3, #24]
	ldr	r8, [r3, #0]
	ldr	sl, [r3, #28]
	ldr	r3, .L100+8
	add	r7, r5, r7
	add	sl, r8, sl
	mov	r1, #0
	mov	r9, #1
.L94:
	ldr	r2, [r3, #-32]
	cmp	r7, r2
	ldrle	ip, [r3, #-12]
	ble	.L87
	ldr	ip, [r3, #-12]
	add	r0, r2, ip
	cmp	r5, r0
	bge	.L98
	ldr	r0, [r3, #-36]
	ldr	r4, [r3, #-8]
	add	r4, r0, r4
	cmp	r8, r4
	bge	.L92
	cmp	r0, sl
	blt	.L99
.L90:
	cmp	r8, r4
	bge	.L92
	cmp	sl, r0
	ble	.L93
	ldr	r0, [r3, #-36]
	ldr	r4, [r3, #-8]
	add	r4, r0, r4
	cmp	r8, r4
	str	r9, [r3, #0]
	blt	.L93
.L92:
	add	r1, r1, #1
	cmp	r6, r1
	add	r3, r3, #56
	bgt	.L94
.L85:
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl}
	bx	lr
.L99:
	str	r9, [r3, #0]
.L87:
	add	r0, r2, ip
	cmp	r5, r0
	bge	.L98
	ldr	r0, [r3, #-36]
	ldr	r4, [r3, #-8]
	cmp	r7, r2
	add	r4, r0, r4
	bgt	.L90
.L89:
	cmp	r8, r4
	bge	.L92
.L93:
	cmp	r5, r2
	bge	.L92
	add	r2, r2, ip
	cmp	r7, r2
	ble	.L92
	cmp	sl, r0
	add	r1, r1, #1
	strgt	r9, [r3, #0]
	cmp	r6, r1
	add	r3, r3, #56
	bgt	.L94
	b	.L85
.L98:
	ldr	r0, [r3, #-36]
	ldr	r4, [r3, #-8]
	add	r4, r0, r4
	b	.L89
.L101:
	.align	2
.L100:
	.word	.LANCHOR0
	.word	reggie
	.word	vase+36
	.size	vaseCollision, .-vaseCollision
	.align	2
	.global	game
	.type	game, %function
game:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, lr}
	ldr	r4, .L109
	bl	animate
	bl	updateOAM
	mov	r0, #3
	ldr	r1, .L109+4
	ldr	ip, .L109+8
	mov	r2, #117440512
	mov	r3, #512
	mov	lr, pc
	bx	ip
	ldrh	r3, [r4, #4]
	ldrh	r2, [r4, #8]
	mov	r5, #67108864
	strh	r2, [r5, #16]	@ movhi
	strh	r2, [r5, #20]	@ movhi
	strh	r3, [r5, #18]	@ movhi
	strh	r3, [r5, #22]	@ movhi
	bl	updateVasePos
	bl	vaseCollision
	ldr	r3, [r5, #304]
	tst	r3, #16
	bne	.L103
	ldr	r3, [r4, #8]
	add	r3, r3, #1
	cmp	r3, #200
	str	r3, [r4, #8]
	beq	.L108
.L103:
	mov	r3, #67108864
	ldr	r3, [r3, #304]
	tst	r3, #128
	bne	.L104
	ldr	r3, [r4, #4]
	cmp	r3, #159
	ldrle	r2, .L109
	addle	r3, r3, #1
	strle	r3, [r2, #4]
.L104:
	mov	r3, #67108864
	ldr	r3, [r3, #304]
	tst	r3, #32
	ldreq	r3, [r4, #8]
	subeq	r3, r3, #1
	streq	r3, [r4, #8]
	mov	r3, #67108864
	ldr	r3, [r3, #304]
	tst	r3, #64
	ldreq	r3, [r4, #4]
	subeq	r3, r3, #1
	streq	r3, [r4, #4]
	ldr	r3, .L109+12
	ldr	r3, [r3, #0]
	tst	r3, #8
	beq	.L102
	ldr	r3, .L109+16
	ldr	r3, [r3, #0]
	tst	r3, #8
	bne	.L102
	mov	r3, #1040
	add	r3, r3, #4
	mov	r2, #67108864
	strh	r3, [r2, #0]	@ movhi
	ldr	r3, .L109+20
	mov	r2, #5
	str	r2, [r3, #0]
.L102:
	ldmfd	sp!, {r3, r4, r5, lr}
	bx	lr
.L108:
	bl	stopSound
	mov	r3, #1040
	add	r3, r3, #4
	strh	r3, [r5, #0]	@ movhi
	ldr	r3, .L109+20
	mov	r2, #3
	str	r2, [r3, #0]
	b	.L103
.L110:
	.align	2
.L109:
	.word	.LANCHOR1
	.word	shadowOAM
	.word	DMANow
	.word	oldButtons
	.word	buttons
	.word	state
	.size	game, .-game
	.align	2
	.global	resetGame
	.type	resetGame, %function
resetGame:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	bl	initialize
	ldr	r3, .L112
	mov	r2, #0
	str	r2, [r3, #8]
	str	r2, [r3, #4]
	str	r2, [r3, #12]
	ldmfd	sp!, {r3, lr}
	bx	lr
.L113:
	.align	2
.L112:
	.word	.LANCHOR1
	.size	resetGame, .-resetGame
	.align	2
	.global	pause
	.type	pause, %function
pause:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	ldr	r0, .L119
	ldr	r5, .L119+4
	mov	lr, pc
	bx	r5
	ldr	r4, .L119+8
	ldr	r0, .L119+12
	mov	lr, pc
	bx	r4
	ldr	r6, .L119+16
	ldr	r3, .L119+20
	mov	lr, pc
	bx	r3
	ldr	r0, .L119+12
	mov	lr, pc
	bx	r4
	ldr	r3, [r6, #0]
	tst	r3, #4
	beq	.L115
	ldr	r2, .L119+24
	ldr	r2, [r2, #0]
	ands	r4, r2, #4
	beq	.L117
.L115:
	tst	r3, #8
	beq	.L114
	ldr	r3, .L119+24
	ldr	r3, [r3, #0]
	tst	r3, #8
	beq	.L118
.L114:
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
.L118:
	mov	r2, #6912
	mov	r3, #67108864
	add	r2, r2, #4
	strh	r2, [r3, #8]	@ movhi
	mov	r2, #4864	@ movhi
	strh	r2, [r3, #0]	@ movhi
	mov	r2, #7424	@ movhi
	strh	r2, [r3, #10]	@ movhi
	ldr	r0, .L119+28
	mov	lr, pc
	bx	r5
	ldr	r4, .L119+32
	mov	r0, #3
	ldr	r1, .L119+36
	mov	r2, #100663296
	mov	r3, #64
	mov	lr, pc
	bx	r4
	mov	r2, #100663296
	mov	r0, #3
	ldr	r1, .L119+40
	add	r2, r2, #59392
	mov	r3, #1024
	mov	lr, pc
	bx	r4
	mov	r2, #100663296
	mov	r0, #3
	ldr	r1, .L119+44
	add	r2, r2, #16384
	mov	r3, #528
	mov	lr, pc
	bx	r4
	ldr	ip, .L119+48
	ldr	r0, .L119+52
	mov	r1, #1024
	mov	r2, #1
	mov	r3, #27
	mov	lr, pc
	bx	ip
	mov	r2, #100663296
	mov	r0, #3
	ldr	r1, .L119+56
	add	r2, r2, #65536
	mov	r3, #16384
	mov	lr, pc
	bx	r4
	mov	r2, #83886080
	add	r2, r2, #512
	mov	r3, #256
	mov	r0, #3
	ldr	r1, .L119+60
	mov	lr, pc
	bx	r4
	ldr	r3, .L119+64
	mov	r2, #2
	str	r2, [r3, #0]
	b	.L114
.L117:
	mov	r3, #1040
	add	r3, r3, #4
	mov	r2, #67108864
	strh	r3, [r2, #0]	@ movhi
	bl	resetGame
	ldr	r2, .L119+64
	ldr	r3, [r6, #0]
	str	r4, [r2, #0]
	b	.L115
.L120:
	.align	2
.L119:
	.word	pausePal
	.word	loadPalette
	.word	drawBackgroundImage4
	.word	pauseBitmap
	.word	oldButtons
	.word	flipPage
	.word	buttons
	.word	kitchen_floorPal
	.word	DMANow
	.word	kitchen_floorTiles
	.word	kitchen_floorMap
	.word	kitchenTiles
	.word	loadMap
	.word	kitchenMap
	.word	ReggieTiles
	.word	ReggiePal
	.word	state
	.size	pause, .-pause
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	ldr	r2, .L133
	mov	r3, #0
.L122:
	mov	r1, #512	@ movhi
	strh	r1, [r2, r3]	@ movhi
	add	r3, r3, #8
	cmp	r3, #1024
	bne	.L122
	bl	initialize
	mvn	r3, #1264
	mov	r7, #67108864
	mov	r1, #0
	sub	r3, r3, #1
	mov	r2, #128	@ movhi
	strh	r2, [r7, #132]	@ movhi
	strh	r1, [r7, #128]	@ movhi
	strh	r3, [r7, #130]	@ movhi
	add	r3, r7, #512
	ldrh	r0, [r3, #0]
	mov	r2, #50331648
	ldr	ip, .L133+4
	add	r2, r2, #28672
	orr	r0, r0, #1
	str	ip, [r2, #4092]
	strh	r0, [r3, #0]	@ movhi
	ldrh	r0, [r7, #4]
	mov	r2, #1
	orr	r0, r0, #8
	strh	r0, [r7, #4]	@ movhi
	ldr	r6, .L133+8
	strh	r2, [r3, #8]	@ movhi
	ldr	r3, .L133+12
	ldr	r8, .L133+16
	ldr	r4, .L133+20
	str	r2, [r3, #16]
	str	r1, [r6, #0]
	ldr	r5, .L133+24
.L131:
	ldr	r1, [r4, #0]
	ldr	r2, [r7, #304]
	ldr	r3, [r6, #0]
	str	r1, [r8, #0]
	str	r2, [r4, #0]
	cmp	r3, #5
	ldrls	pc, [pc, r3, asl #2]
	b	.L123
.L130:
	.word	.L124
	.word	.L125
	.word	.L126
	.word	.L127
	.word	.L128
	.word	.L129
.L129:
	bl	pause
.L123:
	mov	lr, pc
	bx	r5
	b	.L131
.L128:
	bl	lose
	mov	lr, pc
	bx	r5
	b	.L131
.L127:
	bl	win
	mov	lr, pc
	bx	r5
	b	.L131
.L126:
	bl	game
	mov	lr, pc
	bx	r5
	b	.L131
.L125:
	bl	instruct
	mov	lr, pc
	bx	r5
	b	.L131
.L124:
	bl	splash
	mov	lr, pc
	bx	r5
	b	.L131
.L134:
	.align	2
.L133:
	.word	shadowOAM
	.word	interruptHandler
	.word	state
	.word	soundA
	.word	oldButtons
	.word	buttons
	.word	waitForVblank
	.size	main, .-main
	.global	score
	.global	hOff
	.global	vOff
	.global	seed
	.global	numVases
	.comm	oldButtons,4,4
	.comm	buttons,4,4
	.comm	sbb,4,4
	.comm	shadowOAM,1024,4
	.comm	reggie,56,4
	.comm	vase,112,4
	.comm	soundA,32,4
	.comm	soundB,32,4
	.comm	state,4,4
	.data
	.align	2
	.set	.LANCHOR0,. + 0
	.type	numVases, %object
	.size	numVases, 4
numVases:
	.word	1
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"LOSE\000"
	.bss
	.align	2
	.set	.LANCHOR1,. + 0
	.type	seed, %object
	.size	seed, 4
seed:
	.space	4
	.type	vOff, %object
	.size	vOff, 4
vOff:
	.space	4
	.type	hOff, %object
	.size	hOff, 4
hOff:
	.space	4
	.type	score, %object
	.size	score, 4
score:
	.space	4
	.ident	"GCC: (devkitARM release 31) 4.5.0"
