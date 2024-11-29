; Completar instrucciones para imprimir en la pantalla alfanumerica del simulador un numero en punto flotante
.data
CONTROL: .word32 0x10000
DATA: .word32 0x10008
.code
lwu $s6, CONTROL ($0)
lwu $s7, DATA ($0)

s.d f2, 0 ($s7) ; DATA = F2 (numero en punto flotante)
daddi $t0, $t0, 3 ;  $t1 = 3(3 es para imprimir un numero de punto flotante en la terminal)
sd $t0, 0 ($s6) ; CONTROL = 3 (mando el 3 a control)