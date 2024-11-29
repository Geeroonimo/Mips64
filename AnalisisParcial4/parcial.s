.data
CONTROL: .word 0x10000
DATA: .word 0x10008
X: .byte 20
Y: .byte 5
color: .byte 0, 255, 0, 0
longitudes: .byte 25, 20, 32, 38, 31, 43, 23, 21, 37, 28, 31, 32
.code
ld $s6, CONTROL($0) ; $s6 = dir.CONTROL
ld $s7, DATA($0) ; $s7 = dir.DATA
daddi $t0, $0, color; almaceno el color verde en $t0
daddi $t1, $0, 12 ; $t1 = 12 ; cantidad de longitudes
dadd $t2, $0, $0 ; $t2 = 0 ; inicializo 
sw $t0, 0($s7) ; DATA = $t0 ; guardo color verde en DATA
lb $t4, X($0) ; $t4 = X
daddi $t0, $0, 5 ; $t0 = 5 ; 5 es para imprimir colores en pantalla
loop:  ld $t1, longitudes($t2) ; $t1 = primer elemento
       sb $t4, 5($s7) ; DATA+5 = $t4(X)
       lb $t5, Y($0) ; $t5 = Y
barra: sb $t5, 4($s7) ; DATA+4 = $t4(Y)
       sd $t0, 0($s6) ; CONTROL = 5 ; mando a control el 5
       daddi $t3, $t3, -1 ; 
       daddi $t5, $t5, 1 ; $t5 = 5 + 1; sumo una posicion a Y
       
       daddi $t4, $t4, 1 ; $t4= 20 + 1 ; sumo una posicion a X
       daddi $t2, $t2, 1 ; avanzo al siguiente numero
       daddi $t1, $t1, -1 ; Resto cantidad de elementos
       benz $t1, loop
       halt