Using this instruction set, and for each of the following C++ instructions, write a program that simulates it:
1. A = 1;
2. A = A + 10;
3. A = A + B;

This machine is equipped with the following set of intructions:
- LOAD# <numeric value> ; direct loading of the register
- LOAD@ <memory address> ; loading the register from the memory
- STORE@ <memory address> ; store the register to the memory
- INCR ; increment the register
- DECR ; decrement the register
- JUMP <label> ; unconditional jump to label
- JZ <label> ; jump to label if (register ≤ 0)
- HALT ; stop the program

#### 1) A = 1;
```
LOAD# 1 ;
STORE@ 0 ;
```

#### 2) A = A + 10;
```
	LOAD# 10 ;
	STORE@ 2 ;
ADD : 	LOAD@ 0 ;
	INCR ;
	STORE@ 0 ;
	LOAD@ 2 ;
	DECR ;
	JZ FIN ;
	STORE@ 2 ;
	JUMP ADD ;
FIN : 	HALT ;
```
Other version ;
```
	LOAD# 10 ;
ADD : 	STORE@ 2 ;
	LOAD# 1 ;
	INCR ;
	STORE@ 0 ;
	LOAD@ 2 ;
	DECR ;
	JZ FIN ;
	JUMP ADD ;
FIN : 	HALT ;
```

#### 3) A = A + B;
```
	LOAD@ 1 ;
	JZ FIN ;
ADD : 	STORE@ 2 ;
	LOAD@ 0 ;
	INCR ;
	STORE@ 0 ;
	LOAD@ 2 ;
	DECR ;
	JZ FIN ;
	JUMP ADD ;
FIN : 	HALT ;
``` 
