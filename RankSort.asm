.text

.globl	main

main:
# Initialize registers
	li	$t1, 0
  li  $t2, 0
	li  $t3, 15
	li  $t4, 0
	j loop
	
negative:
loop:	
# Get value
	li	$v0,5		
	syscall	
	move $t0,$v0
#Only get positie numbers
	blt $t0, $t4, negative
	addi $t1, $t1, 1

#storing vetor
  sw $t0, values($t2)
  addi $t2, $t2, 4
	beq	$t3, $t1, exit	
	j	loop

	
exit:	
  li	$t1, 0		
	li  $t3, 60

coutingsort:
	li	$t2, 0
	li  $t4, 0
    lw $t0, values($t1)
    place:
#counting to each value how many numbers are smaller
        lw $t6, values($t2)
        ble $t0, $t6, smaller
        addi $t4, $t4, 4
        smaller:
        addi $t2, $t2, 4
        beq	$t2, $t3, exit1
        j place
    exit1:
#store on array in order 
        sw $t0, positions($t4)
        addi $t1, $t1, 4
        beq $t1, $t3, exit2
        j coutingsort
        
exit2: 
    li $t1, 0
    li $t2, 0
    li $t3, 60

    lw $t0, positions($t1)

#print first value
    li $v0, 1
    move $a0, $t0
    syscall
    # Print newline
	  li	$v0,4		
	  la	$a0, lf
	  syscall
	  li $t1, 4
printing:
#after first value, any value can't be equal zero
    lw $t0, positions($t1)
    beq $t0, $t2, jump 
#print
    li $v0, 1
    move $a0, $t0
    syscall
# Print newline
	  li	$v0,4		
	  la	$a0, lf
	  syscall
jump:
# jump to next position to not print values equal zero
    addi $t1, $t1, 4
    beq $t1, $t3, exit3
    j printing
    
exit3:
# Print newline
	li	$v0,4		
	la	$a0, lf
	syscall
	
	#ending
	li	$v0,10		# exit
	syscall


.data
    lf:     .asciiz	"\n"
    values: 
        .align 2
        .space 60
    positions:
        .align 2
        .space 60
