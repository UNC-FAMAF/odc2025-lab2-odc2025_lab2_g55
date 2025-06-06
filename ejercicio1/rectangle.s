// rectangle_draw(rect_x, rect_y, width, height, clr)
// Esta subrutina dibuja un rectángulo en la pantalla
// Toma de argumentos X0,X1,X2,X3,X4 los cuales
// Deben contener:
// X0: rect_x, coordenada x de la esquina superior izquierda
// X1: rect_y, coordenada y de la esquina superior izquierda
// X2: width, ancho del rectángulo
// X3: height, alto del rectángulo
// X4: clr, color del rectángulo

// Variables de rectangle_draw
// x6 = current_y (contador del bucle exterior)
// x7 = current_x (contador del bucle interior)
// x8 = y_end (límite para el bucle de y = rect_y + height)
// x9 = x_end (límite para el bucle de x = rect_x + width)

.equ SCREEN_WIDTH,      640
.equ SCREEN_HEIGHT,     480

.global rectangle_draw
.extern put_pixel
rectangle_draw:
    str x30, [sp, #-16]!         // Pusheo x30 al stack

    // if (rect_x >= SCREEN_WIDTH) goto done:
    cmp x0, SCREEN_WIDTH
    b.ge done
    // if (rect_y >= SCREEN_HEIGHT) goto done:
    cmp x1, SCREEN_HEIGHT
    b.ge done

    // calculo los limites para los bordes
    add x9, x0, x2      // x_end = rect_x + width
    add x8, x1, x3      // y_end = rect_y + height
    
    mov x7, x0          // current_x = rect_x
    mov x6, x1          // current_y = rect_y

    // if (x_end >= SCREEN_WIDTH) x_end = SCREEN_WIDTH
    cmp x9, SCREEN_WIDTH
    b.le check_y
    mov x9, SCREEN_WIDTH
// if (y_end >= SCREEN_HEIGHT) x_end = SCREEN_HEIGHT
check_y:
    cmp x8, SCREEN_HEIGHT
    b.le loop_y
    mov x8, SCREEN_HEIGHT

loop_y:
    // if (current_y < y_end)
    cmp x6, x8
    b.ge done
    mov x7, x0
loop_x:
    // while (current_x < x_end)
    cmp x7, x9
    b.ge else_x

    mov x11, x7
    mov x12, x6
    bl put_pixel
    add x7, x7, #1
    b loop_x
else_x:
    add x6, x6, #1
    b loop_y

done:
    ldr x30, [sp], #16           // popea x30 del stack
    ret
