; Asumiendo  BTB activado ; Forwanding habilitado
; cantInstrucciones = 2 + (6*3) + 1 = 2 + 18 + 1 = 21 
; Ciclos sin atascos = #Instrucciones + 4 = 21 + 4 = 25
; Ciclos atascos RAW = 6
; Ciclos atascos BTS = 2
; Ciclos atascos BMS = 2
; Ciclos = ciclos sin atascos + ciclos por atascos RAW + ciclos por atascos BTS y BMS = 25 + 6 + 2 + 2 = 35
; El CPI será 35 / 21 = 1,666.

; El CPI con respecto al ejercicio 1 es mayor por mas predicciones del BRENCH