// circle_draw(cx, cy, r, filled, clr)
// Esta subrutina dibuja un círculo a la pantalla
// Toma de argumentos X0, X1, X2, X3, X4 los cuales
// Deben contener:
// X0: cx, la coordenada en el eje x del centro del círculo
// X1: cy, la coordenada en el eje y del centro del círculo
// X2: r, el radio del círculo
// X3: fill, si es <= 0 el circulo se dibuja relleno, si el valor > 0 se dibuja solo el borde y del grosor indicado
// X4: clr, color con el que se dibuja el círculo

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

    mov x8, #0          // x = 0
    neg x9, x2          // y = -r
    mov x10, x9         // p = -r

    sub x6, x3, #1      // half_low = thickness - 1
    lsr x6, x6, #1      // half_low = (thickness - 1) div 2

    mov x7, x3, lsr #1  // half_high = thickness div 2

loop_circ:
    adds xzr, x8, x9      // Seteo flags para checkear la condición del loop (x < -y)
    b.ge done

    cmp x10, #0         // if (p > 0)
    b.le else           // si p <= 0 voy a else

    add x9, x9, #1      // y += 1

    // X11 es un registro temporal para calcular 2*(x+y)+1
    add x11, x8, x9             // X11 = x+y
    add x10, x10, x11, lsl #1   // p += 2*(x+y)
    add x10, x10, #1            // p += 2*(x+y) + 1
    b fi                // saltea el else

else:
    add x10, x10, x8, lsl #1    // p += 2*x
    add x10, x10, #1            // p += 2*x + 1

fi: // fin del condicional

    cmp x3, #0
    b.le fill           // Si fill < 0 se dibuja el círculo sólido

    neg x14, x6     // dx = -half_low
loop1:
    neg x15, x6     // dy = -half_low
loop2:
    add x5, x14, x0     // x5 = cx + dx
    add x19, x15, x1    // x19 = cy + dy

    // put_pixel(cx + x + dx, cy + y + dy)
    add x11, x5, x8
    add x12, x19, x9
    bl put_pixel

    // put_pixel(cx - x + dx, cy + y + dy)
    sub x11, x5, x8
    add x12, x19, x9
    bl put_pixel

    // put_pixel(cx + x + dx, cy - y + dy)
    add x11, x5, x8
    sub x12, x19, x9
    bl put_pixel

    // put_pixel(cx - x + dx, cy - y + dy)
    sub x11, x5, x8
    sub x12, x19, x9
    bl put_pixel

    // put_pixel(cx + y + dx, cy + x + dy)
    add x11, x5, x9
    add x12, x19, x8
    bl put_pixel

    // put_pixel(cx + y + dx, cy - x + dy)
    add x11, x5, x9
    sub x12, x19, x8
    bl put_pixel

    // put_pixel(cx - y + dx, cy + x + dy)
    sub x11, x5, x9
    add x12, x19, x8
    bl put_pixel

    // put_pixel(cx - y + dx, cy - x + dy)
    sub x11, x5, x9
    sub x12, x19, x8
    bl put_pixel

    add x15, x15, #1    // dy += 1
    cmp x15, x7
    b.le loop2

    add x14, x14, #1    // dx += 1
    cmp x14, x7
    b.le loop1
    b next_loop

fill:
    neg x15,x8 // dy = -x

    // loop 1
    //for (int dy = -x; dy <= x; dy++) {
    //      putPixel(cx + y, cy + dy);
    //      putPixel(cx - y, cy + dy);
    //      }

fill_loop1:

    //putPixel (cx + y, cy + dy)
    add x11, x0, x9     //  cx + y
    add x12, x1, x15    //  cy + dy
    bl put_pixel

    //putPixel (cx - y, cy + dy)
    sub x11, x0, x9     //  cx - y
    add x12, x1, x15    //  cy + dy
    bl put_pixel

    add x15, x15, #1    // dy++
    cmp x15,x8 // (dy <= x)
    b.le fill_loop1

    mov x15, x9         // dy = y
    neg x16, x9         // x16 será el límite superior

    // loop 2
    //for (int dy = y; dy <= -y; dy++) {
    //      putPixel(cx + x, cy + dy);
    //      putPixel(cx - x, cy + dy);
    //      }


fill_loop2:

    //putPixel (cx + x, cy + dy)
    add x11, x0, x8     //  x_coord = cx + x
    add x12, x1, x15    //  y_coord = cy + dy
    bl put_pixel

    //putPixel (cx - x, cy + dy)
    sub x11, x0, x8     //  x_coord = cx - x
    add x12, x1, x15    //  y_coord = cy + dy
    bl put_pixel

    add x15, x15, #1    // dy++
    cmp x15, x16        // Compara dy con el límite superior
    b.le fill_loop2     // Continúa si dy <= -y

next_loop:
    add x8, x8, #1  // x += 1
    b loop_circ

done:
    ldr x30, [sp], #8   // popea x30 del stack
    ret
