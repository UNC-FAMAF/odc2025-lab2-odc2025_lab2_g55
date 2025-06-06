.global draw_sharingan
.extern circle_draw
.extern rectangle_draw

draw_sharingan:
    str x30, [sp, #-8]! // Pusheo x30 al stack

    // circle_draw y rectangle_draw no modifican los registros con los
    // que reciben argumentos, por lo que si se vuelven a utilizar los
    // mismos valores para llamadas continuas no es necesario volver
    // a poner los valores en los registros.
    // Ej: Se dibujan dos círculos de color negro (x4 = 0x000000 o x4 = xzr)
    // uno seguido del otro, por lo tanto solo se hace mov x5, xzr una vez

    // Dibujando el ojo
	mov x0, #320
    mov x1, #240
    mov x2, #119
    mov x3, xzr
    mov x4, 0xff0000
	bl circle_draw

    mov x2, #80
    mov x3, #5
    mov x4, 0x940000
	bl circle_draw

    mov x2, #40
    mov x3, xzr
    mov x4, 0x940000
	bl circle_draw

    mov x2, #118
    mov x3, #4
    mov x4, xzr
    bl circle_draw

    mov x2, #25
    mov x3, xzr
	bl circle_draw

	// Circulo primer tomoe (arriba a la derecha)
	mov x0, #350
    mov x1, #170
    mov x2, #20
	bl circle_draw

	// Circulo segundo tomoe (izquierda)
	mov x0, #240
    mov x1, #240
	bl circle_draw

	// Circulo tercer tomoe (abajo a la derecha)
	mov x0, #350
    mov x1, #310
	bl circle_draw

    // Rectangulos primer tomoe (arriba a la derecha
	mov x0, #342
    mov x1, #150
    mov x2, #20
    mov x3, #8
    mov x4, xzr
    bl rectangle_draw

	mov x0, #346
    mov x1, #145
    mov x2, #23
    bl rectangle_draw

	mov x0, #352
    mov x1, #141
    bl rectangle_draw

	mov x0, #361
    mov x1, #139
    mov x2, #10
    bl rectangle_draw

	// Rectangulos segundo tomoe (izquierda)
	mov x0, #220
    mov x1, #233
    mov x2, #6
    mov x3, #20
    bl rectangle_draw

	mov x0, #213
    mov x1, #240
    mov x2, #20
    mov x3, #12
    bl rectangle_draw

	mov x0, #210
    mov x1, #237
    mov x2, #4
    bl rectangle_draw

	mov x0, #208
    mov x1, #233
    bl rectangle_draw

	//tercer tomoe (abajo a la derecha)
	mov x0, #370
    mov x1, #303
    mov x2, #3
    mov x3, #24
    bl rectangle_draw	

	mov x0, #365
    mov x1, #315
    mov x2, #5
    mov x3, #20
    bl rectangle_draw

	mov x0, #360
    mov x1, #320
    mov x2, #5
    bl rectangle_draw							

    ldr x30, [sp], #8   // popea x30 del stack
    ret
