.data
pantalla: .space 768

.text
#INICIO DEL JUEGO
#-----------------------
#colores
#fondo 95e40f
#223e06 obstaculos
#5b7d1e

inicio:
ori $s5,$0,344
ori $s6,$0,360
ori $s7,$0,376
ori $s0,$0,388



#LLENAR EL FONDO Y BORDE
ori $a0,$0,0x29dfff
jal llenar_pantalla
ori $a0,$0,0xf9ff37
jal borde

#OBSTACULOS
ori $a0,$0,0xffffff
ori $s5,$0,344
jal obstaculo1

ori $s6,$0,360
jal obstaculo2

ori $s7,$0,376
jal obstaculo3

#UBICACIÓN DEL JUGADOR
#Posicion inicial, registro s0
ori $s0,$0,388 #Posicion incial del dinosaurio
ori $a0,$0,0x223e06 #color del dinosaurio
ori $a1,$s0,0 #direccion
jal colorear
ori $a0,$0,400000
jal esperar

#Espera de un boton para iniciar
espera_tecla:
lw $s3,0xFFFF0000
beq $s3,1,main_loop
j espera_tecla

main_loop:
j mov_obs1

vuelta1:
j mov_obs2

vuelta2:
j mov_obs3

vuelta3:
slti $s1, $s0, 388
bne $s1, 1, main
j bajar

main:
ori $a0,$s0,0
sll $a1, $s1, 4 #y*16
jal coor_dir
addi $a0, $v0, 0

lw $s3, 0xFFFF0000
beq $s3, 0, main_loop

lw $s4,0xFFFF0004
ori $t7,$s0,388
slt $t7,$s0,$t7
beq $t7,1,nosalto
beq $s4,97,subir

nosalto:
sw $0,0xffff0000
j main_loop



# FUNCIONES DE SUBIDA Y BAJADA
subir:
#Pintar posicion vieja del color de la pantalla
ori $a0,$0,0x29dfff #color
ori $a1,$s0,0 #direccion
jal colorear
#Nueva posición
addi $s0,$s0,-192  #salta 3 filas
#Dibujar al jugador
ori $a0,$0,0x223e06 #color
ori $a1,$s0,0 #direccion
jal colorear
j main_loop

bajar:
#Pintar posicion vieja del color de la pantalla
#Borrar al jugador
ori $a0, $0, 0x29dfff #color
ori $a1, $s0, 0 #direccion
jal colorear
#Nueva posición
addi $s0,$s0,64
#Dibujar al jugador
ori $a0, $0, 0x223e06 #color
ori $a1, $s0, 0 #direccion
jal colorear
ori $a0, $0, 40000
jal esperar
j main


#FUNCIONES PARA PINTAR LA PANTALLA Y EL BORDE
#Parametros:	a0: color de la pantalla
#Pantalla
llenar_pantalla:
ori $t1,$0,0
loop:
sw $a0,pantalla($t1)
addi $t1,$t1,4
beq $t1,1024, exit
j loop
exit:
jr $ra

#Borde
borde:
ori $t2,$0,448
loop_b:
sw $a0,pantalla($t2)
addi $t2,$t2,4
beq $t2,1024, exit_b
j loop_b
exit_b:
jr $ra




#---- POSICION A COORDENADA
#Parametros:	(a0,a1) = (x,y): posicion
#		v0: resultado, ubicacion en memoria
coor_dir:
ori $t0, $a0, 0 #copia x
ori $t1, $a1, 0 #copia y*16
add $t2, $t0, $t1 # x + y*16
sll $t3, $t2, 2 # 4*(x + y*16)
addi $v0, $t3, 0
jr $ra

#DIBUJAR JUGADOR
#Parametros: 	a0: color
#		a1: ubicacion en memoria
colorear:
ori $t0, $a0, 0
ori $t1, $a1, 0 
sw $t0, pantalla($t1)
jr $ra


#TIEMPO DE ESPERA
#Parametros: 
#a0: tiempo de espera (Ej:10000 para que esté en milisegundos)
esperar: 	
ori $t0,$0,0
loop_espera:
beq $t0, $a0, exit_espera
addi $t0, $t0, 1
j loop_espera
exit_espera:
jr $ra
		
