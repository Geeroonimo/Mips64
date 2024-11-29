.data
tabla: .word 20, 1, 14, 7, 12, 11
num: .word 7
long: .word 6
res: .word 0
.code
ld r1, long(r0)
ld r2, num(r0)
dadd r3, r0, r0
dadd r10, r0, r0
loop: ld r4, tabla(r3)
      beq r4, r2, listo
      daddi r1, r1, -1
      bnez r1, loop ; alternado para quitar los bts usando DS activado
      daddi r3, r3, 8 ; alternado para quitar los bts usando DS activado
j fin
nop ; usada para darle tiempo a la etapa
listo: daddi r10, r0, 1
fin: sd r10, res(r0)
halt

; Calcular manualmente el número de ciclos, CPI, RAWs y BTS/BMS, asumiendo forwarding activado y
; BTB desactivado

; Cant Instrucciones: 4 + 3(saltos) * 5(intrucciones del loop) + 2(antes de saltar a listo) + 3 = 24
; RAW = 8 (ocurren en el loop por dependia de r4 para saltar a listo) ; Al ser un salto estos atascos ocurren en la etapada ID 2 veces (tanto en EX y MEM)
; BTS = 4 (Son 3 del loop y el ultimo una vez encontrado el 7 salta a listo(otro mas))
; BMS = 0
; STR = 0

; La cantidad de ciclos en los que se ejecuta el programa será:
; Ciclos sin atascos = #Instrucciones + 4 = 24 + 4 = 28
; Ciclos atascos RAW = 8
; Ciclos atascos BTS = 4 
; Ciclos = ciclos sin atascos + ciclos por atascos RAW + ciclos por atascos BTS = 28 + 8 + 4 = 40
; El CPI será : 40 / 24 = 1,666.

; Asumiendo forwarding activado y BTB activado

; Ciclos sin atascos = #Instrucciones + 4 = 24 + 4 = 28
; Ciclos atascos RAW = 8
; Ciclos atascos BTS = 2
; Ciclos atascos BMS = 2
; Ciclos = ciclos sin atascos + ciclos por atascos RAW + ciclos por atascos BTS y BMS = 28 + 8 + 4 = 40
; El CPI será : 40 / 24 = 1,666.

