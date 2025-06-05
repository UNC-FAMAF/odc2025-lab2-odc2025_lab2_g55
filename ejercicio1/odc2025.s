.global draw_odc2025
.extern rectangle_draw

draw_odc2025:
    str x30, [sp, #-8]!   // Pusheo x30 al stack

    // configuración
    mov x2, #5      // ancho
    mov x3, #5      // alto
    mov x4, #0xffff00  // color amarillo
    

    // LETRA O
    mov x0, #20
    mov x1, #20
    bl rectangle_draw       
    mov x0, #25
    bl rectangle_draw
    mov x0, #30
    bl rectangle_draw       

    mov x0, #20
    mov x1, #25
    bl rectangle_draw
    mov x0, #30
    bl rectangle_draw

    mov x0, #20
    mov x1, #30
    bl rectangle_draw
    mov x0, #30
    bl rectangle_draw

    mov x0, #20
    mov x1, #35
    bl rectangle_draw
    mov x0, #30
    bl rectangle_draw

    mov x0, #20
    mov x1, #40
    bl rectangle_draw       
    mov x0, #25
    bl rectangle_draw
    mov x0, #30
    bl rectangle_draw       

    // LETRA D
    mov x0, #40
    mov x1, #20
    bl rectangle_draw
    mov x0, #40
    mov x1, #25
    bl rectangle_draw
    mov x0, #40
    mov x1, #30
    bl rectangle_draw
    mov x0, #40
    mov x1, #35
    bl rectangle_draw
    mov x0, #40
    mov x1, #40
    bl rectangle_draw
    mov x0, #45
    mov x1, #20
    bl rectangle_draw
    mov x0, #50
    mov x1, #25
    bl rectangle_draw
    mov x0, #50
    mov x1, #30
    bl rectangle_draw
    mov x0, #50
    mov x1, #35
    bl rectangle_draw
    mov x0, #45
    mov x1, #40
    bl rectangle_draw

    // C
    mov x0, #60
    mov x1, #20
    bl rectangle_draw
    mov x0, #60
    mov x1, #25
    bl rectangle_draw
    mov x0, #60
    mov x1, #30
    bl rectangle_draw
    mov x0, #60
    mov x1, #35
    bl rectangle_draw
    mov x0, #60
    mov x1, #40
    bl rectangle_draw
    mov x0, #65
    mov x1, #20
    bl rectangle_draw
    mov x0, #65
    mov x1, #40
    bl rectangle_draw

    // Número 2
    mov x0, #80
    mov x1, #20
    bl rectangle_draw
    mov x0, #85
    bl rectangle_draw
    mov x0, #90
    bl rectangle_draw
    mov x0, #90
    mov x1, #25
    bl rectangle_draw
    mov x0, #85
    mov x1, #30
    bl rectangle_draw
    mov x0, #80
    mov x1, #35
    bl rectangle_draw
    mov x0, #80
    mov x1, #40
    bl rectangle_draw
    mov x0, #85
    bl rectangle_draw
    mov x0, #90
    bl rectangle_draw

    // Número 0
    mov x0, #100
    mov x1, #20
    bl rectangle_draw
    mov x0, #105
    bl rectangle_draw
    mov x0, #110
    bl rectangle_draw
    mov x0, #100
    mov x1, #25
    bl rectangle_draw
    mov x0, #110
    bl rectangle_draw
    mov x0, #100
    mov x1, #30
    bl rectangle_draw
    mov x0, #110
    bl rectangle_draw
    mov x0, #100
    mov x1, #35
    bl rectangle_draw
    mov x0, #110
    bl rectangle_draw
    mov x0, #100
    mov x1, #40
    bl rectangle_draw
    mov x0, #110
    bl rectangle_draw
    mov x0, #105
    bl rectangle_draw

    // Número 2
    mov x0, #120
    mov x1, #20
    bl rectangle_draw
    mov x0, #125
    bl rectangle_draw
    mov x0, #130
    bl rectangle_draw
    mov x0, #130
    mov x1, #25
    bl rectangle_draw
    mov x0, #125
    mov x1, #30
    bl rectangle_draw
    mov x0, #120
    mov x1, #35
    bl rectangle_draw
    mov x0, #120
    mov x1, #40
    bl rectangle_draw
    mov x0, #125
    bl rectangle_draw
    mov x0, #130
    bl rectangle_draw

    // Número 5
    mov x0, #140
    mov x1, #20
    bl rectangle_draw
    mov x0, #145
    bl rectangle_draw
    mov x0, #150
    bl rectangle_draw
    mov x0, #140
    mov x1, #25
    bl rectangle_draw
    mov x0, #140
    mov x1, #30
    bl rectangle_draw
    mov x0, #145
    bl rectangle_draw
    mov x0, #150
    bl rectangle_draw
    mov x0, #150
    mov x1, #35
    bl rectangle_draw
    mov x0, #140
    mov x1, #40
    bl rectangle_draw
    mov x0, #145
    bl rectangle_draw
    mov x0, #150
    bl rectangle_draw

    ldr x30, [sp], #8 // popea x30 del stack
    ret
