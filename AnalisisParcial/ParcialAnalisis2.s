; La manera de solucionar atascos son tres:
; 1' Con FORWARDING (Obtener el dato mas rapido sin llegar a la etapa de WB)
; 2' Con sentencias NOP (Caso en el que no se puedan alternar sentencias) (Para dar tiempo tambien)
; 3' Alternar el orden de las sentencias (Para darle tiempo a la etapa de ejecucion y asi obtener el dato y ID pueda saltar)

.data ; Ejer 1 parcial (basicamente es un algoritmo que multiplica)
A: .word 3
B: .word 5
C: .word 0

.code
ld r1, A (r0)
ld r2, B (r0)

dadd r3, r0, r0 ; En esta linea no se producen atascos RAWs
lazo: daddi r1, r1, -1 ; alternado para reducir a 0 los RAWs
  dadd r3, r3, r2 ; alternado para reducir a 0 los RAWs
  bnez r1, lazo
sd r3, C (r0)
halt

;CON FORWARDING (Cajitas de BUFFERS entre operaciones)
; dadd r3, r0, -1    IF | ID | EX | MEM | WB            
; bnez r1, lazo           IF | ID | EX | MEM | WB  
                               IF | ID | EX | MEM | WB ; Todo se ejectua en paralelo
; En caso de no poder alternarse se utilizan NOP
