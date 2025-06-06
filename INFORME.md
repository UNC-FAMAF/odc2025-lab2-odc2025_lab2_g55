Nombre y apellido 
Integrante 1:   Juan Martín Hernández
Integrante 2:   Mariano Andrés López Heredia
Integrante 3:   Ángel Valentino Indorato
Integrante 4:   Lautaro Yance


Descripción ejercicio 1: 
Un sharingan con 3 tomoe dibujado en un fondo de una escala de grises


Descripción ejercicio 2:
Render 3D de una dona marrón y rosada sobre una mesa con Homero Simpson
mirando de fondo y algunos elementos que decoran el fondo.

Justificación instrucciones ARMv8:

msub:
MSUB Xd, Xn, Xm, Xa. Multiplica Xn y Xm, lo resta a Xa y lo guarda en Xd.
                        Xd = Xa - Xn * Xm

msub o "Multiply-Substract" se utiliza a lo largo de donut.s
para realizar secuencias de operaciones complejas de forma más
eficiente y compacta, ya que se buscó minimizar lo más posible
(sin volvernos locos si) la cantidad de instrucciones ejecutadas
por ciclo dentro del código.

madd:
MADD Xd, Xn, Xm, Xa. Multiplica Xn y Xm, lo suma a Xa y lo guarda en Xd.
                        Xd = Xa + Xn * Xm

madd o "Multiply-Add" se usa por las mismas razones que msub.

mneg:
MNEG Wd, Wn, Wm. Multiplica Xn y Xm, niega el resultado y lo guarda en Xd.
                        Xd = -(Xn * Xm)

mneg o "Multiply-Negate" se por las mismas razones que msub.

stp:
STP Dt1, Dt2, addr. Guarda dos doubleword de forma consecutiva en memoria "addressed" por addr.

stp o "Store Pair" se usa en homero.s para pushear 2 registros, x30 (Return Adress) y x19
(que se usa como callee-saved en donut.s) al stack.

ldp:
LDP Dt1, Dt2, addr. Carga dos doubleword ordenadas de forma consecutiva en memoria
indexadas por addr a Dt1 y Dt2.

ldp o "Load Pair" se usa en homero.s para poppear los registros x30 y x19 pusheados con stp.

Instrucciones SIMD
Donut.s usa una técnica de double-buffering, muy utilizada en render de videojugos.
Lo que se hace en el double-buffering es dibujar el siguiente frame en un buffer
distinto al framebuffer actual e intercambiar los buffers, llamemolos v-buffer (virtual
buffer) y framebuffer (la imágen mostrada en pantalla), cuando el siguiente frame se
termina de dibujar.
En nuestro caso no podemos intercambiar el address al que apunta el framebuffer
una vez que se termina de dibujar dentro del v-buffer (**) por lo que para
simular un intercambio de buffers lo que hacemos es crear un arreglo de 32bits
del mismo tamaño del framebuffer (640*480 words), dibujar en el v-buffer
y al finalizar el dibujado copiar los contenidos del v-buffer al framebuffer,
por lo que en pantalla nunca se muestra un dibujo parcial.
Sin embargo hacer esta operación es muy costosa, pues se tienen que mover
307200 palabras por cada frame de animación (Y la animación ya de por si
es costosa gracias al render de la dona 3D). Por lo que usando los
registros de vectores NEON de 128 bits podemos copiar 4 palabras a la
vez y reducir la cantidad de copias de 307200 a 76800 lo cual reduce
tremendamente la cantidad de instrucciones ejecutadas por frame de animación.

La idea de utilizar SIMD provino de este video que habla sobre optimizaciones
que se pueden hacer utilizando registros SIMD de 512bits en versiones nuevas de x86-64.
"4x Code Performance with SIMD": https://youtu.be/Imj4ROIiMw0


(**) Aunque estuvimos investigando y se puede extender el framebuffer de cierta
forma para que sea el doble de alto e ir intercalando la mitad que se muestra
en cada frame pero no estabamos tán limitados con el rendimiento como para tener que hacerlo.

dup:
DUP Vd.<T>, Wn. Replica los bits bajos de Wn a todas las líneas de Vd,
<T> puede ser8B, 16B, 4H, 8H, 2S or 4S.

dup o "Duplicate 32/64-bit general register (Vector)" se utilizó para pintar de forma
más eficiente el fondo de la escena del ejercicio2, pues se cargaban los colores y
se copiaban de 128bits a la vez al v-buffer.

ld1:
LD1 {Vt.<T>}, vaddr. Carga elementos a un registro V.

ld1 se utilizó para cargar de a 128 bits a la vez (4 pixeles) los elementos del v-buffer
a un registro.

st1:
ST1 {Vt.<T>}, vaddr. Guarda multiples elementos de un registro V a memoria.

st1 se utilizó para guardar la información cargada del v-buffer a los registros V
en el framebuffer.


