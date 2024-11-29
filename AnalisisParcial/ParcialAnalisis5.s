.data 
CONTROL: .word 0x10000
DATA: .word 0x10008

.code
lwu $s6, CONTROL($0)
lwu $s7, DATA ($0)

;inicializo registro con un codigo fijo
daddi $t0, $0, 9 ; El nueve es para leer un caracter
sd $t0, 0 ($s6)
lbu $t1, 0 ($s7) ; El caracter leido (en data) lo almaceno en $t1