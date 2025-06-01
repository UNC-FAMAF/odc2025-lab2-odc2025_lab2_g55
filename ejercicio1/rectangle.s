// rectangle_draw(rect_x, rect_y, width, height, clr, fill)
// Esta subrutina dibuja un rectángulo en la pantalla
// Toma de argumentos X0,X1,X2,X3,X4,X5 los cuales
// Deben contener:
// X0: rect_x, coordenada x de la esquina superior izquierda
// X1: rect_y, coordenada y de la esquina superior izquierda
// X2: width, ancho del rectángulo
// X3: height, alto del rectángulo
// X4: clr, color del rectángulo
// X5: fill, si es <= 0 el rectángulo se dibuja relleno, si es > 0 se dibuja solo el borde y del grosor indicado

// Variables de rectangle_draw
// x6 = current_y (contador del bucle exterior)
// x7 = current_x (contador del bucle interior)
// x8 = y_end (límite para el bucle de y = rect_y + height)
// x9 = x_end (límite para el bucle de x = rect_x + width)
.global rectangle_draw
.extern put_pixel

rectangle_draw:
    str x30, [sp, #-8]!         // Pusheo x30 al stack

    // calculo los limites para los bordes
    add x8, x1, x3              // y_end = rect_y + height
    add x9, x0, x2              // x_end = rect_x + width

    cmp x5, #0
    b.gt draw_border            // Si fill > 0, dibuja solo el borde

draw_filled:
    mov x6, x1                  // current_y = rect_y (inicio del bucle exterior)

y_loop_filled:
    cmp x6, x8                  // (current_y <= y_end)
    b.ge filled_done            // sí current_y > y_end termina la parte de relleno

    mov x7, x0                  // current_x = rect_x (inicio del bucle interior)

x_loop_filled:
    cmp x7, x9                  // (current_x <= x_end)
    b.ge next_y_filled          // si current_x > x_end pasa a la siguiente fila

    // putPixel(current_x,current_y)
    mov x11, x7                 // current_x
    mov x12, x6                 // current_y
    bl put_pixel

    add x7, x7, #1              // current_x++
    b x_loop_filled

next_y_filled:
    add x6, x6, #1              // current_y++
    b y_loop_filled

filled_done:
    b end_rectangle_draw        // Salto al final de la subrutina

draw_border:
    mov x6, x1                  // current_y = rect_y (inicio del bucle exterior)

y_loop_border:
    cmp x6, x8                  // (current_y <= y_end)
    b.ge border_done            // sí current_y > y_end termina la parte de borde

    mov x7, x0                  // current_x = rect_x (inicio del bucle interior)

x_loop_border:
    cmp x7, x9                  // (current_x <= x_end)
    b.ge next_y_border          // sí current_x > x_end pasa a la siguiente fila

    // Comprobar si el píxel (current_x, current_y) está en el borde

    // x13 es un registro temporal para cálculos de condiciones de borde

    // Comprobación del borde superior
    add x13, x1, x5             // x13 = rect_y + fill
    cmp x6, x13                 // Compara current_y con (rect_y + fill)
    b.lt plot_border_pixel      // Si current_y < (rect_y + fill), es píxel de borde

    // Comprobación del borde inferior
    sub x13, x8, x5             // x13 = y_end - fill
    cmp x6, x13                 // Compara current_y con (y_end - fill)
    b.ge plot_border_pixel      // Si current_y >= (y_end - fill), es píxel de borde

    // Comprobación del borde izquierdo
    add x13, x0, x5             // x13 = rect_x + fill
    cmp x7, x13                 // Compara current_x con (rect_x + fill)
    b.lt plot_border_pixel      // Si current_x < (rect_x + fill), es píxel de borde

    // Comprobación del borde derecho
    sub x13, x9, x5             // x13 = x_end - fill
    cmp x7, x13                 // Compara current_x con (x_end - fill)
    b.ge plot_border_pixel      // Si current_x >= (x_end - fill), es píxel de borde

    // Si no se cumplió ninguna condición de borde, seguir pintando
    b next_x_border

plot_border_pixel:
    // putPixel(current_x,current_y)
    mov x11, x7                 // current_x
    mov x12, x6                 // current_y
    bl put_pixel

next_x_border:
    add x7, x7, #1              // current_x++
    b x_loop_border

next_y_border:
    add x6, x6, #1              // current_y++
    b y_loop_border

border_done:

end_rectangle_draw:
    ldr x30, [sp], #8           // popea x30 del stack
    ret
