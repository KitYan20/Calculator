	.intel_syntax noprefix
	.data
char:
	.quad 0
	.text
	.global atq_func
atq_func:
	xor r9, r9 #the string to walk through
	xor r11,r11 #counter for the string
	xor rcx, rcx #hold one character number
	xor r13,r13 #set register to 0
	xor r8,r8 # set register to 0
	push rbx #push rbx to stack to preserve the past memory address to get the next string
	mov r9, QWORD PTR [rbx] #load the current string to r9
	xor rcx, rcx #set register to 0
loop_start:
	cmp BYTE PTR [r9+ r11], '-' #checks if the string has a - character to indicate it's negative
	je negative #jump to a negative label to compute it negatively

	cmp BYTE PTR [r9+r11], '0' #checks if it's not a number ascii value before 0
	jb sum #jump to our sum label in order to start updating SUM_POSITIVE and SUM_NEGATIVE
	
	cmp BYTE PTR [r9+r11], '9' #checks if it's not a numer ascii value after 9
	ja sum #jump to our sum label in order to start updating SUM_POSITIVE and SUM_NEGATIVE
	
	mov cl, BYTE PTR [r9+r11] #move the ascii number character a 8 bit register
	sub cl, '0' #subtract to convert from the ascii value of 0 to get the integer
	
	imul r8,10 #Multiply by multiples of 10 in order to add new integers to a previous number
	
	add r8, rcx #add the converted integer to r8
	
	inc r11 #increment r11 to get the next character
	
	jmp loop_start #jump back to loop to repeat the prcoess again
sum:
	mov QWORD PTR [char], r8 # move the converted integer with a pointer to a 8 byte value located in char

	mov rbx, OFFSET [char] #move the memory address of the label to rbx

	call func_sum #call our sum.s to update sum negative and sum positive

	jmp loop_end #jump to the end to indicate the end of the conversion
negative: 
	inc r11 # increment r11 to move to the next character because we're not converting -

	cmp BYTE PTR [r9+r11], '0' #checks if it's not a number ascii value before 0
	jb sumn #jumps to sumn label indicating it's the end of the string and call the sum function.

	cmp BYTE PTR [r9+r11], '9' #checks if it's not a number ascii value after 9
	ja sumn #jumps to sumn label indicating it's the end of the string and call the sum function.

	mov cl, BYTE PTR [r9+r11] #move one byte character number to an 1 BYTE register
	
	sub cl, '0' #subtract the ascii value in cl to the ascii value of '0' to get the integer form
	
	sub r15, rcx #subtract an open register with a 0 to rcx holding the integer to make it negative
	 
	imul r13, 10 #Multiply by multiples of 10 in order to add new integers to a previous number
	#r13 = 4
	#r13 = r13 * 10
	# r13 = 4 * 10
	add r13, r15 #add the current integer to the previous integer. Ex: 42 = 40 + 2
	#r13 = 40
	#r15 = 2
	#r13 = 40 + 2
	xor r15,r15 # reset the register r15 to 0 to convert it negative again
	
	jmp negative #jump back to the start of the negative label to loop through the process again
	
sumn:
	mov QWORD PTR [char], r13 #load the converted negative integer to the char label in data
	mov rbx, OFFSET [char] #load the memory address of the char label for rbx to have when we use sum
	call func_sum #call the sum function to compute the sum and update SUM_POSITIVE and SUM_NEGATIVE
	jmp loop_end #end of the process converting ascii strings to integers
loop_end:
	pop rbx #pop the stack to get the previous memory address in the calc files in order to get the next set of data
	add rbx,8 #add rbx 8 bytes in order to get the next BYTE character command to compare
	ret #return back to the location of where call the atoq function
