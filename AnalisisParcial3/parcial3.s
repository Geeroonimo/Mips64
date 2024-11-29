.data
CONTROL: .word 0x10000
DATA:    .word 0x10008

purpura: .byte 128, 0, 128, 0
datos:   .word 1, 50, 35, 16, 15, 15, -1, 8, 49, 49, 3, 33

.code
daddi $a0, $0, datos ; le paso la direccion de datos $a0 = datos
daddi $a1, $0, 6 ; cantidad de pares 
daddi $sp, $0, 0x400
jal GRAFICAR
halt

GRAFICAR: daddi $sp, $sp -8 ; resto 8bytes a sp
          ld $ra, 0($sp) ; $ra = dir.sp 0x400
          lwu $s0, CONTROL($0) ; $s0 = CONTROL
          lwu $s1, DATA($0); $s1 = DATA
          lb $s2, purpura($0) ; $s2 = purpura
          sb $s2, 0($s1) ; DATA = $s2 ; almaceno color en data
          loop: ld $a2, 0($a0) ; $a2 = primer numero
                jal EN_RANGO ; Verifico si esta entre 0 y 49
                beqz $v0, siguiente_par
                dadd $s3, $0, $v0 ; salvo en s3
                daddi $a0, $0, 8 ; avanzo al siguiente numero
                jal EN_RANGO ;Verifico si esta entre 0 y 49 (retorna 1 si lo esta 0 si no)
                beqz $v0, siguiente_elemento
                sd $s3, 5($s1); guardo en data+5 = x = $s3
                sd $a2, 4($s1); guardo en data+4 = y = $a2
                daddi $t0, $0, 5 ; 5 es para colores en pantalla
                sd $t0, 0($s0) ; CONTROL = 5
                fin: daddi $a1, $a1, -1 ; Resto cantidad de elementos
                     benz $a1, loop ; Si no se leyeron todos salto a loop
          pop $ra ; recupero direccion de retorno
          sd $ra, 0($sp) ; almaceno direccion en sp
          daddi $sp, $sp, 8 ; sumo 8 bytes a sp
          j $ra ; regreso al programa principal

siguiente_par: daddi $a0, $0, 16 ; avanzo al siguiente par de numeros
               j fin 

EN_RANGO: slti $t1 , $a2, 0 ; Si $a2 es menor que 0 sale un 1
          benz $t1, fuera_de_rango ; Si $t1 = 1 quiere decir que $a2 es menor que 0 por lo tanto esta fuera del rango
          slti $t1, $a2, 50 ; Devuelve 0 si $a1 supera 50
          beqz $t1, fuera_de_rango ; Si $t1 = 0 quiere decir que $a1 es mayor a 50 por lo tanto esta fuera de rango
          daddi $v0, $0, 1 ; Almaceno un 1 indicando que el numero esta dentro del rango
          j fin ; salto a fin
fuera_de_rango: daddi $v0, $0, 0 ; Almaceno un 0 indicando que el numero esta fuera del rango
                fin: jr $ra