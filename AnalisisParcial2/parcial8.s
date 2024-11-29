; Escribir un programa para WinMIPS que lea 3 números enteros (A, B y C) ingresados por el usuario desde el teclado, resuelva el 
; cálculo (A - B)^C y almacene el resultado en la memoria en la variable RES. El cálculo debe resolverse en una subrutina que reciba 
; como parámetros los 3 operandos y retorne el valor del resultado. Finalmente, el valor calculado debe mostrarse en la pantalla 
; alfanumérica. Debe utilizarse la convención para nombrar los registros que se empleen durante el programa (10 pts)."
.data
A: .word 0
B: .word 0
C: .word 0
RES: .word 0
CONTROL: .word32 0x10000
DATA: .word32 0x10008

.code
lwu $s0, CONTROL($0)
lwu $s1, DATA($0)
daddi $t0, $0, 8 ; 8: leer numero e ingresar en la terminal
sd $t0, 0 ($s0) ; CONTROL = 8
ld $a0, 0 ($s1) ; $a0 = numero ledio
sd $a0, A ($0) ; Almaceno el numero leido en A, A = num1 
sd $t0, 0 ($s0) ; CONTROL = 8
ld $a1, 0 ($s1) ; $a1 = numero leido
sd $a1, B ($0) ; B = num2
sd $t0, 0 ($s0) ; CONTROL = 8
ld $a2, 0 ($s1) ; $a2 = numero leido
sd $a2, C ($0) ; C = num3
jal CALCULO
sd $v0, RES($0)
sd $v0, 0 ($s1) ; DATA = Resultado
daddi $t0, $0, 2; $t0 = 2
sd $t0, 0 ($s0); CONTROL = 2: imprime numeros enteros con signo en la pantalla alfanumerica de la terminal
halt

CALCULO: daddi $v0, $0, 0 ; $v0 = 0 lo inicializo
         beqz $a2, FIN ; Si $a2 (C) es igual 0 salta a fin 
         dsub $t1, $a1, $a0 ; $t1 = $a0 - $a1 (A - B)
         dadd $v0, $0, $t1 ; $v0 = $t1(resultado de A - B)
   LOOP: dmul $v0, $v0, $t1 ; $v0 = ($v0 * $t1)
         daddi $a2, $0, -1 ; $a2 = $a2 - 1
         bnez $a2, LOOP ; Si $a2 <> 0 salta a loop
   FIN:  j $ra

