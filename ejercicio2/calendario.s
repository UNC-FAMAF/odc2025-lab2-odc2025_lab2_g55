.extern rectangle_draw
.extern draw_odc2025

.global calendario
calendario:
    str x30, [sp, #-16]!         // Pusheo x30 al stack

    // Cuadrado blanco del calendario
    mov x0, #220
    mov x1, #220
    mov x2, #80
    mov x3, #80
    movz x4, 0xFF, lsl #16
    movk x4, 0xFFFF
    bl rectangle_draw

    mov x3, #1
    mov x4, xzr
    bl rectangle_draw

    mov x2, #1
    mov x3, #80
    bl rectangle_draw

    mov x0, #300
    bl rectangle_draw

    mov x0, #220
    mov x1, #300
    mov x2, #81
    mov x3, #1
    bl rectangle_draw

    // Línea roja
    mov x0, #230
    mov x1, #245
    mov x2, #60
    mov x3, #2
    movz x4, 0xFB, lsl #16
    movk x4, 0x4934
    bl rectangle_draw

    bl draw_odc2025

// Dibujo de los días del calendario
    mov x1, #255
column:
    mov x0, #230
row:
    mov x2, #4
    mov x3, #4
    movz x4, 0xCD, lsl #16l
    movk x4, 0xCDCD
    bl rectangle_draw

    add x0, x0, #8
    cmp x0, #290
    b.lt row

    add x1, x1, #8
    cmp x1, #295
    b.lt column

    ldr x30, [sp], #16           // popea x30 del stack
    ret
