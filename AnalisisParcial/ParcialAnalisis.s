.data ; Ejer 1 parcial (basicamente es un algoritmo que multiplica)
A: .word 3
B: .word 5
C: .word 0

.code
ld r1, A (r0)
ld r2, B (r0)

dadd r3, r0, r0 ; En esta linea no se producen atascos RAWs
lazo: dadd r3, r3, r2 ; En esta linea no se producen atascos RAWs
  daddi r1, r1, -1
  bnez r1, lazo ; En esta linea se producen atascos RAWs
sd r3, C (r0)
halt

;CON FORWARDING (Cajitas de BUFFERS entre operaciones)
  dadd r3, r0, -1    IF | ID | EX | MEM | WB            
  bnez r1, lazo           IF | RAW | ID | EX | MEM | WB ; Todo se ejectua en paralelo por eso es mas rapido

; Los Buffers sirven para que cuando tenga el resultado en el EX 
; lo guarde en la cajita y las siguientes instrucciones(ID MEM WB etc) lo puedan usar..

; Calcular los NUMEROS DE ATASCOS(Por dependencia de datos RAWs): 3 (En cada iteracion se produce un atasco RAWs por lo tanto son 3)

; Calcular los NUMEROS DE ATASCOS POR SALTO(Branch Taken Stalls BTS): 2 (Estos se producen cuando se esta analizando un salto y 
; ya arranco la siguiente instruccion que no se debia arrancar )

; Calcular los CICLOS POR INSTRUCCION(CPI): 23 (Basicamente para calcular esto lo mejor
; es graficar todas las instrucciones y asi sacas los ciclos q son 23.)

