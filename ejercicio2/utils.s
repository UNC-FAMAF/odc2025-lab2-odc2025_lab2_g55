// put_pixel(x, y)
// Recibe una coordenada x en x11 y una coordenada y en x12
// y pinta el pixel del framebuffer en la coordenada (x,y)
// del color guardado en w4 (los 32 bits más bajos de X4)
.global put_pixel
put_pixel:
    // Calculo la dirección en el fb de un pixel en función de las coordenas x (x11) e y (x12)
    lsl x13, x12, #9            // guarda y * 512 en x13
    add x13, x13, x12, lsl #7   // suma y * 128 a x13 => x13 = 640 * y
    add x13, x13, x11           // x13 = x + (640 * y)

    str w4, [x20, x13, lsl #2]  // Pinta el pixel en la dirección de memoria fb_address + 2*[x + (640 * y)]
    ret

// Halt(time)
// Para la ejecución del programa por la cantidad de "tiempo"
// pasada por x0.
// x0 = time
.global halt
halt:
    nop
    subs x0, x0, #1
    b.gt halt
    ret
