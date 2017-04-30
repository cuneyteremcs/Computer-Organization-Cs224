.text

    .globl __start



__start:
        la $a0, mainMessage        	# output prompt message on terminal
        li $v0, 4        		# syscall 4 prints the string
        syscall

        li $v0, 5        		# syscall 5 reads an integer
        syscall

        move $s0, $v0			# s0 = N

GetElements:
        sll $a0, $s0, 2                	#allocate this many bytes a0 = 4*s0

        li $v0, 9         		#allocate bytes in heap syscall
        syscall               		#address stored in the heap

        move $s1, $v0 			#Base address s1 = Base Adress
        move $a2, $v0 			#Base address a2 = Base Adress
        move $t2,$0
        
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
        
        li $v0, 5        		# syscall 5 reads an integer
        syscall
        
        sw $v0, 0($a2)
        addi $a2, $a2, 4
        addi $t2, $t2, 1
        bne $t2, $s0, AskElement
        
Sorting:
    move  $t0, $s1      		# Copy the base address of your array into $t1
    sll $a0, $s0, 2                	#allocate this many bytes a0 = 4*s0
    add $t0, $t0, $a0    		# 4 bytes per int * N ints = 4*N bytes    
    addi $t0, $t0, -4   
                           
outterLoop:             		# Used to determine when we are done iterating over the Array
    add $t1, $0, $0     		# $t1 holds a flag to determine when the list is sorted
    move  $a0, $s1     			# Set $a0 to the base address of the Array
    
innerLoop:                  		# The inner loop will iterate over the Array checking if a swap is needed
    lw  $t2, 0($a0)         		# sets $t2 to the current element in array
    lw  $t3, 4($a0)         		# sets $t3 to the next element in array
    slt $t5, $t3, $t2       		# $t5 = 1 if $t3 < $t2
    beq $t5, $0, continue   		# if $t5 = 1, then swap them
    add $t1, $0, 1          		# if we need to swap, we need to check the list again
    sw  $t2, 4($a0)         		# store the greater numbers contents in the higher position in array (swap)
    sw  $t3, 0($a0)         		# store the lesser numbers contents in the lower position in array (swap)
continue:
    addi $a0, $a0, 4            	# advance the array to start at the next location from last time
    bne  $a0, $t0, innerLoop    	# If $a0 != the end of Array, jump back to innerLoop
    bne  $t1, $0, outterLoop    	# $t1 = 1, another pass is needed, jump back to outterLoop

    move $t2,$0
    move $s3, $s1 			#Base address s3 = Base Adress
    
    la $a0,arraySorted        		# output prompt message on terminal
    li $v0,4        			# syscall 4 prints the string
    syscall


DisplayElements:
	# s0 N
	# s1 BASE ADRESS
        
        move $a0,$t2        		# print integer result
        li $v0,1        		# using syscall 1
        syscall
        
        la $a0,displayString        	# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        
	lw $a0, 0($s3)
        li $v0, 1        		# syscall 1 prints an integer
        syscall
	
        la $a0,endl        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        addi $s3, $s3, 4
        addi $t2, $t2, 1
        bne $t2, $s0, DisplayElements
 Menu:
        la $a0,endl        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
 	la $a0, menuMessage        	# output prompt message on terminal
        li $v0, 4        		# syscall 4 prints the string
        syscall

        li $v0, 5        		# syscall 5 reads an integer
        syscall
        
        move $s2, $v0			#s2 load the option
        
       	lw $a1, 0($s1)			# a1 is the smallest value
       	
    	move  $t0, $s1      		# Copy the base address of your array into $t1
    	sll $a2, $s0, 2                	# a2 = 4*s0
    	add $a2, $t0, $a2    		# 4 bytes per int * N ints = 4*N bytes    
    	addi $a2, $a2, -4   
       	lw $a2, 0($a2)			# a2 is the largest value
       	
       	
       	div  $a3,$s0,2			# a3 = N /2
    	sll $a3, $a3, 2                	#  a3 = N/2 * 4
    	add $a3, $t0, $a3    		# 2 bytes per int * N ints = 2*N bytes    
       	lw $a3, 0($a3)			# a3 is the median value
       	
       	
    	move $t2,$0
    	move $s3, $s1 			#Base address s3 = Base Adress

        addi $t0, $0, 2
        beq $v0, $t0, PrintMedian
        addi $t0, $0, 3
        beq $v0, $t0, PrintSmallest
        addi $t0, $0, 4
        beq $v0, $t0, PrintLargest
        addi $t0, $0, 5
        beq $v0, $t0, AverageOf
        addi $t0, $0, 6
        beq $v0, $t0, DisplayElements
        addi $t0, $0, 10
        beq $v0, $t0, Exit
        j Calculation
        
