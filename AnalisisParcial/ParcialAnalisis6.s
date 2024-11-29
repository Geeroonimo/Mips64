; Un programa que grafica lineas de pixeles en pantalla unas mas grandes que otras..
.data
CONTROL: .word 0x10000 ; word = 64 bits ; dir control
DATA: .word 0x10008 ; dir data

tabla1: .double 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0 ;.double es para punto flotante
tabla2: .double 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

.code  
; almacenamos direcciones en registros (sin desplazamientos)
ld $s0, CONTROL ($0) ; ld es para ocupar el registro completo
ld $s1, DATA ($0)

; Cantidad de elementos a recorrer
daddi $s2, $0, 11 ; $s2 = 11
; Direcciones de tabla1 y tabla2
daddi $s3, $0, tabla1
daddi $s4, $0, tabla2
; Itero por tabla
loop: l.d f1, 0 ($s3) ; Elemento actual de la tabla (f1 es un registro flotante)
      l.d f2, 8 ($s3); Le sumo 8(bytes) a la direccion para obtener el segundo valor
      ;Mando ambos numeros a la subrutina
      jal promediar ; Con jal llamo a la subrutina (promediar)
      ;Guardo el resultado del promedio en tabla2
      s.d f3, 0 ($s4) ; Almaceno por completo lo que tiene f3 en tabla2 (0 + $s4 = $s4)
      
      ;Avanzo en ambas tablas y decremento elementos
      daddi $s3, $s3, 8 ; daddi Suma $s3 con el valor inmediato 8 dejando el resultado en $s3(valores con signo)
      daddi $s4, $s4, 8
      daddi $s2, $s2, -1 ; decremento elementos
      
      bnez $s2, loop ;Mientras $s2 no sea 0 salta a loop
    
;Imprimo todo tabla2
daddi $a0, $0, tabla2 ; $a0 = dir tabla2      
jal imprimir
halt
promediar: add.d f3, f1, f2 ; Sumo f1 + f2 y lo almaceno en f3 ; add.d Se usa para sumar numeros conn coma
           ; Popngo el 2.0 en un registro flotante
           daddi $t0, $0, 2
           mtc1 $t0, f4   ; Copia los 64 bits del registro entero deun registro a otro registro en punto flotante
           cvt.d.l f4, f4
           div.d f3, f3, f4
           jr $ra

daddi $t1, $0, 3; $0 + 3 = 3 y lo mando a $t1
imprimir: daddi $a0, $0, 11
    loopimp: l.d f1, 0 ($a0)
     ;Mando el dato
      s.d f1, 0 ($s1) ; Mando el elemento actual a DATA
      sd $t1, 0 ($s0) ; Mando el 3 a dir de control para que sepa que va a imprimir
      
      daddi $a0, $a0, 8; avanzo al siguiente elemento
      daddi $t0, $t0, -1 ; resto la cantidad de elementos
      bnez loopimp ; Mientras no sea 0 salto vuelo a imprimir
    
    jr $ra
; lb: es para traer de memoria
; sb: es para almacenar en memoria

; l.b y s.b para punto flotante
; l.d y s.d par guardarlo completo

;Primero visualizamos los datos que vamos a manejar

;Ya que el enunciado nos esta diciendo que tenemos que leer/imprimir desde
;luego que se usan variables para alamacenar las direcciones de CONTROL y DATA