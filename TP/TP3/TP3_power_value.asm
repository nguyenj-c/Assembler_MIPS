	.data 
str1: 	.asciiz "Entrez x : " 
str2: 	.asciiz "Entrez n : " 
str3: 	.asciiz "x^n = "
	.text
main: 	ori $v0, $zero, 4 # v0 <- 4 
	la $a0, str1 # a0 <- str1 
	syscall # "Entrez x : " 
	ori $v0, $zero, 5 # v0 <- 5 
	syscall # lecture 
	or $t0, $zero, $v0 # t0 <- v0 : sauvegarde de x 
	ori $v0, $zero, 4 # v0 <- 4 
	la $a0, str2 # a0 <- str2 
	syscall # "Entrez n : " 
	ori $v0, $zero, 5 # v0 <- 5 
	syscall # lecture
	or $a1, $zero, $v0 # a0 <- n 
	or $a0, $zero, $t0 # a1 <- x 
	jal power # ra <- PC+4; goto power 
	or $t0, $zero, $v0 # to <- v0 : sauvegarde de x^n
	ori $v0, $zero, 4 # v0 <- 4 
	la $a0, str3 # a0 <- str2 
	syscall # "x^n = " 
	or $a0, $zero, $t0 # a0 <- t0 
	ori $v0, $zero, 1 # v0 <- 1 
	syscall # affichage de x^n
	ori $v0, $zero, 10 # v0 <- 10 
	syscall # return 0
	
power: 	addi $sp, $sp, -4 # alloue 1 mot dans la pile 
	sw $ra, 0($sp) # empile l’adresse de retour 
	bne $a1, $zero, recurs # if (n!=0) goto recurs 
	addi $v0, $zero, 1 # $v0 <- 1 
	lw $ra, 0($sp) # depile l’adresse de retour 
	addi $sp, $sp 4 # rend l’espace memoire 
	jr $ra # return x 
recurs: addi $a1, $a1, -1 # n-1 
	jal power # appel recursif de power 
	lw $ra, 0($sp) # depile l’adresse de retour 
	addi $sp, $sp 4 # rend l’espace memoire 
	mul $v0, $a0, $v0 # x * power(x,n-1) 
	jr $ra	
#power:  addi $sp, $sp, -12        # alloue l’espace dans la pile
#        sw $ra, 8($sp)            # empile l’adresse de retour
#       sw $a1, 4($sp)            # empile l’argument n
#        sw $a0, 0($sp)            # empile l’argument x
#        bne $a1, $zero, recurs    # if (n>=1) goto recurs;
#        ori $v0, $zero, 1         # return x; avec x^0 = 1
#        addi $sp, $sp, 12         # pop des trois valeurs sauvées
#        jr $ra                    # retour à l’appelant
#recurs: addi $a1, $a1, -1         # n>=1: l’argument reçoit n-1
        jal power                 # appel récursif
 #       lw $a0, 0($sp)            # dépile l’argument x        
  #      lw $a1, 4($sp)            # dépile l’argument n
   #     lw $ra, 8($sp)            # dépile l’adresse de retour
    #    addi $sp, $sp, 12         # rend l’espace dans la pile
     #   mul $v0, $a0, $v0         # return x*power(x, n-1)
      #  jr $ra                    # retour à la fonction appelante
