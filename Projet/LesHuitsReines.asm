		.data
		
msg :		.asciiz "Solution numero "

R :		.asciiz "R"

space :		.asciiz "  "

twopoints :	.asciiz " : "

plus :		.asciiz "+"

endline :	.asciiz	"\n"

column :	#.word	0,0,0,0,0,0,0,0
		.align	2
		.space	8
			
		.globl main
		.text
main :						#						// Sachant que dans le programme C++, N est une variable constante, nous n'utilisons donc pas de registre
	ori $s0, $zero, 0			# $s0 <- 0					// $s0 correspond à SolutionNum dans le programme C++
						#						// $s1 correponds au tableau Colonne
						
	jal Reine				# goto Reine()
	
	
	ori $v0, $zero, 10			# $v0 <- 10
	syscall					# appel de 'exit'
					

AfficherSolution :			
	ori $v0, $zero, 4			# $v0 <- 4
	la $a0, msg				# $a0 <- Message
	syscall					# appel de 'print_string'
	
	addi $s0, $s0, 1			# s0 <- $s0 + 1
	or $a0, $zero, $s0			# $a0 <- $s0
	ori $v0, $zero, 1			# $v0 <- 1
	syscall					# appel de 'print_int'
	
	ori $v0, $zero, 4			# $v0 <- 4
	la $a0, twopoints			# $a0 <- DeuxPoints
	syscall					# appel de 'print_string'
	
	la $a0, endline				# $a0 <- EndLine
	syscall					# appel de 'print_string'
	
	ori $t1, $zero, 0			# $t1 <- 0					// $t1 correspond à la variable i de la méthode AfficherSolution du programme C++


for2 :
	ori $t2, $zero, 0			# $t2 <- 0					// $t2 correspond à la variable j de la méthode AfficherSolution du programme C++


for3 :
	la $a0, space				# $a0 <- Espacement
	syscall					# appel de 'print_string'

	sll $t0, $t1, 2				# $t0 <- $t1 * 4
	lw $t0, column($t0)			# $t4 <- Colonne[$t6]
	beq $t2, $t0, if			# if ($t2 == $t0) goto if()
	la $a0, plus				# $a0 <- Plus


endif :
	syscall					# appel de 'print_string'
	
	addi $t2, $t2, 1			# $t2 <- $t2 + 1
	slti $t0, $t2, 8			# if ($t2 < 8) $t0 = 1 ; else $t0 = 0
	bne $t0, $zero, for3			# if ($t0 != 0) goto for3()
	
	la $a0, endline				# $a0 <- EndLine
	syscall					# appel de 'print_string'
	
	addi $t1, $t1, 1			# $t1 <- $t1 + 1
	slti $t0, $t1, 8			# if ($t1 < 8) $t0 = 1 ; else $t0 = 0
	bne $t0, $zero, for2			# if ($t0 != 0) goto for2()
	
	la $a0, endline				# $a0 <- EndLine
	syscall					# appel de 'print_string'
	
	j AfficherSolutionFIN			# goto AfficherSolutionFIN
						# fin AfficherSolution()


if :
	la $a0, R				# $a0 <- R
	j endif					# goto endif
					
					
SansConflit :					# debut SansConflit()				// modifie $t0 - $t1 - $t2 - $t3 - $t4 - $t5 - $t6 || utilise $s2 - $s3 - $ra
	or $t3, $zero, $s2			# $t3 <- $s2					// $t3 <=> i2
	or $t5, $zero, $s3			# $t5 <- $s3					// $t5 <=> j2
	ori $t6, $zero, 0			# $t6 <- 0					// $t6 correspond à la variable temporaire k de la méthode SansConflit du programme C++
	ori $t1, $zero, 1			# $t1 <- 1					// $t1 correspond à la valeur retourné par la méthode SansConflit


for4 :
	or $t2, $zero, $t6			# $t2 <- $t6					// $t2 <=> i1
	sll $t0, $t6, 2				# $t0 <- $t6 * 4
	lw $t4, column($t0)			# $t4 <- Colonne[$t6]				// $t4 <=> j1
	
	beq $t2, $t3, returnfalse 		# if ($t2 == $t3) goto returnfalse()
	beq $t4, $t5, returnfalse 		# if ($t4 == $t5) goto returnfalse()
	
	sub $t7, $t2, $t4			# $t7 <- $t2 - $t4
	sub $t8, $t3, $t5			# $t8 <- $t3 - $t5
	beq $t7, $t8, returnfalse 		# if ($t7 == $t8) goto returnfalse()
	
	add $t7, $t2, $t4			# $t7 <- $t2 + $t4
	add $t8, $t3, $t5			# $t8 <- $t3 + $t5
	beq $t7, $t8, returnfalse 		# if ($t7 == $t8) goto returnfalse()
	
	addi $t6, $t6, 1 			# $t6 <- $t6 + 1
	slt $t0, $t6, $s2			# if ($t6 < $s2) $t0 = 1 ; else $t0 = 0
	bne $t0, $zero, for4			# if ($t0 != 0) goto for4


endfor4 :
	jr $ra					# retour à l'adresse de $ra


returnfalse :
	ori $t1, $zero, 0			# $t1 <- 0
	j endfor4				# goto endfor4()
						# fin SansConflit()
					
					
ReineR :					# debut ReineR()				// modifie $sp - $ra - $t0 - $s2 - $s3 || utilise $t1
	addi $sp, $sp, -12			# $sp <- $sp - 12
	sw $ra, ($sp)				# enregistre dans la pile $ra
	
	slti $t0, $s2, 8			# if ($s2 < 8) $t0 = 1 ; else $t0 = 0
	beq $t0, $zero, AfficherSolution	# if ($t0 == 0) goto AfficherSolution
	ori $s3, $zero, 0			# $s3 <- 0					// $s3 correspond à la variable k dans le programme C++


for :
	jal SansConflit				# goto SansConflit
	beq $t1, $zero, endfor			# if ($t1 == 0) goto endfor()
	
	sll $t0, $s2, 2				# $t0 <- $s3 * 4
	sw $s3, column($t0)			# Colonne($t0) <- $s3
	
	sw $s3, 4($sp)				# enregistre dans la pile $s3
	sw $s2, 8($sp)				# enregistre dans la pile $s2
	addi $s2, $s2, 1 			# $s2 <- $s2 + 1
	jal ReineR				# goto ReineR
	lw $s3, 4($sp)				# récupère de la pile $s3
	lw $s2, 8($sp)				# récupère de la pile $s2
	

endfor :
	addi $s3, $s3, 1			# $s3 <- $s3 + 1
	slti $t0, $s3, 8			# if ($s3 < 8) $t0 = 1 ; else $t0 = 0
	bne $t0, $zero, for			# if ($t0 != 0) goto for()


AfficherSolutionFIN :
	
	lw $ra, ($sp)				# récupère de la pile puis met dans $ra
	addi $sp, $sp, 12			# $sp <- $sp + 12
	jr $ra					# retour à l'adresse de $ra
	
	
Reine :						# debut Reine()					// modifie $sp - $ra - $s2
	addi $sp, $sp, -4			# $sp <- $sp - 4
	sw $ra, ($sp)				# enregistre dans la pile $ra
	
	ori $s2, $zero, 0			# $s2 <- 0					// $s2 correspond au paramètre i de ReineR dans le programme C++
	jal ReineR				# goto ReineR()
	
	lw $ra, ($sp)				# récupère de la pile puis met dans $ra
	addi $sp, $sp, 4			# $sp <- $sp + 4
	jr $ra					# retour à l'adresse de $ra
					
