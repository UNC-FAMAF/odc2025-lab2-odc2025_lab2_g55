// donut(fb_adress)
// Dibuja una dona. Recibe como argumento el address del framebuffer en x0
// x13 = &v_framebuffer[0]
// x18 = &framebuffer[0]
// x19 = sA
// x20 = cA
// x21 = sB
// x22 = cB
// x23 = sj
// x24 = cj
// x25 = si
// x26 = ci
// x27 = &z[0]
.equ SCREEN_WIDTH,  640
.equ SCREEN_HEIGHT, 480
.equ SCREEN_SIZE,   SCREEN_WIDTH * SCREEN_HEIGHT

.equ D_SIZE,        100
.equ H_SIZE,        D_SIZE/2
.equ D_AREA,        D_SIZE * D_SIZE

.equ D_XOFFSET,     SCREEN_WIDTH/2 - H_SIZE
.equ D_YOFFSET,     SCREEN_HEIGHT/2 - H_SIZE + 100
.equ SCALE,         57

.equ PHI,           180
.equ H_PHI,         PHI/2
.equ THETA,         655     // 655 causa un poquito de overdraw pero quien soy yo para quejarme

.equ HALT_TIME,     0

.section .rodata
.align 2
brown_gradient:
    .word 0xFF1B0B07
    .word 0xFF2C120A
    .word 0xFF3E1B0D
    .word 0xFF4F2611
    .word 0xFF5F2E13
    .word 0xFF703818
    .word 0xFF81411C
    .word 0xFF935022
    .word 0xFFA66128
    .word 0xFFB76F30
    .word 0xFFC67D39
    .word 0xFFD48B42

.align 2
pink_gradient:
    .word 0xFF4B1E3A
    .word 0xFF5A2A49
    .word 0xFF693458
    .word 0xFF783F67
    .word 0xFF874A76
    .word 0xFF965685
    .word 0xFFA56294
    .word 0xFFB36DA2
    .word 0xFFC178B1
    .word 0xFFCF84C0
    .word 0xFFDD8FCE
    .word 0xFFEB9BDD

.section .bss
.align 0
z:  .skip D_AREA

.align 2
v_framebuffer: .skip SCREEN_SIZE * 4

.section .text
.extern halt
.global donut
donut:
    mov x18, x0
    mov x19, #1024      // sA = 1024
    mov x20, xzr        // cA = 0
    mov x21, x19        // sB = 1024
    mov x22, xzr        // cB = 0
    ldr x27, =z

inf_loop:

// ESTE CÓDIGO HAY QUE REEMPLAZARLO CUANDO HAGAMOS LA RUTINA QUE DIBUJE EL FONDO
    ldr x9, =v_framebuffer
	movz x10, 0x64, lsl 16
	movk x10, 0x95ED, lsl 00
	mov x2, SCREEN_HEIGHT   // Y Size
loop:
	mov x1, SCREEN_WIDTH    // X Size
loop0:
	stur w10,[x9]   // Colorear el pixel N
	add x9,x9,4	    // Siguiente pixel
	sub x1,x1,1	    // Decrementar contador X
	cbnz x1,loop0   // Si no terminó la fila, salto
	sub x2,x2,1	    // Decrementar contador Y
	cbnz x2,loop    // Si no es la última fila, salto
// ESTE CÓDIGO HAY QUE REEMPLAZARLO CUANDO HAGAMOS LA RUTINA QUE DIBUJE EL FONDO

    ldr x13, =v_framebuffer

    mov x12, #2048          // R2 = 2048

    mov x11, x12, lsr #1    // K2 = 1024
    mov x0, #5120
    mul x11, x11, x0        // K2 = 5120 * 1024

// memset(z, 127, D_AREA)
    mov x9, D_AREA  // x9 se usa como variable temporal en memset
    mov w10, #127   // lo mismo!!
memset:
    subs x9, x9, #1
    strb w10, [x27, x9]
    bne memset

    mov x23, xzr    // sj = 0
    mov x24, #1024  // cj = 1024
    
    mov x15, PHI
loop_phi:
    mov x25, xzr    // si = 0
    mov x26, #1024  // ci = 1024
    
    mov x14, THETA
loop_theta:
    mov x3, D_SIZE          // o = D_SIZE
    madd x3, x3, x1, x0     // o = x + y*D_SIZE


    // if(y < D_SIZE && y >= 0 && x >= 0 && x < D_SIZE)
    cmp x1, D_SIZE
    b.ge fi
    cmp x1, xzr
    b.lt fi
    cmp x0, xzr
    b.lt fi
    cmp x0, D_SIZE
    b.ge fi

    sub x4, x6, x11     // zz = x6-K2
    asr x4, x4, #15     // zz = (x6-K2)>>15

    // if(zz < z[o])
    ldrsb w5, [x27, x3] // w5 = z[o]
    cmp w4, w5
    b.ge fi
    strb w4, [x27, x3]  // z[o] = zz

    // N > 0 ? N : 0
    cmp x2, xzr
    b.gt Npositive
    mov x2, xzr
Npositive:
    // if(N >= 12) N = 11
    cmp x2, #12
    b.lt Nlt12
    mov x2, #11
Nlt12:

    // if(j <= H_PHI)
    lsl x4, x2, #2          // x4 = N*4

    cmp x15, H_PHI
    b.le else
    ldr x3, =brown_gradient
    ldr w3, [x3, x4]        // w3 = brown_gradient[N]
    b fi_color
else:
    ldr x3, =pink_gradient
    ldr w3, [x3, x4]        // w3 = pink_gradient[N]
fi_color:

    add x0, x0, D_XOFFSET   // x = x + D_XOFFSET
    add x1, x1, D_YOFFSET   // y = y + D_YOFFSET

    // if (fb_x >= 0 && fb_x < SCREEN_WIDTH && fb_y >= 0 && fb_y < SCREEN_HEIGHT)
    cmp x0, xzr
    b.lt fi
    cmp x0, SCREEN_WIDTH
    b.ge fi
    cmp x1, xzr
    b.lt fi
    cmp x1, SCREEN_HEIGHT
    b.ge fi

    mov x4, SCREEN_WIDTH
    madd x0, x1, x4, x0     // x0 = y * SCREEN_WIDTH + X
    lsl x0, x0, #2          // x0 = (y * SCREEN_WIDTH + x) * 4

    str w3, [x13, x0]

fi:
    subs x14, x14, #1
    bne loop_theta

    subs x15, x15, #1
    bne loop_phi

    mov x1, xzr
    mov x2, SCREEN_WIDTH
    mov x3, SCREEN_HEIGHT
    mul x2, x2, x3
    lsl x2, x2, #2
copy_buffers:
    ldr w3, [x13, x1]
    str w3, [x18, x1]
    
    add x1, x1, #4
    cmp x1, x2
    bne copy_buffers

    mov x0, HALT_TIME
    lsl x0, x0, #8
    bl halt

b inf_loop