Exit:
        li $v0,10        	# system call to exit
        syscall                	# bye bye
 
Calculation:
	#s4 represent the sum
	#s5 represent the negative number of element
	#s6 represent the lower list
	#s7 represent the upper list
	#t0 represent the current element
	#t1 represent the half of the list
	#t2 represent the index number of the element
	add $s4,$0,$0
	add $s5,$0,$0
	add $s6,$0,$0
	add $s7,$0,$0
       	div  $t1,$s0,2				# t1 = N /2
Loop:
	lw $t0, 0($s3)				#load the element
	
	add $s4,$s4,$t0
	
    	slt $t5, $t0, $0       				# $t5 = 1 if $t0 < 0
    	beq $t5, $0, nextOption   			# if $t5 = 1, then increase negative number
    	addi $s5,$s5,1
	
	nextOption:
    		slt $t5, $t2, $t1       		# $t5 = 1 if $t2 < $t1
    		beq $t5, $0, increaseUpper   		# if $t5 = 1, then increase lower sum
    		add $s6,$s6,$t0
    		j final
    	increaseUpper:
    		add $s7,$s7,$t0
        final:
        	addi $s3, $s3, 4
        	addi $t2, $t2, 1
        	bne $t2, $s0, Loop
       	#calculate the average
       	div  $s4,$s4,$s0			# s4 = mean value	
       	div  $s6,$s6,$t1			# s6 = mean value of lower list	
       	div  $s7,$s7,$t1			# s7 = mean value of upper list	
       
        # end of calculation
        addi $t0, $0, 1
        beq $s2, $t0, PrintMeanValue
        addi $t0, $0, 7
        beq $s2, $t0, PrintNegativeValues
        addi $t0, $0, 8
        beq $s2, $t0, PrintAverageLower
        addi $t0, $0, 9
        beq $s2, $t0, PrintAverageUpper
        
PrintMeanValue:
        la $a0,mean        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        move $a0,$s4        		# print integer result
        li $v0,1        		# using syscall 1
        syscall
        
	j Menu
PrintNegativeValues:
        la $a0,negativeCount        	# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        move $a0,$s5       		# print integer result
        li $v0,1        		# using syscall 1
        syscall
        
	j Menu	
PrintAverageLower:
        la $a0,lower        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        move $a0,$s6        		# print integer result
        li $v0,1        		# using syscall 1
        syscall
        
	j Menu	
	
PrintAverageUpper:
        la $a0,upper        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        move $a0,$s7        		# print integer result
        li $v0,1        		# using syscall 1
        syscall
        
	j Menu	

	
PrintMedian:
        la $a0,median        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        move $a0,$a3        		# print integer result
        li $v0,1        		# using syscall 1
        syscall
        
	j Menu
PrintSmallest:
        la $a0,smallest        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        move $a0,$a1        		# print integer result
        li $v0,1        		# using syscall 1
        syscall
        
	j Menu
PrintLargest:
        la $a0,largest        		# output prompt message on terminal
        li $v0,4        		# syscall 4 prints the string
        syscall
        
        move $a0,$a2        		# print integer result
        li $v0,1        		# using syscall 1
        syscall
        
	j Menu
AverageOf:
        la $a0,averageMessage        		# output prompt message on terminal
        li $v0,4        			# syscall 4 prints the string
        syscall
        
        add $a0,$a1,$a2
        add $a0,$a0,$a3
        div  $a0,$a0,3
        li $v0,1        			# using syscall 1
        syscall
        
	j Menu	

        
        

.data
mainMessage: .asciiz "Please Enter N number:\n"
Invalid: .asciiz "You have entered an invalid value!!\n"
first: .asciiz "Please enter "
second: .asciiz " element: "
arraySorted: .asciiz " Array is sorted : \n"
displayString: .asciiz " element is : "
endl: .asciiz "\n"
menuMessage: .asciiz "1.Mean Value   2.Median Value   3.Smallest Value   4.Largest Value\n5.Average of Smallest Largest and Median   6.Display all Values   7.Number of Negative Values   8.Average of Lower half-List   9.Average of Upper half-list\n10.None of these\nPlease chose an option : "


median: .asciiz "Median Value is : "
smallest: .asciiz "Smallest Value is : "
largest: .asciiz "Largest Value is : "
averageMessage: .asciiz "Average of Smallest Largest and Median is : "
mean: .asciiz "Mean Value is : "
negativeCount: .asciiz "Number of Negative number is : "
lower: .asciiz "Average of lower list is : "
upper: .asciiz "Average of upper list is : "

