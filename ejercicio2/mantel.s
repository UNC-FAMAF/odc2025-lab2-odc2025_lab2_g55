.equ LINE_COLOR_HIGH,   0xCC
.equ LINE_COLOR_LOW,    0x241D

.extern rectangle_draw

.global mantel
mantel:
    str x30, [sp, #-16]! // Pusheamos x30 al stack

// Dibujo de líneas verticales
    mov x0, #36
    mov x2, #10
    mov x3, #10
    movz x4, LINE_COLOR_HIGH, lsl #16
    movk x4, LINE_COLOR_LOW
loop_x:
    mov x1, #380
loop_y:
    bl rectangle_draw

    sub x0, x0, #2
    add x1, x1, #5
    bl rectangle_draw
    cmp x1, #470
    b.lt loop_y
    
    add x0, x0, #90
    cmp x0, #640
    b.lt loop_x

// Dibujo de líneas horizontales
    mov x0, xzr
    mov x1, #400
    mov x2, #640
    mov x3, #10
    bl rectangle_draw

    add x1, x1, #35
    bl rectangle_draw

    add x1, x1, #35
    bl rectangle_draw

    ldr x30, [sp], #16 // popea x30 del stack
    ret
