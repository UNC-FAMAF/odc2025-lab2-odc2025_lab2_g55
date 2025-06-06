.extern rectangle_draw
.global draw_odc2025
draw_odc2025:
    str x30, [sp, #-16]!   // Pusheo x30 al stack

    // configuración
    movz x4, 0x07, lsl #16
    movk x4, 0x6678
    
    // LETRA O
    mov x0, #227
    mov x1, #225
    mov x2, #8
    mov x3, #3
    bl rectangle_draw
    
    mov x2, #3
    mov x3, #16
    bl rectangle_draw
    
    mov x1, #238
    mov x2, #8
    mov x3, #3
    bl rectangle_draw

    mov x0, #232
    mov x1, #225
    mov x2, #3
    mov x3, #16
    bl rectangle_draw

    // LETRA D
    mov x0, #241
    mov x1, #227
    mov x2, #3
    mov x3, #14
    bl rectangle_draw

    mov x0, #236
    mov x1, #238
    mov x2, #8
    mov x3, #3
    bl rectangle_draw

    mov x1, #232
    bl rectangle_draw

    mov x2, #3
    mov x3, #8
    bl rectangle_draw

    // Letra C
    mov x0, #245
    mov x1, #225
    mov x2, #8
    mov x3, #3
    bl rectangle_draw
    
    mov x2, #3
    mov x3, #16
    bl rectangle_draw
    
    mov x1, #238
    mov x2, #8
    mov x3, #3
    bl rectangle_draw

    // Número 2
    mov x0, #254
    mov x1, #228
    mov x2, #3
    mov x3, #3
    bl rectangle_draw

    mov x0, #257
    mov x1, #225
    mov x2, #3
    mov x3, #3
    bl rectangle_draw

    mov x0, #260
    mov x1, #228
    mov x2, #3
    mov x3, #5
    bl rectangle_draw

    mov x0, #257
    mov x1, #233
    mov x2, #3
    mov x3, #3
    bl rectangle_draw

    mov x0, #254
    mov x1, #236
    mov x2, #3
    mov x3, #3
    bl rectangle_draw

    mov x1, #238
    mov x2, #9
    mov x3, #3
    bl rectangle_draw

    // Número 0
    mov x0, #267
    mov x1, #225
    mov x2, #3
    mov x3, #3
    bl rectangle_draw

    mov x1, #238
    bl rectangle_draw
    
    mov x0, #264
    mov x1, #228
    mov x2, #3
    mov x3, #10
    bl rectangle_draw

    mov x0, #270
    bl rectangle_draw

    // Número 2
    mov x0, #274
    mov x1, #228
    mov x2, #3
    mov x3, #3
    bl rectangle_draw

    mov x0, #277
    mov x1, #225
    mov x2, #3
    mov x3, #3
    bl rectangle_draw

    mov x0, #280
    mov x1, #228
    mov x2, #3
    mov x3, #5
    bl rectangle_draw

    mov x0, #277
    mov x1, #233
    mov x2, #3
    mov x3, #3
    bl rectangle_draw

    mov x0, #274
    mov x1, #236
    mov x2, #3
    mov x3, #3
    bl rectangle_draw

    mov x1, #238
    mov x2, #9
    mov x3, #3
    bl rectangle_draw

    // Número 5
    mov x0, #284
    mov x1, #225
    mov x2, #8
    mov x3, #3
    bl rectangle_draw
    
    mov x1, #238
    mov x2, #8
    mov x3, #3
    bl rectangle_draw

    mov x1, #232
    bl rectangle_draw

    mov x1, #225
    mov x2, #3
    mov x3, #8
    bl rectangle_draw

    mov x0, #289
    mov x1, #235
    mov x3, #3
    bl rectangle_draw


    ldr x30, [sp], #16           // popea x30 del stack
    ret
