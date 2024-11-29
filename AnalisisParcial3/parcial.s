; 1.Indicar cuantos atascos se producen de tipo RAW y BTS, BTB y DelaySlot esta desactivados (40pts)
.data
DATO: .word 3

.code
    ld $t1, DATO($0) ; $t1 = 3
    daddi $t0, $0, 0 ; $t0 = 0
    daddi $t2, $0, 3 ; $t2 = 3
loop: dadd $t0, $t0, $t1 ; $t0 = 3
      daddi $t2, $t2, -1 ; $t2 = 2
      bnez $t2, loop ; Salta si lo que tiene $t2 <> 0 a loop
      halt ; fin de programa


; Con forwanding habilitado:    RAW:  3   BTS:  2   CPI: 22/13
; CantInstrucciones: 4 + (3*3) = 13
; Ciclos sin atacos: CantInstrucciones + 4 = 17
; CiclosTotal = ciclos sin atascos + ciclos por atascos RAW + ciclos por atascos BTS y BMS = 17 + 3 + 2 = 22
; CPI: CiclosTotal/CantInstrucciones = 22/13


; Con forwanding deshabilitado: RAW: 7     BTS:  2   CPI: 26/13
; CiclosTotal = ciclos sin atascos + ciclos por atascos RAW + ciclos por atascos BTS y BMS = 17 + 7 + 2 = 26
; CPI: CiclosTotal/CantInstrucciones = 26/13