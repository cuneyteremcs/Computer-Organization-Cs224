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
        
        la $a0,countMessage        	# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        li $v0, 6        		# syscall 6 reads a floating number
        syscall
        mov.s $f2,$f0			#move count value f0 to f2 
        

DisplayElements:
        # s0 N
        #f1 for total sum
        #f2 for count value
        #s3 is the count number
        move $a0,$t2        		# print integer result
        li $v0,1        		# using syscall 1
        syscall
        
        la $a0,displayString        	# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        
        l.s $f12,($t0)		#load floating number on given memory adress
        li $v0, 2        		# syscall 2 prints a floating number
        syscall
        
        add.s $f1,$f1,$f12		#sum all the numbers to f1
	
        la $a0,endl        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        addi $t0, $t0, 4		# array elements
        addi $t2, $t2, 1		#counter
        
        c.eq.s $f12,$f2		# if count value f2 == current value f12 i++ 
        bc1f Last
        addi $s3,$s3,1
        
Last:       
           bne $t2, $s0, DisplayElements    #if count == n
        
Exit:
 	mtc1 $s0, $f3		#move s0 (n) to f3 and convert
  	cvt.s.w $f3, $f3
	div.s $f1,$f1,$f3		# sum / number = average
        
        la $a0,averageMessage        	# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        
        mov.s $f12,$f1			
        li $v0, 2        		# syscall 2 prints a floating number
        syscall
        
        la $a0,endl        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        la $a0,countNumber        	# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        
        move $a0,$s3        		# print integer result
        li $v0,1        		# using syscall 1
        syscall
        
        li $v0,10        	# system call to exit
        syscall                	# bye bye

.data

countNumber: .asciiz "Count Number is: "
averageMessage: .asciiz "Average is: "
countMessage: .asciiz "Please Enter floating number that you want to count: "
mainMessage: .asciiz "Please Enter number of floating input N: "
memoryAdress: .word 0x10040000		
first: .asciiz "Please enter "
second: .asciiz " floating number: "
displayString: .asciiz ". floating number is : "
endl: .asciiz "\n"

