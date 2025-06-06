.global background


background:

    str x30, [sp, #-16]!         // Pusheo x30 al stack

// GRIS_VIOLACEO_1
	mov x0, #0
    mov x1, #0
    mov x2, #0x2ff
    mov x3, #72
    movz x4, 0x3C46
    movk x4, 0x003C, lsl 16
    mov x5, xzr
    bl rectangle_draw

// GRIS_VIOLACEO_2 
    mov x0, #15
    mov x1, #72
    mov x2, #0x2ff
    mov x3, #72
    movz x4, 0x4B55
    movk x4, 0x004B, lsl 16
    mov x5, xzr
    bl rectangle_draw

// GRIS_VIOLACEO_3
    mov x0, #0
    mov x1, #144
    mov x2, #0x2ff
    mov x3, #72
    movz x4, 0x5A64
    movk x4, 0x005A, lsl 16
    mov x5, xzr
    bl rectangle_draw

// GRIS_VIOLACEO_4 
	mov x0, #0
    mov x1, #288 
    mov x2, #0x2ff
    mov x3, #72
    movz x4, 0x7882
    movk x4, 0x0078, lsl 16
    mov x5, xzr
    bl rectangle_draw

// GRIS_VIOLACEO_5
	mov x0, #0
    mov x1, #216
    mov x2, #0x2ff
    mov x3, #72
    movz x4, 0x6973
    movk x4, 0x0069, lsl 16
    mov x5, xzr
    bl rectangle_draw


// GRIS_VIOLACEO_6	
	mov x0, #0
    mov x1, #360
    mov x2, #0x2ff
    mov x3, #72
    movz x4, 0x8791
    movk x4, 0x0087, lsl 16
    mov x5, xzr
    bl rectangle_draw

// GRIS_VIOLACEO_7 
	mov x0, #0
    mov x1, #432
    mov x2, #0x2ff
    mov x3, #72
    movz x4, 0x96A0
    movk x4, 0x0096, lsl 16
    mov x5, xzr
    bl rectangle_draw

    ldr x30, [sp], #16           // popea x30 del stack
    ret




















