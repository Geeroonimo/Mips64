.data
TABLA1: double 12.0, 15.5, 31.2, 56.4, 44.3, 78.1
MIN: double 20.0
MAX: double 50.0
CANT: word 6
RES: double 0
TABLA2: double 0.0

.code
LD $t0, CANT($zero) ; $t0 = 6 (cantidad de elementos)
L.D F1, MIN($zero) ; F1 = MIN (20.0)
L.D F2, MAX ($zero) ; F2 = MAX (50.0)
DADD $t3, $zero, $zero ; $t3 = 0
DADD $t4, $zero, $zero ; $t4 = 0
DADD $t5, $zero, $zero ; $t5 = 0
LOOP: L.D F3, TABLA1($t4)
      C.LT.D F3, F1 ; ; Si F3 < F1; Flag FP = 1
      BC1T FUERA ; Salta a afuera si FP = 1
      C.LT.D F2, F3 ; Verifica si F2(MAX) < F3
      BC1T FUERA ; Si es menor FP = 1 y salta a FUERA
      DADDI $t3, $t3, 1 ; $t3 = 1 ; Sumo elemento
      S.D F3, TABLA2($t5) ; TABLA2 = F3
      DADDI $t5, $t5, 8 ; Sumo 8 para avanzar a la siguiente posicion de TABLA2
FUERA: DADDI $t4, $t4, 8 ; $t4 = 8 (sumo 8 para avanzar al siguiente elemento)
       DADDI $t0, $t0, -1 ; $t0 = 5 
       BNEZ $t0, LOOP ; Mientras $t0 <> 0 salta a LOOP
       SD $t3, RES($zero) ; RES = $t3 ; $t3 = 2(Elementos que entran dentro del rango)
       HALT

; En TABLA2 va a meter los numeros que esten dentro del rango MIN y MAX

; L.D F2, MAX($zero): Cargamos el valor máximo permitido en F2 desde la dirección MAX.
; L.D F3, TABLA1($t4): En cada iteración, cargamos el siguiente valor de la tabla de entrada (TABLA1) para procesarlo.
; DADDI $t5, $t5, 8: Actualizamos el registro para guardar el siguiente valor válido en TABLA2.