#-----------OBSTACULOS
#Obstaculo 1
#a0 tiene el color
obstaculo1:
or $t1, $0, $s5 #s5: dirección del 1er obstaculo
ori $t2, $0, 2 #longitud del obstaculo
sll $t2, $t2, 6 #t2: valor 64
add $t2, $t2, $t1
loop_obs1:
sw $a0, pantalla($t1)
addi $t1, $t1, 64
beq $t1, $t2, exit_obs1
j loop_obs1
exit_obs1:
jr $ra


#Movimiento Obstaculo 1
mov_obs1:
ori $a0,$0,0x29dfff 
jal obstaculo1 
addi $s5,$s5,-4 #se mueve hacia la izquierda
beq $s5, 316, derecha1 
j salto1
derecha1:
ori $s5, $0, 380
salto1:
ori $a0,$0,0xffffff
jal obstaculo1
jal colision
ori $a0,$0,40000
jal esperar
j vuelta1


#Obstaculo 2
obstaculo2:
or $t1,$0,$s6 #copio cabeza
ori $t2,$0,1 #longitud
sll $t2,$t2,2 #multiplico por 4
add $t2,$t2,$t1
loop_obs2:
sw $a0,pantalla($t1)
addi $t1,$t1,4
beq $t1,$t2, exit_obs2
j loop_obs2
exit_obs2:
jr $ra

#Movimiento del obstaculo 2
mov_obs2:
ori $a0,$0,0x29dfff
jal obstaculo2
addi $s6, $s6, -4
or $t0, $0, $s6
addi $t0, $t0, 4
beq $s6, 316, derecha2
j salto2
derecha2:
ori $s6, $0, 380
salto2:
ori $a0,$0,0xffffff
jal obstaculo2
jal colision
ori $a0,$0,40000
jal esperar
j vuelta2

#Obstaculo 3
obstaculo3:
or $t1,$0,$s7 #copio cabeza
ori $t2,$0,2 #longitud
sll $t2,$t2,6 #multiplico por 4
add $t2,$t2,$t1
loop_obs3:
sw $a0,pantalla($t1)
addi $t1,$t1,64
beq $t1,$t2, exit_obs3
j loop_obs3
exit_obs3:
jr $ra

#Movimiento del obstaculo 3
mov_obs3:
ori $a0,$0,0x29dfff
jal obstaculo3
addi $s7,$s7,-4
or $t0,$0,$s7
addi $t0,$t0,4
beq $s7, 316, derecha3
j salto3
derecha3:
ori $s7, $0, 380
salto3:
ori $a0,$0,0xffffff
jal obstaculo3
jal colision
ori $a0,$0,40000
jal esperar
j vuelta3

#-----------------------------------
# DETECCIÓN DE COLISIÓN
# Compara si la posición del jugador (s0) coincide con alguno de los obstáculos
# Registros usados: s0 (jugador), s5 (obs1), s6 (obs2), s7 (obs3)
colision:
    # Obstacle 1: s5 y s5 + 64
    beq $s0, $s5, game_over
    addi $t0, $s5, 64
    beq $s0, $t0, game_over

    # Obstacle 2: solo en s6
    beq $s0, $s6, game_over

    # Obstacle 3: solo en s7
    beq $s0, $s7, game_over
    addi $t1, $s7, 64
    beq $s0, $t1, game_over
    

    jr $ra

# GAME OVER: pantalla roja y loop infinito
game_over:
    # Pintar pantalla de rojo
    ori $a0, $0, 0xff0000  # Rojo
    jal llenar_pantalla

    # Espera para que se vea el rojo
    ori $a0, $0, 200000
    jal esperar

esperar_tecla_gameover:
    lw $t1, 0xFFFF0000   # Teclado listo?
    beq $t1, 1, reiniciar_juego
    j esperar_tecla_gameover

reiniciar_juego:
    sw $0, 0xFFFF0000    # Limpiar buffer teclado
    j inicio             # Reinicia el juego desde el inicio
