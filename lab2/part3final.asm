.text

    .globl __start



__start:
        la $a0, mainMessage        	# output prompt message on terminal
        li $v0, 4        		# syscall 4 prints the string
        syscall

        li $v0, 5        		# syscall 5 reads an integer
        syscall

        move $s0, $v0			# s0 = N  (matrix sizes)
        
createMemoryLocation:
	mul $s3, $s0,$s0		#s3 number of elements in the matrix
        sll $a0, $s3, 2                	#allocate this many bytes a0 = 4*s0*s0

        li $v0, 9         		#allocate bytes in heap syscall
        syscall               		#address stored in the heap
        move $s1, $v0 			#Base address s1 = A array base adress
        
        li $v0, 9         		#allocate bytes in heap syscall
        syscall               		#address stored in the heap
        move $s2, $v0 			#Base address s2 = B array base adress
        
        
        la $a0,AMatrix        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
       	addi $t0,$0,0			#t0 for row number 
       	addi $t2,$s1,0 			#t2 for base adress
AskAMatrixElement:
       	addi $t1,$0,0 			#t1 for column number
AColumn:
        move $a0,$t0        		# print integer result
        li $v0,1        		# using syscall 1
        syscall
        
        la $a0,row        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        move $a0,$t1        		# print integer result
        li $v0,1        		# using syscall 1
        syscall
        
        la $a0,column        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        li $v0, 6        		# syscall 6 reads a floating number
        syscall
        
        s.s $f0,0($t2)			#store floating number on given memory base adress
        addi $t2, $t2, 4
        addi $t1, $t1, 1
        bne $t1, $s0, AColumn
        addi $t0, $t0, 1
        bne $t0, $s0, AskAMatrixElement
        
        
       	la $a0,BMatrix        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
       	addi $t0,$0,0			#t0 for row number 
       	addi $t2,$s2,0 			#t2 for base adress
AskBMatrixElement:
       	addi $t1,$0,0 			#t1 for column number
BColumn:
        move $a0,$t0        		# print integer result
        li $v0,1        		# using syscall 1
        syscall
        
        la $a0,row        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        move $a0,$t1        		# print integer result
        li $v0,1        		# using syscall 1
        syscall
        
        la $a0,column        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        li $v0, 6        		# syscall 6 reads a floating number
        syscall
        
        s.s $f0,0($t2)			#store floating number on given memory base adress
        addi $t2, $t2, 4
        addi $t1, $t1, 1
        bne $t1, $s0, BColumn
        addi $t0, $t0, 1
        bne $t0, $s0, AskBMatrixElement
        
        
        la $a0,AMatrixDisplay        	# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        
       	addi $t0,$0,0			#t0 for row number 
       	addi $t2,$s1,0 			#t2 for base adress
       	
DisplayA:
       	addi $t1,$0,0 			#t1 for column number
AColumnDisplay:

        l.s $f12,($t2)			#load floating number on given memory adress
        li $v0, 2        		# syscall 2 prints a floating number
        syscall
        
        
        la $a0,oneSpace        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        addi $t2, $t2, 4
        addi $t1, $t1, 1
        bne $t1, $s0, AColumnDisplay
        
        la $a0,endl        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        addi $t0, $t0, 1
        bne $t0, $s0, DisplayA
        
        la $a0,BMatrixDisplay        	# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
       	addi $t0,$0,0			#t0 for row number 
       	addi $t2,$s2,0 			#t2 for base adress
       	
DisplayB:
       	addi $t1,$0,0 			#t1 for column number
BColumnDisplay:

        l.s $f12,($t2)			#load floating number on given memory adress
        li $v0, 2        		# syscall 2 prints a floating number
        syscall
        
        
        la $a0,oneSpace        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        addi $t2, $t2, 4
        addi $t1, $t1, 1
        bne $t1, $s0, BColumnDisplay
        
        la $a0,endl        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        addi $t0, $t0, 1
        bne $t0, $s0, DisplayB
        
        la $a0,DifferenceMatrixDisplay  # output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
       	addi $t0,$0,0			#t0 for row number 
       	addi $t2,$s1,0 			#t2 for base adress
       	addi $t3,$s2,0 			#t3 for base adress
       	
DisplayDifference:
       	addi $t1,$0,0 			#t1 for column number
DifferenceColumnDisplay:

        l.s $f11,($t3)			#load floating number on given memory adress
        l.s $f12,($t2)			#load floating number on given memory adress
        sub.s $f12,$f12,$f11
        li $v0, 2        		# syscall 2 prints a floating number
        syscall
        
        
        la $a0,oneSpace        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        addi $t2, $t2, 4
        addi $t3, $t3, 4
        addi $t1, $t1, 1
        bne $t1, $s0, DifferenceColumnDisplay
        
        la $a0,endl        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        addi $t0, $t0, 1
        bne $t0, $s0, DisplayDifference
        
        
        la $a0,MultipleMatrixDisplay  	# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
       	addi $t0,$0,0			#t0 for row number 
       	addi $t2,$s1,0 			#t2 for base adress for A
       	addi $t3,$s2,0 			#t3 for base adress for B
        sll $s4, $s0, 2                	#4*N
       	
        sll $s3, $s3, 2                	#4*N*N
        add $s3,$s3,$s2
       	
       	
DisplayMultiple:
       	addi $t1,$0,0 			#t1 for column number
       	addi $t3,$s2,0 			#t3 for base adress for B
MultiplyColumnDisplay:
	move $t4,$t2			#Represent A matrix
	move $t5,$t3			#Represent B matrix
	mul.s $f5,$f5,$f6		#F5 = 0
MultipleCalculation:
	
        l.s $f11,($t4)			#load floating number on given memory adress
        l.s $f12,($t5)			#load floating number on given memory adress
	mul.s $f12,$f11,$f12		
	add.s $f5,$f5,$f12
	
        addi $t4, $t4, 4
        add $t5, $t5, $s4
	
    	slt $t6, $s3, $t5       			# $t6 = 1 if $s3 < $t5
    	beq $t6, $0, MultipleCalculation   		# if $t6 = 0, then contiune calculation
	
	mov.s $f12,$f5
        li $v0, 2        		# syscall 2 prints a floating number
        syscall
        
        la $a0,oneSpace        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        addi $t3, $t3, 4
        addi $t1, $t1, 1
        bne $t1, $s0, MultiplyColumnDisplay
        
        la $a0,endl        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        add $t2, $t2, $s4
        addi $t0, $t0, 1
        bne $t0, $s0, DisplayMultiple
        
        
Exit:
        li $v0,10        	# system call to exit
        syscall                	# bye bye

.data
mainMessage: .asciiz "Please Enter matrix sizes N: "
AMatrix: .asciiz "Please Enter A matrix elements: \n"
BMatrix: .asciiz "Please Enter B matrix elements: \n"
AMatrixDisplay: .asciiz "A Matrix is: \n"
BMatrixDisplay: .asciiz "B Matrix is: \n"
DifferenceMatrixDisplay: .asciiz "Difference Matrix is: \n"
MultipleMatrixDisplay: .asciiz "Multiple Matrix is: \n"
oneSpace: .asciiz "\t"
row: .asciiz ". row "
column: .asciiz ". column element:  "
endl: .asciiz "\n"

