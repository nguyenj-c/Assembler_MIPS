        .data
N:      .word 5 # unsigned N
T:      .word 1, 2, 3, 4, 5 # unsigned T[]
str:    .asciiz "T : \n"

        .text

main:       ori $v0, $zero, 4 # affichage d’une chaine
            la $a0, str # $a0 <- @chaine
            syscall # "T : \n"
            la $t0, N # $t0 <- @N
            lw $s0, 0($t0) # $s0 <- N
            la $s1, T # T:$s1 <- @T
            or $t0, $zero, $zero # i:$t0 <- 0

for:        beq $t0, $s0, exitfor # if (i==N) goto exitfor
            sll $t1, $t0, 2 # $t1 <- i:$t0 * 4
            add $t1, $s1, $t1 # $t1 <- @T + deplacement physique
            lw $a0, 0($t1) # $a0 <- T[i]
            ori $v0, $zero, 1 # affichage d’un entier
            syscall # affiche le contenu de $a0
            addi $t0, $t0, 1 # ++i
            j for # retour au debut de boucle

exitfor:    or $v0, $zero, 10 # return 0
            syscall