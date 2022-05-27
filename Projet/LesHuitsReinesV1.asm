			.data 
N: 			.word 8			# unsigned N 

SolutionNum: 		.word 0 		# unsigned SolutionNum

Colonne: 		#.word	0,1,2,3,4,5,6,7
			.align	2
			.space	8

msg:			.asciiz "Solution numero " 

deuxpoints:		.asciiz " : "

finligne:		.asciiz "\n"

espace: 		.asciiz "  "

R: 			.asciiz "R"

plus: 			.asciiz "+"

			.text
			
main:			la $s0, N			# $s0 <- N
			j Reine   			# appel de Reine
			or $v0, $zero, 10 		# return 0
			syscall 			# appel système de terminaison de programme
			
AfficherSolution:	ori $v0, $zero, 4 		# $v0 <- 4
			la $a1, msg 			# $a1 <- str 
			syscall				# appel de print_string 
			
			ori $v0, $zero, 1 		# $v0 <- 1
			la $a2, SolutionNum 		# $a2 <- SolutionNum 
			addi $a2, $a2, 1  		# $a2=$a2+1
			syscall				# appel de print_int 

			ori $v0, $zero, 4 		# $v0 <- 4
			la $a3, deuxpoints 		# $a3 <- deuxpoints
			syscall				# appel de print_string 
			
			ori $v0, $zero, 4		# $v0 <- 4
			la $a3, finligne		# $a3 <- finligne
			syscall				# appel de print_string 
			
			ori $s4, $zero, 0		# $s4 <- 0
			
for3:			beq $s4, $s0, endfor3		# if ($s4 == $s0) goto endfor3
			ori $s5, $zero, 0		# $s5 <- 0
			j for4				# goto for4
			addi $s4, $s4, 1		# $s4=$s4+1
			j for3				# goto for3

for4:			beq $s5, $s0, endfor4		# if ($s5 == $s0) goto endfor4
			la $t1, Colonne($s4)		# $t1 <- Colonne($s4)
			beq $s5, $t1, if		# if ($s5 == $t1) goto if
			ori $v0, $zero, 4		# $v0 <- 4
			la $a3, espace			# $a3 <- espace
			syscall				# appel de print_string
			ori $v0, $zero, 4		# $v0 <- 4
			la $a3, plus			# $a3 <- plus
			syscall				# appel de print_string
			addi $s5, $s5, 1		# $s5=$s5+1
			j for4				# goto for4
			
if:			ori $v0, $zero, 4		# $v0 <- 4
			la $a3, espace			# $a3 <- espace
			syscall				# appel de print_string
			ori $v0, $zero, 4		# $v0 <- 4
			la $a3, R			# $a3 <- R
			syscall				# appel de print_string
			
endfor4:		ori $v0, $zero, 4		# $v0 <- 4
			la $a3, finligne		# $a3 <- finligne
			syscall				# appel de print_string

endfor3:		ori $v0, $zero, 4		# $v0 <- 4
			la $a3, finligne		# $a3 <- finligne
			syscall				# appel de print_string

SansConflit:		la $s2, ($a0)			# $s2= $a0
			la $s3, ($s1)			# $s3= $s1
			ori $s6, $zero, 0		# $s6 <- 0
			
for2:			beq $s6, $s2, endfor2		# if ($s6==$s2) goto endfor2
			la $t1, ($t0)			# $t1 <- $t0
			la $t2, Colonne($t0)		# $t2 <- Colonne($t0)
			beq $t1, $s2, returnfalse	# if ($t1 == $s2) goto returnfalse
			beq $t2, $s3, returnfalse	# if ($t2 == $s3) goto returnfalse
			sub $t3, $t1, $t2		# $t3=$t1-$t2
			sub $t4, $s2, $s3		# $t4=$s2-$s3
			beq $t3, $t4, returnfalse	# if ($t3 == $t4) goto returnfalse
			add $t5, $t1, $t2		# $t5=$t1+$t2
			add $t6, $s2, $s3		# $t6=$s2+$s3
			beq $t5, $t6, returnfalse	# if ($t5 == $t6) goto returnfalse
			addi $s6, $s6, 1		# $s6=$s6+1
			j for2				# goto for2
			
returnfalse:		addi $s1, $s1, 1		# $s1=$s1+1
			
endfor2:		j returntrue			# goto returntrue

ReineR:			beq $a0, $s0, AfficherSolution	# if ($a0 == $s0) goto AfficherSolution
			ori $s1, $zero, 0		# $s1 <- 0
			
for1:			#beq $s1, $s0, endfor1		# if ($s0 == $s1) goto endfor1
			j SansConflit			# goto SansConflit

returntrue:		sw $t0, Colonne($a0)		# Colonne($a0) <- $t0
			addi $a0, $a0, 1		# $a0=$a0+1
			j ReineR			# goto ReineR

#endfor1:			
			
Reine:			ori $a0, $zero, 0 		# $a0 <- 0
			j ReineR  			# goto ReineR



