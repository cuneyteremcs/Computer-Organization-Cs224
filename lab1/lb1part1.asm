

#################################################
#					 	#
#		text segment			#
#						#
#################################################

	.text		
       	.globl __start	
__start:

	#lui  $t1, 0x1000	#loads 32 bits value (1) to $at 
	#ori  $t1, $t1, 0x8004	#ori will 0 extends the 0x0004 to 0x00000004
	li $t1, 0x10008004
	#li $t1, 0x00000004
	
	la $a0,prompt	# print prompt on terminal
	li $v0,4	#v0,4
	syscall		#syscall
		
	li $v0,5	# input v0'da
	syscall
	
	#move $s0, $v0
	move $t3, $v0
	
	la $a0,operationnames	# print maked operations in order
	li $v0,4		#li v0, 4
	syscall		#syscall
	
	add $t0, $t1, $t3 	#add
	move $a0,$t0
	li $v0,1		#li v0, 4
	syscall
	
	la $a0,endl	# print new line
	li $v0,4	#v0,4
	syscall
	
	sub $t0, $t1, $t3,	#subtract
	move $a0,$t0
	li $v0,1		#li v0, 4
	syscall
	
	la $a0,endl	# print new line
	li $v0,4	#v0,4
	syscall

	mul $t0, $t1, $t3	#mult
	move $a0,$t0
	li $v0,1		#li v0, 4
	syscall
	
	la $a0,endl	# print new line
	li $v0,4	#v0,4
	syscall
	
	div $t0, $t1, $t3	#div
	move $a0,$t0
	li $v0,1		#li v0, 4
	syscall
	
	la $a0,endl	# print new line
	li $v0,4	#v0,4
	syscall	
	
	and $t0, $t1, $t3	#and
	move $a0,$t0
	li $v0,1		#li v0, 4
	syscall
	
	la $a0,endl	# print new line
	li $v0,4	#v0,4
	syscall	
	
	or $t0, $t1, $t3	#or
	move $a0,$t0
	li $v0,1		#li v0, 4
	syscall
	
	la $a0,endl	# print new line
	li $v0,4	#v0,4
	syscall	
	
	sllv $t0, $t1, $t3	# sllv
	move $a0,$t0
	li $v0,1		#li v0, 4
	syscall
	
	la $a0,endl	# print new line
	li $v0,4	#v0,4
	syscall
	
	srlv $t0, $t1, $t3	# srlv
	move $a0,$t0
	li $v0,1		#li v0, 4
	syscall
	
	la $a0,endl	# print new line
	li $v0,4	#v0,4
	syscall

	lw $t1, word	# lw
	move $a0,$t1
	
	la $a0,endl	# print new line
	li $v0,4	#v0,4
	syscall
	
	sw $t1, word	# sw
	move $a0,$t1
	li $v0,1		#li v0, 4
	syscall
	
	.data
prompt:	.asciiz "Enter a number: "
operationnames: .asciiz "add, sub, mult, div, and, or, \n leftshift, rightshift, load word, store word \n"
endl: 	.asciiz "\n"
word: 	.word 1234

##
## end of file temp.a
