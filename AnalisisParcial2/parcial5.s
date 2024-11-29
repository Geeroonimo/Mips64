; Convertir a entero un numero de punto flotante 
.data
 A: .word 5.0

l.d f9, A ($0) ; tomo flotante ; ejemplo

cvt.l.d f9 ,f9 ; Convierte a entero el valor en punto flotante de f9 dejandolo nuevamente en f9
mfc1 r5, f9 ; Copia los 64 bits de f9 de punto flotante al registro r5 entero