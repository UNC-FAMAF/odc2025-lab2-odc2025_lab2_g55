// background(&fb)
// Dibuja el fondo de """"la casa de los simpsons""""
// Recibe en x0 la dirección del framebuffer a dibujar
.equ WALL_HIGH,         0xF9
.equ WALL_LOW,          0x69E6
.equ CEIL_HIGH,         0xE2
.equ CEIL_LOW,          0x27C9
.equ TABL_HIGH,         0x6C
.equ TABL_LOW,          0x3B2A

.equ SCREEN_WIDTH,      640
.equ SCREEN_HEIGHT,     480
.equ SCREEN_SIZE,       SCREEN_WIDTH * SCREEN_HEIGHT

.extern rectangle_draw

.global background
background:
    movz x1, CEIL_HIGH, lsl #16
    movk x1, CEIL_LOW
    dup v0.4s, w1
    dup v1.4s, w1
    mov x1, #6400
loop_techo:
    st1 { v0.4s }, [x0], #16
    st1 { v1.4s }, [x0], #16
    subs x1, x1, #1
    bne loop_techo

    movz x1, WALL_HIGH, lsl #16
    movk x1, WALL_LOW
    dup v0.4s, w1
    dup v1.4s, w1
    mov x1, ((SCREEN_SIZE/8)-14400)
loop_pared:
    st1 { v0.4s }, [x0], #16
    st1 { v1.4s }, [x0], #16
    subs x1, x1, #1
    bne loop_pared

    // Aca tienen que dibujar todo

    movz x1, TABL_HIGH, lsl #16
    movk x1, TABL_LOW
    dup v0.4s, w1
    dup v1.4s, w1
    mov x1, #8000
loop_mesa:
    st1 { v0.4s }, [x0], #16
    st1 { v1.4s }, [x0], #16
    subs x1, x1, #1
    bne loop_mesa

    // Acá tienen que dibujar cosas que estén arriba de la mesa

    ret
