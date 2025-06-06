.global draw_homero
.extern circle_draw
.extern rectangle_draw

.equ LIMITE, 250 //total que dura la animacion (entre que cierra los ojo y hace el segundo semicerrado)
.equ ABIERTO, 200 
.equ SEMICERRADO, 210
.equ CERRADO, 240 

//necesito guardar el valor de mi contador en cada frame
.section .data
.balign 4 //mejora el rendimiento??
contador: .word 0


.section .text
draw_homero:
    stp x30, x19, [sp, #-16]!

    ldr x19, =contador //puntero
    ldr w10, [x19]

    add w10, w10, #1
    
    cmp w10, LIMITE // contador
    b.lt store
    mov w10, #0

store:
  str w10, [x19]

//CARA
    //cara (sombra)
	mov x0, #95
  	mov x1, #240
    mov x2, #50
    mov x3, #0
    mov x4, 0x8e00
	movk x4, 0x00ff, lsl #16
    bl circle_draw

    mov x0, #42
  	mov x1, #310
    mov x2, #20
    mov x3, #70
    bl rectangle_draw

    mov x0, #45
  	mov x1, #230
    mov x2, #15
    mov x3, #90
    bl rectangle_draw

    // cara
	mov x0, #60
    mov x2, #100
    mov x4, 0xffff00
    bl rectangle_draw

    mov x0, #150
    mov x1, #250
    mov x2, #15
    mov x3, #15
    bl rectangle_draw

    mov x0, #55
  	mov x1, #310
    mov x2, #70
    mov x3, #70
    bl rectangle_draw

    mov x0, #155
    mov x1, #247
    mov x2, #8
    mov x3, #0
    bl circle_draw

    //pelo arriba
    mov x0, #110
  	mov x1, #205
    mov x2, #30
    mov x3, #1
    mov x4, 0x000000
    bl circle_draw

    mov x0, #100
  	mov x1, #205
    mov x2, #30
    mov x3, #1
    mov x4, 0x000000
    bl circle_draw

	mov x0, #110
  	mov x1, #240
    mov x2, #50
    mov x3, #0
    mov x4, 0xffff00
    bl circle_draw

//PELO
    //pelo oreja bases

    mov x0, #50
    mov x1, #287
    mov x2, #6
    mov x3, #2
    mov x4, 0x000000
    bl rectangle_draw

    mov x0, #40
    mov x1, #265
    mov x2, #2
    mov x3, #30
    bl rectangle_draw

    mov x0, #65
    bl rectangle_draw
    
    //pelo oreja diagonal (derecha)

    mov x0, #63
    mov x1, #270
    mov x3, #5
    bl rectangle_draw

    mov x0, #61
    mov x1, #275
    mov x3, #6
    bl rectangle_draw

    mov x0, #59
    mov x1, #282
    mov x3, #3
    bl rectangle_draw

    mov x0, #56
    mov x1, #285
    mov x3, #2
    bl rectangle_draw

    //pelo oreja diagonal (izquierda)

    mov x0, #42
    mov x1, #270
    mov x3, #5
    bl rectangle_draw

    mov x0, #44
    mov x1, #275
    mov x3, #6
    bl rectangle_draw

    mov x0, #46
    mov x1, #282
    mov x3, #3
    bl rectangle_draw

    mov x0, #49
    mov x1, #285
    mov x3, #2
    bl rectangle_draw

//OREJA
    //oreja sombra
    mov x0, #52
  	mov x1, #310
    mov x2, #12
    mov x3, #0
    mov x4, 0x8e00
	  movk x4, 0x00ff, lsl #16
    bl circle_draw

    //oreja
    mov x0, #55
    mov x2, #10
    mov x3, #0
    mov x4, 0xffff00
    bl circle_draw

    cmp w10, ABIERTO //contador ojos abiertos
    b.lt ojos_abiertos

    cmp w10, SEMICERRADO //contador  semicerrado   
    b.lt ojos_semicerrados

    cmp w10, CERRADO // cerrado
    b.lt ojos_cerrados

    b ojos_semicerrados

ojos_abiertos:
    //sombra ojos
    //ojo izquierdo
	mov x0, #100
  	mov x1, #280
    mov x2, #20
    mov x3, #0
	mov x4, 0x9494
	movk x4, 0x0094, lsl #16
    bl circle_draw
    //ojo derecho
    mov x0, #145
    bl circle_draw
    
    //relleno ojos
    //ojo izquierdo
	mov x0, #102
    mov x2, #18
	mov x4, 0xffffff
    bl circle_draw
    //ojo derecho
    mov x0, #147
    bl circle_draw

    //pupilas
    //ojo izquierdo
	mov x0, #110
    mov x1, #288
    mov x2, #3
    mov x4, 0x000000
    bl circle_draw
    //ojo derecho
    mov x0, #158
    bl circle_draw

    //contorno ojos
    //ojo izquierdo
	mov x0, #100
    mov x1, #280
    mov x2, #21
    mov x3, #2
    bl circle_draw
    //ojo derecho
	mov x0, #145
    bl circle_draw

    b ojos_dibujados

ojos_semicerrados:

    //sombra ojos
    //ojo izquierdo
	mov x0, #100
  	mov x1, #280
    mov x2, #20
    mov x3, #0
	mov x4, 0x9494
	movk x4, 0x0094, lsl #16
    bl circle_draw
    //ojo derecho
    mov x0, #145
    bl circle_draw
    
    //relleno ojos
    //ojo izquierdo
	mov x0, #102
    mov x2, #18
	mov x4, 0xffffff
    bl circle_draw
    //ojo derecho
    mov x0, #147
    bl circle_draw

    //pupilas
    //ojo izquierdo
	mov x0, #107
    mov x1, #290	
    mov x2, #3
    mov x4, 0x000000
    bl circle_draw
    //ojo derecho
    mov x0, #155
    bl circle_draw

    //contorno ojos
    //ojo izquierdo
	mov x0, #100
    mov x1, #280
    mov x2, #21
    mov x3, #2
    bl circle_draw
    //ojo derecho
	mov x0, #145
    bl circle_draw

    //semicerrados

    //ojo izquierdo
    mov x0, #100
  	mov x1, #265
    mov x2, #20
    mov x3, #0
    mov x4, 0xffff00
    bl circle_draw

    mov x0, #79
    mov x2, #45
    mov x3, #20
    bl rectangle_draw
    //ojo derecho
    mov x0, #145
    mov x2, #20
    mov x3, #0
    bl circle_draw

    mov x0, #124
    mov x2, #45
    mov x3, #20
    bl rectangle_draw

    //sombras
    //ojo izquierdo
    mov x0, #79
    mov x1, #285
    mov x2, #44
    mov x3, #4
    mov x4, 0x8e00
	movk x4, 0x00ff, lsl #16
    bl rectangle_draw
    //ojo derecho
    mov x0, #124
    bl rectangle_draw

    b ojos_dibujados

ojos_cerrados:

    //sombra
    //ojo izquierdo
	mov x0, #100
    mov x1, #280
    mov x2, #21
    mov x3, #4
    mov x4, 0x8e00
	movk x4, 0x00ff, lsl #16
    bl circle_draw
    //ojo derecho
	mov x0, #145
    bl circle_draw

    //ojos
    //ojo izquierdo
    mov x0, #100
  	mov x1, #275
    mov x2, #23
    mov x4, 0xffff00
    mov x3, #0
    bl circle_draw
    //ojo derecho
    mov x0, #145
    bl circle_draw

ojos_dibujados:
//NARIZ
    //nariz sombra
    mov x0, #155
    mov x1, #300
    mov x2, #7
    mov x3, #0
    mov x4, 0x8e00
	movk x4, 0x00ff, lsl #16
    bl circle_draw

    mov x0, #125
  	mov x1, #307
    mov x2, #35
    mov x3, #7
    bl rectangle_draw

    //nariz
    mov x0, #125
  	mov x1, #292
    mov x2, #35
    mov x3, #13
    mov x4, 0xffff00
    bl rectangle_draw

    mov x0, #155
    mov x1, #300
    mov x2, #6
    mov x3, #0
    bl circle_draw

//BOCA
    //boca sombra
    mov x0, #105
    mov x1, #340
    mov x2, #30
    mov x3, #0
    mov x4, 0x915c
    movk x4, 0x00b9, lsl #16
    bl circle_draw

    //boca
    mov x0, #110
    mov x1, #340
    mov x2, #30
    mov x3, #0
    mov x4, 0xb378
    movk x4, 0x00e0, lsl #16
    bl circle_draw

    mov x0, #115
  	mov x1, #310
    mov x2, #45
    mov x3, #30
    bl rectangle_draw

    mov x0, #140
  	mov x1, #330
    mov x2, #28
    mov x3, #15
    bl rectangle_draw

    mov x0, #149
    mov x1, #323
    mov x2, #14
    mov x3, #0
    bl circle_draw

    mov x0, #158
    mov x1, #330
    mov x2, #8
    mov x3, #0
    bl circle_draw

    //baba
    mov x0, #110
  	mov x1, #340
    mov x2, #3
    mov x3, #20
    mov x4, 0xa5d5
    movk x4, 0x002d, lsl #16
    bl rectangle_draw

    mov x0, #102
    mov x2, #8
    mov x3, #3
    bl rectangle_draw

    mov x2, #3
    mov x3, #10
    bl rectangle_draw

    mov x0, #130
    mov x1, #345
    mov x2, #10
    mov x3, #3
    bl rectangle_draw

    mov x0, #140
    mov x2, #3
    mov x3, #25
    bl rectangle_draw

    ldp x30, x19, [sp], #16
    ret
