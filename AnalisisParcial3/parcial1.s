.data
TABLA1: .word 1, 2, 6, 3, 4, 5, 10, 11
CANT:   .word 8
LIMITE: .word 3
RES:    .word 0
TABLA2: .word 0

.code
    ld $t0, CANT($zero) ; $t0 = 8
    ld $t1, LIMITE($zero) ; $t1 = 3 LIMITE
    dadd $t2, $zero, $zero ; $t2 = 0 ; inicializo ; es para guardar en RES la cantidad de elementos mayores a 3
    dadd $t3, $zero, $zero ; $t3 = 0 ; inicializo
    dadd $t4, $zero, $zero ; $t4 = 0 ; inicializo
LOOP:ld $t5, TABLA1($t3) ;t5 = TABLA1(primer elemento)
     slt $t6, $t1, $t5 ; Primera vuelta : ($t1 < $t5) = $t6 = 0
     beqz $t6, FUERA ; t6 = 0 salta a FUERA
     daddi $t2, $t2, 1 ; $t2 = 1 ; Se encontro un elemento
     sd $t5, TABLA2($t4) ; TABLA2 = $t5 (elemento mayor a 3)
     daddi $t4, $t4, 8 ; $t4 = 8 ; sumo 8 bytes para avanzar al suguiente espacio de TABLA2
FUERA: daddi $t3, $t3, 8 ; $t3 = 8 ; sumo 8 bytes para avanzar al suguiente elemento de TABLA1
       daddi $t0, $t0, -1 ; Resto cantidad de elementos $t0 = 7
       bnez $t0, LOOP ; Si $t0 <> 0 salta a LOOP
       sd $t2, RES($zero) ; Almaceno $t2= elementos mayores a 3 en RES
       halt