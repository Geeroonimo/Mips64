; Reordenar instrucciones del ejercicio 1

; Forwanding y DS activados

.data
tabla1: .word 15,11,24
tabla2: .word 0,0,0
.code
daddi r1, r0, 0 ; r1 = 0 ;inicializo registros
daddi r2, r0, 3 ; r2 = 3 (elementos)
loop: ld r3, tabla1 (r1) ; r3 = dir.tabla1(primer elemento)
      daddi r3, r3, 1 ; r3= r3 + 1 = 15 + 1 = 16
      sd r3, tabla2(r1) ; tabla2 = 16
      daddi r2, r2, -1 ; r2 = 2
      bnez r2, loop ; salto a loop si r2 es distinto de 0
      daddi r1, r1, 8 ; r1 = 8
halt