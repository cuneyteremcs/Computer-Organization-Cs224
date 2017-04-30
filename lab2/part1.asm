.text

    .globl __start



__start:
        la $a0, mainMessage        	# output prompt message on terminal
        li $v0, 4        		# syscall 4 prints the string
        syscall

        li $v0, 5        		# syscall 5 reads an integer
        syscall

        move $s0, $v0			# s0 = N  (number of floating number)
        
        lw $s1, memoryAdress		#s1 = specific memory adress
        move $t0,$s1			#t0 = specific memory adress
        
AskElement:
        la $a0,first        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        move $a0,$t2        		# print integer result
        li $v0,1        		# using syscall 1
        syscall
        
        la $a0,second        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        li $v0, 6        		# syscall 6 reads a floating number
        syscall
        
        s.s $f0,0($t0)		#store floating number on given memory adress
        
        addi $t0, $t0, 4
        addi $t2, $t2, 1
        bne $t2, $s0, AskElement
        
        move $t2,$0
        move $t0,$s1

        li $v0,2        		# using syscall 1
        syscall
        

DisplayElements:
	# s0 N
        
        move $a0,$t2        		# print integer result
        li $v0,1        		# using syscall 1
        syscall
        
        la $a0,displayString        	# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        
        l.s $f12,($t0)		#load floating number on given memory adress
        li $v0, 2        		# syscall 2 prints a floating number
        syscall
	
        la $a0,endl        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        addi $t0, $t0, 4
        addi $t2, $t2, 1
        bne $t2, $s0, DisplayElements
   
Exit:
        li $v0,10        	# system call to exit
        syscall                	# bye bye

.data
mainMessage: .asciiz "Please Enter number of floating input N: "
memoryAdress: .word 0x100000F0		#268697600  #0x10040000
Invalid: .asciiz "You have entered an invalid value!!\n"
first: .asciiz "Please enter "
second: .asciiz " floating number: "
displayString: .asciiz ". floating number is : "
endl: .asciiz "\n"

