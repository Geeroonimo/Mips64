; FORWANDING HABILITADO

.data
tabla1: .word 15,11,24
tabla2: .word 0,0,0
.code
daddi r1, r0, 0 ; r1 = 0 ;inicializo registros
daddi r2, r0, 3 ; r2 = 3 (elementos)
loop: ld r3, tabla1 (r1) ; r3 = dir.tabla1(primer elemento)
      daddi r3, r3, 1 ; r3= r3 + 1 = 15 + 1 = 16
      sd r3, tabla2(r1) ; tabla2 = 16
      daddi r1, r1, 8 ; r1 = 8
      daddi r2, r2, -1 ; r2 = 2
      bnez r2, loop ; salto a loop si r2 es distinto de 0
halt
; Basicamente suma en uno a cada elemento de tabla1 y almaceno los resultados en tabla2

; Asumiendo forwarding activado 
; cantInstrucciones = 2 + (6*3) + 1 = 2 + 18 + 1 = 21 
; Ciclos sin atascos = #Instrucciones + 4 = 21 + 4 = 25
; Ciclos atascos RAW = 6 (depencia de r3 dentro del bucle ocasina dos atascos)
; Ciclos atascos BTS = 2 (del loop)
; Ciclos atascos BMS = 0
; Ciclos = ciclos sin atascos + ciclos por atascos RAW + ciclos por atascos BTS y BMS = 25 + 6 + 2 = 33
; El CPI será : 33 / 21 = 1,571 
