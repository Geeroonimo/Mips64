; Si se elimina el lazo y se hace de manera repetitiva linea por linea
.data 
A: .word 3
B: .word 5
C: .word 0

.code
ld r1, A (r0)
ld r2, B (r0)

dadd r3, r0, r0
dadd r3, r3, r2
dadd r3, r3, r2
dadd r3, r3, r2
sd r3, C (r0)
halt 

; ANALISIS ;Teniendo en cuenta el FORWARDING habilitado:
dadd r3, r0, r0    IF | ID | EX | MEM | WB
dadd r3, r3, r2         IF | ID | EX | MEM | WB                              
dadd r3, r3, r2              IF | ID | EX | MEM | WB
....

; Calcular BTS: 0 (Por que no se producen saltos)
; Calcular RAWs: 0 (Por que siempre que almacenado el dato en los buffers para que la 
; siguiente instruccion lo lea)

; Si es multilpicacion, suma, resta etc necesita el valor en EX
; Si es de salto necesita el valor en ID