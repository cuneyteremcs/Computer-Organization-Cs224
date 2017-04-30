


#################################################
#					 	#
#		text segment			#
#						#
#################################################

	.text		
       	.globl __start	
__start:
	
	li $t0, 1 	# value
	li $t1, 1	# count	
	li $t3, 1

	la $a0,prompt	
	li $v0,4	
	syscall
	
	la $a0,endl	# print new line
	li $v0,4	#v0,4
	syscall

	li $v0,5	
	syscall		
	
	move $s0, $v0
	move $t1, $v0
	move $t0, $v0
	
	beq $s0, $0, end
	
	add $t2, $v0 ,1		# t2 is v0 +1 for bne

target: 	
	sub $t1,$t1,1
	mul $t0,$t0,$t1 	
	        			
	bne $t1,$t3,target
	
		
	la $a0,str	
	li $v0,4	
	syscall

	move $a0,$t0

	li $v0,1	
	syscall	
	
	la $a0,endl	# print new line
	li $v0,4	#v0,4
	syscall
	
	j __start
end:

	la $a0,endl	# print new line
	li $v0,4	#v0,4
	syscall
	
	la $a0,endmessage	
	li $v0,4	
	syscall

	.data
prompt:	.asciiz "Enter a number: "
prompt2:	.asciiz "Enter a number: "
endl: 	.asciiz "\n"
str:	.asciiz "Factorial is "
endmessage: .asciiz "End of the line"

##
## end of file temp.a


