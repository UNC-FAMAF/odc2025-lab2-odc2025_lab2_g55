.extern rectangle_draw
.extern circle_draw

.extern draw_nube

.global ventana
ventana:
    str x30, [sp, #-16]!         // Pusheo x30 al stack
    
    mov x0, #370
    mov x1, #140
    mov x2, #200
    mov x3, #200
    movz x4, 0x64, lsl #16
    movk x4, 0x95ED
    bl rectangle_draw

    bl draw_nube

    mov x0, #370
    mov x2, #10
    movz x4, 0x2E, lsl #16
    movk x4, 0x1503
    bl rectangle_draw
    
    mov x0, #465
    bl rectangle_draw

    mov x0, #560
    bl rectangle_draw

    mov x0, #370
    mov x2, #200
    mov x3, #10
    bl rectangle_draw

    mov x1, #235
    bl rectangle_draw

    mov x1, #330
    bl rectangle_draw

    ldr x30, [sp], #16           // popea x30 del stack
    ret
