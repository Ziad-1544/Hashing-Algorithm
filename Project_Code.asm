#----->Program file: 2200278.asm
#----->DISCRIPTION: Computer organization summative task
#----->DATE: 15-DEC-2024
#----->VERSION: V1.0.0
#----->AUTHOR: ZIAD KASSEM    
.data


.text
	main:
		#argument for the function
		lw $a0, 0($a1)
		jal string_to_int
		jal hash_fn
		add $s0,$zero,$v0
		lui $t6 , 0x1001
		ori $t6 ,$t6, 0x0000
		sw  $v0 , 0($t6)
		#add $a0,$zero,$v0
		addi $v0,$zero,1     # Syscall for print_integer
		add $a0,$s0,$zero
    		syscall              # Print the integer
		# program termination
		addi $v0,$zero,10
		syscall
	# 8 bits  , 8 bits , 8 bits , 8 bits
	#   1st   ,  2nd   ,   3rd  , 4th
	hash_fn:
	#saving ra
	addi $sp,$sp,-4
	sw   $ra,0($sp)
	add $s0,$zero,$a0
	#-------------------------------
	#first byte
	jal stbyte
	add $s1,$v0,$zero
	add $a0,$zero,$s0
	#2nd byte
	jal ndbyte
	add $s2,$v0,$zero
	add $a0,$zero,$s0
	#3rd byte
	jal rdbyte
	add $s3,$v0,$zero
	add $a0,$zero,$s0
	#4th byte
	jal thbyte
	add $s4,$v0,$zero
	add $a0,$zero,$s0
	#--------------------------------
	#marker post every f(x)
	ori $t5,$zero,0x00ff
	#xor 1st with my id (78)
	xori $s1,$s1,0x78
	add $a0,$s1,$zero
	and $a0,$a0,$t5
	jal Fx
	and $v0,$v0,$t5
	add $s1,$v0,$zero
	#xor 2nd with s1
	xor $s2,$s2,$s1
	add $a0,$s2,$zero
	and $a0,$a0,$t5
	jal Fx
	and $v0,$v0,$t5
	add $s2,$v0,$zero
	#xor 3rd with s2
	xor $s3,$s3,$s2
	add $a0,$s3,$zero
	and $a0,$a0,$t5
	jal Fx
	and $v0,$v0,$t5
	add $s3,$v0,$zero
	#xor 4th with s3
	xor $s4,$s4,$s3
	add $a0,$s4,$zero
	and $a0,$a0,$t5
	jal Fx
	and $v0,$v0,$t5
	#v0 is already the return value for this func
	#loading ra
	lw   $ra,0($sp)
	addi $sp,$sp,4
	jr $ra
	#---------------------------------------
	stbyte:
	srl  $v0,$a0,24
	jr $ra
	
	ndbyte:
	sll  $t0,$a0,8
	srl  $v0,$t0,24
	jr $ra
	
	rdbyte:
	sll  $t0,$a0,16
	srl  $v0,$t0,24
	jr $ra
	
	thbyte:
	sll  $t0,$a0,24
	srl  $v0,$t0,24
	jr $ra
	
	#---------------------------------------
	Fx:
	#saving ra
	addi $sp,$sp,-4
	sw   $ra,0($sp)
	#48x^2 - 26x - 712
	#argument of squaring function
	add $a1 ,$zero, $a0 #hard coded 
	jal squaring
	add $a1 ,$zero, $v0 #hard coded 
	addi $a2,$zero ,48 
	jal multi
	add $t9 ,$zero, $v0 #hard coded   48x^2
	add $a1 ,$zero, $a0 #hard coded
	addi $a2,$zero ,26 
	jal multi
	add $t8 ,$zero, $v0 #hard coded   26x
	sub $t9,$t9,$t8     #48x^2-26x
	addi $t9,$t9,-712
	add $v0,$t9,$zero
	#loading ra
	lw   $ra,0($sp)
	addi $sp,$sp,4
	jr $ra
	#---------------------------------------
	squaring:
    	slt $at , $a1 ,$0
    	beq  $at,$zero,NonNega
	nor $a1 ,$a1,$zero
 	addi $a1 ,$a1 , 1
	NonNega:	add $t0,$a1,$zero
		add $t1,$a1,$zero
		add $t2,$zero ,$zero
    			loop: 	beq $t1, $zero, end_loop 
    				add $t2, $t2, $t0       
    				addi $t1, $t1, -1         
    				j loop          
			end_loop: add $v0,$t2,$zero
	jr $ra
	#---------------------------------------
	multi:
	add $t0,$a1,$zero
	add $t1,$a2,$zero
	add $t2,$zero ,$zero
    	loop2: 	beq $t1, $zero, end_loop2 
    		add $t2, $t2, $t0       
    		addi $t1, $t1, -1         
    		j loop2          
	end_loop2: add $v0,$t2,$zero
	jr $ra
	#---------------------------------------
string_to_int:
    addi $sp, $sp, -12   
    sw $ra, 8($sp)        
    sw $t0, 4($sp)        
    sw $t1, 0($sp)         

    add $v0, $zero, $zero 
    add $t1, $zero, $zero 
    add $t3, $zero, $zero 

    lb $t0, 0($a0)        
    addi $a0, $a0, 1     
    addi $t2,$zero, 45            
    beq $t0, $t2, is_negative

    addi $a0, $a0, -1     
    j convert_loop

is_negative:
    addi $t3, $zero, 1    

convert_loop:
    lb $t0, 0($a0)        
    beq $t0, $zero, end_convert 

    addi $t0, $t0, -48   

    # Multiply result by 10
    sll $t1, $v0, 1       
    sll $t2, $v0, 3        
    add $v0, $t1, $t2     
    add $v0, $v0, $t0     

    addi $a0, $a0, 1      
    j convert_loop         

end_convert:
    beq $t3, $zero, positive_result  
    sub $v0, $zero, $v0    

positive_result:
    add $a0, $v0, $zero  
    lw $ra, 8($sp)        
    lw $t0, 4($sp)         
    lw $t1, 0($sp)       
    addi $sp, $sp, 12     
    jr $ra                 

