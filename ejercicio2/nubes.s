.extern circle_draw
.global draw_nube

.equ WALL_HIGH,         0xF9
.equ WALL_LOW,          0x69E6
.equ SPEED,             1

.equ CIRCULO_1,     300
.equ CIRCULO_2,     CIRCULO_1 - 20
.equ CIRCULO_3,     CIRCULO_1 + 20

.section .data
.balign 16
mover_nubec1_1: .word CIRCULO_1
mover_nubec1_2: .word CIRCULO_2
mover_nubec1_3: .word CIRCULO_3

.section .text

draw_nube:
    str x30, [sp, #-16]! // Pusheamos x30 al stack
    str x19, [sp, #-16]! // Pusheamos x19 al stack
    str x5, [sp, #-16]!  // Pusheamos x19 al stack
    str x6, [sp, #-16]!  // Pusheamos x19 al stack

    ldr x19, =mover_nubec1_1
    ldr w10, [x19]
    ldr x5, =mover_nubec1_2
    ldr w13, [x5]
    ldr x6, =mover_nubec1_3
    ldr w14, [x6]

    add w10, w10, SPEED
    add w13, w13, SPEED
    add w14, w14, SPEED

    cmp w10, #670
    cmp w13, #700
    cmp w14, #630
    b.lt store
    mov w10, CIRCULO_1
    mov w13, CIRCULO_2
    mov w14, CIRCULO_3

store:
    str w10, [x19]  
    str w13, [x5]
    str w14, [x6]
  
nube:
    mov x0, x10
    mov x1, #180
    mov x2, #20
    mov x3, #0
    mov x4, 0xffffff
    bl circle_draw

    mov x0, x13
    mov x1, #185
    mov x2, #15
    bl circle_draw

    mov x0, x14
    bl circle_draw

    add x10, x10, #10
    add x13, x13, #10
    add x14, x14, #10

    mov x0, x10
    mov x1, #270
    mov x2, #20
    bl circle_draw

    mov x0, x13
    mov x1, #275
    mov x2, #15
    bl circle_draw

    mov x0, x14
    bl circle_draw

ventanas:
    mov x0, #560
    mov x1, #140
    mov x3, #200
    mov x2, #100
    movz x4, WALL_HIGH, lsl #16
    movk x4, WALL_LOW
    bl rectangle_draw

    mov x0, #260
    mov x2, #110
    bl rectangle_draw

    mov x0, #0
    mov x2, #30
    bl rectangle_draw

    ldr x6, [sp], #16 // popea x30 del stack
    ldr x5, [sp], #16 // popea x30 del stack
    ldr x19, [sp], #16 // popea x30 del stack
    ldr x30, [sp], #16 // popea x30 del stack
    ret
