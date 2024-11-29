;Resumen

Atascos Por salto Branch Taken Stall(BTS):  Los BTS se producen cuando tenemos un salto en la ejecución del programa. La CPU sabe que una
instrucción es de salto cuando se decodifica, por lo tanto hay que descartar la instrucción que se
capto en la etapa IF que no se va a ejecutar (porque se va a ejecutar la instrucción
correspondiente al salto)

Branch Misprediction Stall (BMS): Estos atascos ocurren cuando hay una
mala predicción del salto. Si se predijo que el salto iba a ocurrir y no ocurre, o se predice que
no va a ocurrir y ocurre, tenemos ese atasco.


Habilitar la opción Branch Target Buffer (BTB): Es una opcion la cual cuando se habilita reduce atascos, y
este mismo nos beneficia más cuando se realizan más iteraciones.

Al ejecutar un loop simple con N iteraciones, si se habilita BTB, se
producen 2 atascos de tipo BTS y 2 atascos de tipo BMS.

En algunos casos pueda causar ineficiencia, por lo tanto es mejor desactivarlo

Delay Slot(DS): El delay slot (DS) cambia el funcionamiento de los saltos. Cuando está activado, el salto se realiza con un
retardo de un ciclo. Esto significa que la instrucción siguiente al salto siempre se ejecuta. De esta forma, los
BTS desaparecen completamente, aunque esto no significa necesariamente que la ejecución sea más eficiente

Parte 3: Atascos por WAR, WAW y estructurales.

Las instrucciones de multiplicación y división tardan más ciclos que las de suma. Por este motivo, 
las instrucciones de suma pueden comenzar después que las de multiplicación o división, y 
terminar antes, generando efectivamente una ejecución fuera de orden (out of order execution).

Este tipo de ejecución abre la posibilidad a tres nuevos tipos de atascos: WAR (Write After Read, o atascar la
escritura para que termine la lectura), WAW (Write After Write, o atascar la escritura para que termine la
otra escritura) y STR (estructurales, o atascar una instrucción porque la siguiente etapa o estructura del
procesador está siendo utilizada).

