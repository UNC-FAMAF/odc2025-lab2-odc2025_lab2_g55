// background(&fb)
// Dibuja el fondo de """"la casa de los simpsons""""
// Recibe en x0 la dirección del framebuffer a dibujar
.equ WALL_HIGH,         0xF9
.equ WALL_LOW,          0x69E6
.equ CEIL_HIGH,         0xE2
.equ CEIL_LOW,          0x27C9
.equ TABL_HIGH,         0xEB
.equ TABL_LOW,          0xDBB2

.equ SCREEN_WIDTH,      640
.equ SCREEN_HEIGHT,     480
.equ SCREEN_SIZE,       SCREEN_WIDTH * SCREEN_HEIGHT

.global background
background:
    str x30, [sp, #-16]!         // Pusheo x30 al stack
    mov x10, x0
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
    str x0, [sp, #-16]!     // Pusheo x0 al stack

    // Aca tienen que dibujar todo
    bl draw_homero
    bl ventana
    bl calendario

    ldr x0, [sp], #16       // popea x0 del stack
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

    bl mantel

    mov x0, xzr
    mov x1, #80
    mov x2, SCREEN_WIDTH
    mov x3, #1
    mov x4, xzr
    bl rectangle_draw

    mov x1, #380
    bl rectangle_draw

    ldr x30, [sp], #16           // popea x30 del stack
    ret
