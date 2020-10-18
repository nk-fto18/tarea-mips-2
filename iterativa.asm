.data
ingreso: .asciiz "Ingrese un numero: "

.text
.globl main
main:

#Pido al usuario un numero y lo guardo en a0
	li $v0, 4			
	la $a0, ingreso		
	syscall		
	li $v0, 5			
	syscall				
	move $a0, $v0		

#Llamo a factorial
jal factorial

#Imprimo el resultado
move      $a0, $v0
li        $v0, 1
syscall


#Finalizo
li $v0, 10
syscall


factorial:
#Prologo
	addi $sp, $sp, -4 	#Un solo lugar: a0
	sw $a0, 0($sp)
#-------
	li $s0, 1			#El resultado
loop:
	beq $a0, $zero, return		#while(t0 != 0){
	mul $s0, $s0, $a0			#	t1 *= t0;
	addi $a0, $a0, -1			#	t0--;
	j loop						#}

return:
	move $v0, $s0

#Epilogo
	lw $a0, 0($sp)
	addi $sp, $sp, 4
#-----
	jr $ra 				#Return
