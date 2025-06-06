.extern rectangle_draw

.global calendario
calendario:
    str x30, [sp, #-16]!         // Pusheo x30 al stack

    mov x0, #220
    mov x1, #220
    mov x2, #80
    mov x3, #80
    movz x4, 0xFF, lsl #16
    movk x4, 0xFFFF
    bl rectangle_draw

    ldr x30, [sp], #16           // popea x30 del stack
    ret
