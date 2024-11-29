.data
A: .word 2,1,3
SUM: .word 0
.code
daddi r2,r0,0 ; r2 = 0
ld r1,SUM(r0) ; r1 = dir.SUM
daddi r3,r0,3 ; r3 = 3 (cantidad de elementos del arreglo)
loop: ld r4, A(r2) ; r4 = dir.A (Primer elemento)
dadd r1,r1,r4 ; r1 = (0 + 2) = 2 ; r1 = (2 + 1) = 3 ; r1 = (3 + 3) = 6
daddi r3, r3, -1 ; r3 = (3 - 1) = 2; r3 = (2 - 1) = 1 ; r3 = (1 - 1)= 0
bnez r3, loop ; r3 = 2 por lo tanto salta a loop ; r3 = 1 salta a loop ; r3 = 0
sd r1, SUM(r0) ; SUM = r1 (6)
halt

; Teniendo en cuenta BTB/DS/FORWANDING desactivados

; Cant Instrucciones: 5 + (4 * 3) = 5(fuera del loop) + 12(del loop) = 17 ins
; Ciclos = 35
; CPI = Ciclos/Inst = 35/17 = 2,059
; RAW = 12
; BTS = 2
; BMS = 0
; STR = 0

; Teniendo en cuenta BTB/DS desactivados pero FORWANDING activado

; Cant Instrucciones: 5 + (4 * 3) = 5(fuera del loop) + 12(del loop) = 17 ins
; Ciclos = 29
; CPI = Ciclos/Inst = 29/17 = 1,706
; RAW = 6
; BTS = 2
; BMS = 0
; STR = 3

; Teniendo en cuenta BTB/DS desactivados pero FORWANDING desactivado y cambio en sentencias

; Al reordenar las instrucciones se produce un atasco por dependencia de datos adicional por r2,
; entre la instrucción daddi r2, r0, r0 y ld r4, A(r2)

; Cant Instrucciones: 5 + (4 * 3) = 5(fuera del loop) + 12(del loop) = 17 ins
; Ciclos = 37
; CPI = Ciclos/Inst = 29/17 = 2,176
; RAW = 14
; BTS = 2
; BMS = 0
; STR = 0
