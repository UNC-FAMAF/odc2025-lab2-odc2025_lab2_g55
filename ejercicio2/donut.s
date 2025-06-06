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

.equ D_SIZE,        128
.equ D_AREA,        D_SIZE * D_SIZE

.equ D_XOFFSET,     SCREEN_WIDTH/2 - D_SIZE/2
.equ D_YOFFSET,     SCREEN_HEIGHT/2 - D_SIZE/2 + 110
.equ SCALE,         57

.equ PHI,           180
.equ THETA,         655     // 655 causa un poquito de overdraw pero quien soy yo para quejarme

.equ HALT_TIME,     0

.section .rodata
.balign 32
brown_gradient:
    .word 0x001B0B07
    .word 0x002C120A
    .word 0x003E1B0D
    .word 0x004F2611
    .word 0x005F2E13
    .word 0x00703818
    .word 0x0081411C
    .word 0x00935022
    .word 0x00A66128
    .word 0x00B76F30
    .word 0x00C67D39
    .word 0x00D48B42

.balign 32
pink_gradient:
    .word 0x004B1E3A
    .word 0x005A2A49
    .word 0x00693458
    .word 0x00783F67
    .word 0x00874A76
    .word 0x00965685
    .word 0x00A56294
    .word 0x00B36DA2
    .word 0x00C178B1
    .word 0x00CF84C0
    .word 0x00DD8FCE
    .word 0x00EB9BDD

.section .bss
.balign 16
z:  .skip D_AREA

.global v_framebuffer
.balign 16
v_framebuffer: .skip SCREEN_SIZE * 4

.section .text
.extern halt
.extern background
.global donut
donut:
    mov x18, x0
    mov x19, #1024      // sA = 1024
    mov x20, xzr        // cA = 0
    mov x21, x19        // sB = 1024
    mov x22, xzr        // cB = 0
    ldr x27, =z

