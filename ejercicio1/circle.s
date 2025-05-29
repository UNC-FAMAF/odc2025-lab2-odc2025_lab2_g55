// circle_draw(cx, cy, r, filled, clr)
// Esta subrutina dibuja un círculo a la pantalla
// Toma de argumentos X0, X1, X2, X3, X4 los cuales
// Deben contener:
// X0: cx, la coordenada en el eje x del centro del círculo
// X1: cy, la coordenada en el eje y del centro del círculo
// X2: r, el radio del círculo
// X3: filled, si es 1 el circulo se rellena y si es 0 se dibuja solo el borde
// X4: clr, color con el que se dibuja el círculo
// X5: thickness, Grosor con el que se va a dibujar la línea. Si X5 <= 0 no se dibuja nada

// Variables de circle_draw
// X6 = half_low
// X7 = half_high
// X8 = x
// X9 = y
// X10 = p
.global circle_draw
.extern put_pixel
circle_draw:
    str x30, [sp, #-8]! // Pusheo x30 al stack
    cmp x5, #0
    b.le done           // No se dibuja nada si thickness <= 0

    mov x8, #0          // x = 0
    neg x9, x2          // y = -r
    mov x10, x9         // p = -r

loop_circ:
    adds xzr, x8, x9      // Seteo flags para checkear la condición del loop (x < -y)
    b.ge done

    cmp x10, #0         // if (p > 0)
    b.le else           // si p <= 0 voy a else

    add x9, x9, #1      // y += 1

    // X11 es un registro temporal para calcular 2*(x+y)+1
    add x11, x8, x9     // X11 = x+y
    lsl x11, x11, #1    // X11 = 2*(x+y)
    add x11, x11, #1    // X11 = 2*(x+y)+1
    add x10, x10, x11   // p += 2*(x+y)+1
    b fi                // saltea el else

else:
    add x10, x10, x8, lsl #1    // p += 2*x
    add x10, x10, #1            // p += 2*x + 1

fi: // fin del condicional

    sub x6, x5, #1      // half_low = thickness - 1
    lsr x6, x6, #1      // half_low = (thickness - 1) div 2

    mov x7, x5, lsr #1  // half_high = thickness div 2

    neg x14, x6     // dx = -half_low
loop1:
    neg x15, x6     // dy = -half_low
loop2:
    // put_pixel(cx + x + dx, cy + y + dy)
    add x11, x0, x8     
    add x11, x11, x14
    add x12, x1, x9
    add x12, x12, x15
    bl put_pixel

    // put_pixel(cx - x + dx, cy + y + dy)
    sub x11, x0, x8
    add x11, x11, x14
    add x12, x1, x9
    add x12, x12, x15
    bl put_pixel

    // put_pixel(cx + x + dx, cy - y + dy)
    add x11, x0, x8
    add x11, x11, x14
    sub x12, x1, x9
    add x12, x12, x15
    bl put_pixel

    // put_pixel(cx - x + dx, cy - y + dy)
    sub x11, x0, x8
    add x11, x11, x14
    sub x12, x1, x9
    add x12, x12, x15
    bl put_pixel

    // put_pixel(cx + y + dx, cy + x + dy)
    add x11, x0, x9
    add x11, x11, x14
    add x12, x1, x8
    add x12, x12, x15
    bl put_pixel

    // put_pixel(cx + y + dx, cy - x + dy)
    add x11, x0, x9
    add x11, x11, x14
    sub x12, x1, x8
    add x12, x12, x15
    bl put_pixel

    // put_pixel(cx - y + dx, cy + x + dy)
    sub x11, x0, x9
    add x11, x11, x14
    add x12, x1, x8
    add x12, x12, x15
    bl put_pixel

    // put_pixel(cx - y + dx, cy - x + dy)
    sub x11, x0, x9
    add x11, x11, x14
    sub x12, x1, x8
    add x12, x12, x15
    bl put_pixel

    add x15, x15, #1    // dy += 1
    cmp x15, x7
    b.le loop2

    add x14, x14, #1    // dx += 1
    cmp x14, x7
    b.le loop1

    add x8, x8, #1  // x += 1
    b loop_circ

done:
    ldr x30, [sp], #8   // popea x30 del stack
    ret
