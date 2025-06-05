.global draw_odc2025
.extern rectangle_draw

draw_odc2025:
    str x30, [sp, #-8]!   // Guardar dirección de retorno

    // El texto se ubicará en la esquina superior izquierda (x=20, y=20)
    // Cada letra y número se dibuja con rectángulos pequeños (tipo píxel)
    // Dimensiones estándar de los bloques: 5x5 píxeles

    mov x2, #5      // ancho
    mov x3, #5      // alto
    mov x4, #0x000000  // color negro
    mov x5, xzr     // sin transparencia

    // === Letra O ===
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

    mov x0, #25
    bl rectangle_draw

    mov x0, #30
    bl rectangle_draw

    // === Letra D ===
    mov x0, #40
    mov x1, #20
    bl rectangle_draw

    mov x0, #40
    mov x1, #25
    bl rectangle_draw

    mov x0, #40
    mov x1, #30
    bl rectangle_draw

    mov x0, #45
    mov x1, #20
    bl rectangle_draw

    mov x1, #30
    bl rectangle_draw

    mov x0, #50
    mov x1, #25
    bl rectangle_draw

    // === Letra C ===
    mov x0, #60
    mov x1, #20
    bl rectangle_draw

    mov x0, #60
    mov x1, #25
    bl rectangle_draw

    mov x0, #60
    mov x1, #30
    bl rectangle_draw

    mov x0, #65
    mov x1, #20
    bl rectangle_draw

    mov x1, #30
    bl rectangle_draw

    // === Espacio === (entre letras y números)

    // === Número 2 ===
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
    mov x0, #80
    mov x1, #30
    bl rectangle_draw
    mov x0, #85
    bl rectangle_draw
    mov x0, #90
    bl rectangle_draw

    // === Número 0 ===
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
    mov x0, #105
    bl rectangle_draw
    mov x0, #110
    bl rectangle_draw

    // === Número 2 === (otra vez)
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
    mov x0, #120
    mov x1, #30
    bl rectangle_draw
    mov x0, #125
    bl rectangle_draw
    mov x0, #130
    bl rectangle_draw

    // === Número 5 ===
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
    mov x0, #150
    bl rectangle_draw
    mov x0, #140
    mov x1, #30
    bl rectangle_draw
    mov x0, #145
    bl rectangle_draw
    mov x0, #150
    bl rectangle_draw

    // Restaurar y volver
    ldr x30, [sp], #8
    ret
