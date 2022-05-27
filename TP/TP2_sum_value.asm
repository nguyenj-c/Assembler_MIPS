	.data 
str1: 	.asciiz "Entrez une suite d’entiers, terminez par 0 : \n" 
str2: 	.asciiz "Somme = "
	.text 
main: 	ori $v0, $zero, 4 # v0 <- 4 
	la $a0, str1 # a0 <- str1 
	syscall # "Entrez une suite d’entiers, terminez par 0 : \n" 
	or $t0, $zero, $zero # t0 <- 0 
lecture: 	ori $v0, $zero, 5 # v0 <- 5 
		syscall # lecture 
		add $t0, $v0, $t0 # t0 <- v0 + t0 
		bne $v0, $zero, lecture # if (vo != 0) goto lecture 
		ori $v0, $zero, 4 # v0 <- 4 
		la $a0, str2 # a0 <- str2 
		syscall # "Somme = " 
		or $a0, $zero, $t0 # a0 <- t0 
		ori $v0, $zero, 1 # v0 <- 1 
		syscall # affichage de la somme 
		ori $v0, $zero, 10 # v0 <- 10 
		syscall # return 0