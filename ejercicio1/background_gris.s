.global background_gris
// Los grises son apartir del negro hacia el blanco
// planteados en una gama media

background_gris:

    str x30, [sp, #-16]!         // Pusheo x30 al stack

    // GRIS_1
	mov x0, #0
    mov x1, #0
    mov x2, #0x2ff
    mov x3, #72
    movz x4, 0x3C3C
    movk x4, 0x003C, lsl 16
    mov x5, xzr
    bl rectangle_draw

// GRIS_2 
    mov x0, #15
    mov x1, #72
    mov x2, #0x2ff
    mov x3, #72
    movz x4, 0x4B4B
    movk x4, 0x004B, lsl 16
    mov x5, xzr
    bl rectangle_draw

// GRIS_3
    mov x0, #0
    mov x1, #144
    mov x2, #0x2ff
    mov x3, #72
    movz x4, 0x5A5A
    movk x4, 0x005A, lsl 16
    mov x5, xzr
    bl rectangle_draw

// GRIS_4 
	mov x0, #0
    mov x1, #288 
    mov x2, #0x2ff
    mov x3, #72
    movz x4, 0x7878
    movk x4, 0x0078, lsl 16
    mov x5, xzr
    bl rectangle_draw

// GRIS_5
	mov x0, #0
    mov x1, #216
    mov x2, #0x2ff
    mov x3, #72
      movz x4, 0x6969
    movk x4, 0x0069, lsl 16
    mov x5, xzr
    bl rectangle_draw

// GRIS_6	
	mov x0, #0
    mov x1, #360
    mov x2, #0x2ff
    mov x3, #72
    movz x4, 0x9191
    movk x4, 0x0091, lsl 16
    mov x5, xzr
    bl rectangle_draw

// GRIS_7 
	mov x0, #0
    mov x1, #432
    mov x2, #0x2ff
    mov x3, #72
    movz x4, 0xAFAF
    movk x4, 0x00AF, lsl 16
    mov x5, xzr
    bl rectangle_draw

    ldr x30, [sp], #16           // popea x30 del stack
    ret




















