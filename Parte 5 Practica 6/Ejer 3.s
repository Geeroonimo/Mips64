.data
cant: .word 8
datos: .word 1, 2, 3, 4, 5, 6, 7, 8
res: .word 0
.code
(01) dadd r1, r0, r0
(02) ld r2, cant(r0)
(03)loop: ld r3, datos(r1)
(04) daddi r2, r2, -1
(05) dsll r3, r3, 1 
(06) sd r3, res(r1) 
(07) daddi r1, r1, 8
(08) bnez r2, loop
(09) halt

● Se ejecutan una vez (01) y (02)
● Se repite 8 veces el bucle de 6 instrucciones (03) a (08). 48 en total
● Se ejecuta 1 vez la instrucción halt (09).
; Cant instrucciones = 2 + 6*8 + 1 = 2 + 48(del loop)+ 1 = 51 

Atascos por dependencia de datos:
● Como no hay forwarding hay un atasco de un ciclo por la disponibilidad de r1 entre (01) y (03) al
inicio del programa.
● Si bien hay una dependencia de datos entre (02) y (04), no se genera atasco por el atasco que se
genera en el punto anterior.
● En cada vuelta del bucle ocurrirán 3 atascos, como se ejecuta 8 veces serán 24 RAWs en total
○ Un atasco RAW entre (03) y (05)
○ Dos atascos RAW entre (05) y (06)

; RAWs =  1 + 3*8 = 1 + 24 = 25

● Como el ciclo se repite 8 veces, ocurrirán 7 atascos BTS
; BTS = 7 

La cantidad de ciclos en los que se ejecuta el programa será:
Ciclos sin atascos = #Instrucciones + 4 = 55
Ciclos atascos RAWs = 25
Ciclos atascos BTS = 7
Ciclos = ciclos sin atascos + ciclos por atascos RAW + ciclos por atascos BTS = 55 +25 + 7 = 87

○ El CPI será : 87 / 51 = 1,706

; Modificacion con DS activado:

.data
cant: .word 8
datos: .word 1, 2, 3, 4, 5, 6, 7, 8
res: .word 0
.code
(01) dadd r1, r0, r0
(02) ld r2, cant(r0)
(03)loop: ld r3, datos(r1)
(04) daddi r2, r2, -1
(05) dsll r3, r3, 1 
(06) sd r3, res(r1) 
(07) bnez r2, loop
(08) daddi r1, r1, 8 ; con ds siempre se ejecura antes del salto y salta
(09) halt

Reordenando las instrucciones la cantidad de instrucciones totales que se ejecutan no cambia.
Como cambiamos el orden de las instrucciones, ahora generamos otros atascos, principalmente porque ahora
las instrucciones (09) y (03) estan consecutivas y genera dos atascos RAW.

Ya no vamos a tener atascos por saltos, por usar delay slot.

De los atascos RAWs que ocurrieron originalmente sumamos 2 atascos RAW entre (09) y (03) por cada vuelta
al inicio del bucle que se realice. Como el bucle se ejecuta 8 veces, se vuelve 7, es decir sumamos 7 veces 2
atascos RAW, es decir 14. La cantidad de RAWs asciende de 25 a 39.

La cantidad de ciclos en los que se ejecuta el programa será:
Ciclos sin atascos = #Instrucciones + 4 = 55
Ciclos atascos BTS = 39
Ciclos = ciclos sin atascos + ciclos por atascos RAW = 55 +39 = 94

○ El CPI será : 94/ 51 = 1,843
