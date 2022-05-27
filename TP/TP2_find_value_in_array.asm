        .data
        .word

save:   0x000000000, # int save[];
        0x000000000,
        0x000000000,
        0x000000000,
        0x000000000,
        0x000000000,
        0x000000000,
        0x000000001,
        0x000000002,
        0x000000003 # save[9]
        .text

main:       la $a0, save # $a0 <- @save
            ori $a1, $zero, 1 # $a1 = 1
            ori $a2, $zero, 9 # $a2 = 9;
            jal Recherche # appel de Recherche()
            or $a0, $zero, $v0 # $a0 <- entier i afficher
            ori $v0, $zero, 1 # affichage
            syscall
            ori $v0, $zero, 10 # $v0 <- 10
            syscall # return 0

Recherche:  or $s0, $zero, $zero # $s0:i <- 0
for:        slt $t0, $a2, $s0 # (n<i)?$t0=1:$t0=0;
            bne $t0, $zero, exitfor # if (i>n) goto exitfor
            sll $t0, $s0, 2 # $t0 <- 4 * i
            add $t0, $t0, $a0 # $t0 <- @save[i]
            lw $t0, 0($t0) # $t0 <- save[i]
            beq $t0, $a1, exitfor # If (save[i]=k) goto exitfor
            addi $s0, $s0, 1 # ++i;
            j for

exitfor:    or $v0, $zero, $s0 # return i;
            jr $ra