inf_loop:
    str x18, [sp, #-16]!         // Pusheo x30 al stack

    ldr x0, =v_framebuffer
    bl background

    ldr x18, [sp], #16           // popea x30 del stack
    ldr x13, =v_framebuffer

    mov x12, #2048          // R2 = 2048

    mov x11, x12, lsr #1    // K2 = 1024
    mov x0, #5120
    mul x11, x11, x0        // K2 = 5120 * 1024

// memset(z, 127, D_AREA)
    mov x9, #(D_AREA/16)    // 16384/16 = 1024
    mov w10, #127           // lo mismo!!
    dup v0.16b, w10         // se setea v0 a 127 cada 8bits
    mov x0, x27             // x0 = &z-buffer
// Se setea el z-buffer a 127 (Todos los pixeles están en la profundidad máxima)
memset:
    // Se usa un registro de vectores para setear de 16 bytes a la vez
    st1 { v0.16b }, [x0], #16
    subs x9, x9, #1
    bne memset

    mov x23, xzr    // sj = 0
    mov x24, #1024  // cj = 1024
    
    mov x15, PHI
loop_phi:
    mov x25, xzr    // si = 0
    mov x26, #1024  // ci = 1024
    
    mov x14, THETA
loop_theta:
    add x0, x24, x12    // x0 = cj + R2

    mul x1, x26, x0     // x1 = ci*x0
    asr x1, x1, #10     // x1 = c1*x0 >> 10

    mul x2, x20, x23    // x2 = cA*sj
    asr x2, x2, #10     // x2 = cA*sj >> 10

    mul x3, x25, x0     // x3 = si*x0
    asr x3, x3, #10     // x3 = si*x0 >> 10

    mul x4, x19, x3             // x4 = sA*x3
    sub x4, x2, x4, asr #10     // x4 = x2 - (sA*x3 >> 10)

    mul x5, x19, x23    // x5 = sA*sj
    asr x5, x5, #10     // x5 = sA*sJ >> 10

    mul x6, x20, x3     // x6 = cA*x3
    mov x7, #1024       // x7 = 1024
    madd x6, x7, x5, x6 // x6 = 1024*x5 + cA*x3
    add x6, x6, x11     // x6 = K2 + 1024*x5 + cA*x3

    mul x7, x24, x25    // x7 = cj*si
    asr x7, x7, #10     // x7 = cj*si >> 10

    mov x9, SCALE           // x9 = SCALE (Se usa después)

    mul x8, x22, x1         // x8 = cB*x1
    msub x8, x21, x4, x8    // x8 = cB*x1 - sB*x4
    mul x8, x8, x9          // x8 = SCALE*(cB*x1 - sB*4) / x6
    sdiv x8, x8, x6         // x8 = (cB*x1 - sB*4) / x6
    add x0, x8, (D_SIZE/2)  // x = (D_SIZE/2) + SCALE*(cB*x1 - sB*4) / x6

    mul x8, x22, x4         // x8 = cB*x4
    madd x8, x21, x1, x8    // x8 = cB*x4 + sB*x1
    mul x8, x8, x9          // x8 = SCALE*(cB*x4 + sB*x1) / x6
    sdiv x8, x8, x6         // x8 = (cB*x4 + sB*x1) / x6
    add x1, x8, (D_SIZE/2)  // y = (D_SIZE/2) + SCALE*(cB*x4 + sB*x1) / x6

    mneg x8, x19, x7        // x8 = -sA*x7
    add x8, x2, x8, asr #10 // x8 = (-sA*x7 >> 10) + x2
    mul x2, x24, x21        // x2 = cj*sB
    asr x2, x2, #10         // x2 = cj*sB >> 10
    mul x2, x26, x2         // x2 = ci*(cj*sB >> 10)
    mneg x9, x20, x7        // x9 = -cA*x7
    msub x9, x22, x8, x9    // x9 = -cA*x7 - cB*((-sA*x7>>10) + x2)
    sub x9, x9, x2          // x9 = -cA*x7 - cB*((-sA*x7>>10) + x2) - ci*(cj*sB >> 10)
    asr x2, x9, #10         // N = -cA*x7 - cB*((-sA*x7>>10) + x2) - ci*(cj*sB >> 10) >> 10
    sub x2, x2, x5          // N = (-cA*x7 - cB*(-sA*x7>>10) + x2) - ci*(cj*sB >> 10) >> 10) - x5
    asr x2, x2, #7          // N = (-cA*x7 - cB*(-sA*x7>>10) + x2) - ci*(cj*sB >> 10) >> 10) - x5 >> 7

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

    // if(j <= (PHI/2))
    lsl x4, x2, #2          // x4 = N*4

    cmp x15, (PHI/2)
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

    str w3, [x13, x0, lsl #2]

fi:
    // R(10, 10, ci, si)
    mov x0, #10
    mov x1, #10
    mov x2, x26
    mov x3, x25
    bl R
    mov x26, x2
    mov x25, x3

    subs x14, x14, #1
    bne loop_theta

    // R(36, 10, cj, sj)
    mov x0, #36
    mov x1, #10
    mov x2, x24
    mov x3, x23
    bl R
    mov x24, x2
    mov x23, x3

    subs x15, x15, #1
    bne loop_phi

    // R(5, 7, cA, sA)
    mov x0, #5
    mov x1, #7
    mov x2, x20
    mov x3, x19
    bl R
    mov x20, x2
    mov x19, x3

    // R(5, 8, cB, sB)
    mov x0, #5
    mov x1, #8
    mov x2, x22
    mov x3, x21
    bl R
    mov x22, x2
    mov x21, x3

    mov x1, #(SCREEN_SIZE/8)
    mov x0, x18
// Se pasan los pixeles del buffer de dibujado al framebuffer
copy_buffers:
    // Uso los registros de vectores de 128bits para copiar de 4 pixeles a la vez
    // Se hace un unroll del loop para copiar 8 pixeles por ciclo
    ld1 { v0.4s }, [x13], #16
    st1 { v0.4s }, [x0], #16
    ld1 { v1.4s }, [x13], #16
    st1 { v1.4s }, [x0], #16
    subs x1, x1, #1
    bne copy_buffers

    //mov x0, HALT_TIME
    //bl halt

b inf_loop

// R(mul, shift, x, y)
// Macro que escala variables
// x0 = mul
// x1 = shift
// x2 = x
// x3 = y
// x4 = tmp
// x5, se usa para hacer cálculos
R:
    mov x4, x2      // tmp = x

    mul x5, x0, x3  // x5 = mul*y
    asr x5, x5, x1  // x5 = mul*y >> shift
    sub x2, x2, x5  // x -= mul*y >> shift

    mul x5, x0, x4  // x5 = mul*tmp
    asr x5, x5, x1  // x5 = mul*tmp >> shift
    add x3, x3, x5  // y += mul*tmp >> shift

    mov x4, #3145728        // tmp = 3145728
    msub x4, x2, x2, x4     // tmp = 3145728 - x*x
    msub x4, x3, x3, x4     // tmp = 3145728 - x*x - y*y
    asr x4, x4, #11         // tmp = 3145728 - x*x - y*y >> 11

    mul x2, x2, x4      // x = x*tmp
    asr x2, x2, #10     // x = x*tmp >> 10

    mul x3, x3, x4      // y = y*tmp
    asr x3, x3, #10     // y = y*tmp >> 10

    ret
